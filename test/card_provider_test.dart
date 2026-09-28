// CardNotifier.remove의 "기본 카드는 같은 종류(체크/신용)의 다른 카드가 1개 이상
// 있을 때만 삭제 가능" 규칙을 검증한다. 카드가 아예 없어지는 걸 막으면서도,
// 유저가 대체 카드를 등록해두면 기본 제공 카드를 정리할 수 있어야 한다.
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:juice/data/local/hive_service.dart';
import 'package:juice/data/models/card_item.dart';
import 'package:juice/providers/card_provider.dart';

void _registerAdaptersOnce() {
  if (Hive.isAdapterRegistered(3)) return;
  Hive.registerAdapter(CardItemAdapter());
}

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = Directory.systemTemp.createTempSync('card_provider_verify');
    Hive.init(tempDir.path);
    _registerAdaptersOnce();
    final box = await Hive.openBox<CardItem>(HiveBoxes.cards);
    await box.put(
        'default_check',
        CardItem(
            id: 'default_check',
            name: '체크카드 (기본)',
            type: CardType.check,
            colorValue: 0xFF00A8FF,
            isDefault: true,
            orderIndex: 0));
    await box.put(
        'default_credit',
        CardItem(
            id: 'default_credit',
            name: '신용카드 (기본)',
            type: CardType.credit,
            colorValue: 0xFFFF7A00,
            isDefault: true,
            orderIndex: 1));
  });

  tearDown(() async {
    await Hive.close();
    tempDir.deleteSync(recursive: true);
  });

  test('같은 종류의 다른 카드가 없으면 기본 카드는 삭제되지 않는다', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(cardProvider.notifier).remove('default_check');

    final remaining = container.read(cardProvider);
    expect(remaining.any((c) => c.id == 'default_check'), true,
        reason: '체크카드가 default_check 하나뿐이므로 삭제되지 않아야 함');
  });

  test('같은 종류의 다른 카드를 추가하면 기본 카드를 삭제할 수 있다', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(cardProvider.notifier).addCustom(
        name: 'C체크카드', type: CardType.check, colorValue: 0xFF3388FF);
    await container.read(cardProvider.notifier).remove('default_check');

    final remaining = container.read(cardProvider);
    expect(remaining.any((c) => c.id == 'default_check'), false,
        reason: '다른 체크카드가 생겼으므로 기본 체크카드는 삭제되어야 함');
  });

  test('다른 종류(신용)의 카드를 추가해도 체크카드 기본값 삭제는 여전히 막힌다', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(cardProvider.notifier).addCustom(
        name: 'B신용카드', type: CardType.credit, colorValue: 0xFFFF3388);
    await container.read(cardProvider.notifier).remove('default_check');

    final remaining = container.read(cardProvider);
    expect(remaining.any((c) => c.id == 'default_check'), true,
        reason: '체크카드는 여전히 default_check 하나뿐이므로 삭제되지 않아야 함');
  });

  test('커스텀(비기본) 카드는 유일해도 항상 삭제할 수 있다', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final id = await container
        .read(cardProvider.notifier)
        .addCustom(name: 'C체크카드', type: CardType.check, colorValue: 0xFF3388FF);
    await container.read(cardProvider.notifier).remove(id);

    final remaining = container.read(cardProvider);
    expect(remaining.any((c) => c.id == id), false);
  });
}
