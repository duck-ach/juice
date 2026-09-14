import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/constants/category_assets.dart';
import '../data/models/category.dart';
import '../data/repositories/category_repository.dart';
import 'expense_provider.dart';

final categoryRepositoryProvider =
    Provider<CategoryRepository>((ref) => CategoryRepository());

/// [CategoryNotifier.remove] 결과. 호출부에서 이 값에 따라 안내 메시지를 분기한다.
enum CategoryRemoveResult {
  /// 삭제 완료.
  removed,

  /// 기본 제공 카테고리라 삭제할 수 없음.
  isDefault,

  /// 이 카테고리를 사용 중인 수입 내역이 있어 삭제를 막음(수입 카테고리 한정).
  inUse,
}

class CategoryNotifier extends Notifier<List<Category>> {
  @override
  List<Category> build() => ref.read(categoryRepositoryProvider).getAll();

  /// 새 커스텀 카테고리를 생성하고 새로 생성된 id를 반환한다.
  Future<String> addCustom({
    required String name,
    required int colorValue,
    required int iconCodePoint,
    String? iconFontFamily = 'MaterialIcons',
    String description = CategoryAssets.defaultCustomDescription,
    CategoryType type = CategoryType.expense,
  }) async {
    final repo = ref.read(categoryRepositoryProvider);
    final nextOrder = state.isEmpty
        ? 0
        : state.map((c) => c.orderIndex).reduce((a, b) => a > b ? a : b) + 1;
    final category = Category(
      id: const Uuid().v4(),
      name: name,
      iconCodePoint: iconCodePoint,
      iconFontFamily: iconFontFamily,
      colorValue: colorValue,
      description: description,
      orderIndex: nextOrder,
      type: type,
    );
    await repo.add(category);
    state = repo.getAll();
    return category.id;
  }

  /// 기존 카테고리(기본 카테고리 포함)의 이름/설명/색상/아이콘을 수정한다.
  Future<void> update(Category updated) async {
    final repo = ref.read(categoryRepositoryProvider);
    await repo.add(updated);
    state = repo.getAll();
  }

  /// 기본 제공 카테고리는 삭제할 수 없고, 수입 카테고리는 이미 사용 중인 수입 내역이
  /// 있으면 삭제를 막는다(지출 카테고리는 기존과 동일하게 기록은 유지한 채 삭제 허용).
  Future<CategoryRemoveResult> remove(String id) async {
    final repo = ref.read(categoryRepositoryProvider);
    final matches = state.where((c) => c.id == id);
    if (matches.isEmpty) return CategoryRemoveResult.removed;
    final category = matches.first;
    if (category.isDefault) return CategoryRemoveResult.isDefault;

    if (category.type == CategoryType.income) {
      final inUse = ref
          .read(expenseProvider)
          .any((e) => e.isIncome && e.categoryId == id);
      if (inUse) return CategoryRemoveResult.inUse;
    }

    await repo.delete(id);
    state = repo.getAll();
    return CategoryRemoveResult.removed;
  }

  /// 드래그로 재정렬된 전체 목록을 받아 위치대로 orderIndex를 다시 부여하고 저장한다.
  Future<void> reorder(List<Category> reordered) async {
    final repo = ref.read(categoryRepositoryProvider);
    for (var i = 0; i < reordered.length; i++) {
      if (reordered[i].orderIndex != i) {
        reordered[i].orderIndex = i;
        await repo.add(reordered[i]);
      }
    }
    state = repo.getAll();
  }
}

final categoryProvider =
    NotifierProvider<CategoryNotifier, List<Category>>(CategoryNotifier.new);

/// 지출 카테고리 목록(표시 순서대로).
final expenseCategoriesProvider = Provider<List<Category>>((ref) => ref
    .watch(categoryProvider)
    .where((c) => c.type == CategoryType.expense)
    .toList());

/// 수입 카테고리 목록(표시 순서대로).
final incomeCategoriesProvider = Provider<List<Category>>((ref) => ref
    .watch(categoryProvider)
    .where((c) => c.type == CategoryType.income)
    .toList());
