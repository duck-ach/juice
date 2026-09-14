import 'package:hive/hive.dart';

import 'budget_period.dart';
import 'expense.dart';

part 'juice_saving_history.g.dart';

/// 마감된 목표 주기(일/주/월) 하나의 정산 메타데이터. 의도적으로 spentAmount/savedAmount는
/// 저장하지 않는다 — 과거 지출이 뒤늦게 추가/수정/삭제되거나 목표 금액이 바뀌어도 항상
/// 최신 지출 데이터를 기준으로 동적으로 다시 계산되도록([JuiceSavingHistoryCalc] 참고),
/// 주기 경계(startDate~endDate)와 마감 당시의 목표량/테마만 스냅샷으로 남긴다.
@HiveType(typeId: 4)
class JuiceSavingHistory extends HiveObject {
  JuiceSavingHistory({
    required this.id,
    required this.periodType,
    required this.startDate,
    required this.endDate,
    required this.targetAmount,
    required this.themeEmoji,
  });

  /// 고유 식별자(예: 'weekly_20260907'). periodType+startDate로 결정되어 같은 주기가
  /// 중복 생성되지 않도록 막는 키 역할도 겸한다.
  @HiveField(0)
  String id;

  /// [BudgetPeriod.name] 문자열. 주기를 나중에 바꿔도 마감 당시의 주기 유형이 보존된다.
  @HiveField(1)
  String periodType;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime endDate;

  /// 마감 시점 기준 목표량(mL) 스냅샷. 이후 목표 금액을 바꿔도 이 기록은 영향받지 않는다.
  @HiveField(4)
  double targetAmount;

  /// 마감 시점의 주스 테마 대표 과일 이모지 스냅샷.
  @HiveField(5)
  String themeEmoji;

  BudgetPeriod get periodTypeEnum => BudgetPeriod.values.firstWhere(
        (p) => p.name == periodType,
        orElse: () => BudgetPeriod.weekly,
      );
}

/// [JuiceSavingHistory]의 실시간 소비/절약 계산. [allExpenses]를 매번 전달받아 계산하므로
/// 호출 시점의 최신 지출 목록을 반영한다(재계산 로직 별도 동기화 불필요).
extension JuiceSavingHistoryCalc on JuiceSavingHistory {
  /// 주기 범위 내 변동지출 합계(고정지출·수입 제외) — 홈 화면 주스 게이지와 동일한 기준.
  double spentAmount(List<Expense> allExpenses) => allExpenses
      .where((e) =>
          !e.isIncome &&
          !e.isFixed &&
          !e.date.isBefore(startDate) &&
          !e.date.isAfter(endDate))
      .fold(0.0, (sum, e) => sum + e.amount);

  double savedAmount(List<Expense> allExpenses) {
    final saved = targetAmount - spentAmount(allExpenses);
    return saved > 0 ? saved : 0;
  }

  bool isSuccess(List<Expense> allExpenses) =>
      spentAmount(allExpenses) <= targetAmount;
}
