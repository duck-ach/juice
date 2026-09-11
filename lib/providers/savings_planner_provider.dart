import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';

const _savingsPlanKey = 'savingsPlan';

class FixedExpenseItem {
  const FixedExpenseItem({required this.name, required this.amount});

  final String name;
  final double amount;

  Map<String, dynamic> toJson() => {'name': name, 'amount': amount};

  factory FixedExpenseItem.fromJson(Map<String, dynamic> json) =>
      FixedExpenseItem(
        name: json['name'] as String? ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
      );
}

const defaultFixedExpenseNames = ['월세', '통신비', '보험료', '구독료'];

/// 중/장기 저축 목표 플래너 입력값. 월 수입/고정지출/목표를 바탕으로
/// "스마트 주스 용량"(월·주·일 변동지출 예산)을 계산하는 데 쓰인다.
class SavingsPlan {
  const SavingsPlan({
    this.enabled = false,
    this.monthlyIncome,
    this.goalYears = 0,
    this.goalMonths = 0,
    this.goalAmount,
    this.fixedExpenses = const [],
  });

  final bool enabled;
  final double? monthlyIncome;
  final int goalYears;
  final int goalMonths;
  final double? goalAmount;
  final List<FixedExpenseItem> fixedExpenses;

  int get totalMonths => goalYears * 12 + goalMonths;

  /// 위저드를 끝까지 완료해 실제로 계산 가능한 상태인지.
  bool get isComplete =>
      (monthlyIncome ?? 0) > 0 && (goalAmount ?? 0) > 0 && totalMonths > 0;

  double get fixedExpenseTotal =>
      fixedExpenses.fold(0.0, (sum, e) => sum + e.amount);

  /// 월 가용 생활비(= 스마트 주스 용량) = 월 수입 - 고정지출 합계 - (목표 금액 / 총 개월 수).
  /// 입력이 아직 부족하면 null.
  double? get monthlyAvailable {
    if (monthlyIncome == null || goalAmount == null || totalMonths <= 0)
      return null;
    final monthlySavingNeeded = goalAmount! / totalMonths;
    return monthlyIncome! - fixedExpenseTotal - monthlySavingNeeded;
  }

  double? get dailyAvailable =>
      monthlyAvailable == null ? null : monthlyAvailable! / 30;

  double? get weeklyAvailable =>
      dailyAvailable == null ? null : dailyAvailable! * 7;

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'monthlyIncome': monthlyIncome,
        'goalYears': goalYears,
        'goalMonths': goalMonths,
        'goalAmount': goalAmount,
        'fixedExpenses': fixedExpenses.map((e) => e.toJson()).toList(),
      };

  factory SavingsPlan.fromJson(Map<String, dynamic> json) => SavingsPlan(
        enabled: json['enabled'] as bool? ?? false,
        monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble(),
        goalYears: json['goalYears'] as int? ?? 0,
        goalMonths: json['goalMonths'] as int? ?? 0,
        goalAmount: (json['goalAmount'] as num?)?.toDouble(),
        fixedExpenses: (json['fixedExpenses'] as List<dynamic>? ?? [])
            .map((e) =>
                FixedExpenseItem.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
      );

  static List<FixedExpenseItem> get defaultFixedExpenses =>
      defaultFixedExpenseNames
          .map((n) => FixedExpenseItem(name: n, amount: 0))
          .toList();
}

class SavingsPlanNotifier extends Notifier<SavingsPlan> {
  @override
  SavingsPlan build() {
    final raw = Hive.box(HiveBoxes.settings).get(_savingsPlanKey) as String?;
    if (raw == null)
      return SavingsPlan(fixedExpenses: SavingsPlan.defaultFixedExpenses);
    try {
      return SavingsPlan.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return SavingsPlan(fixedExpenses: SavingsPlan.defaultFixedExpenses);
    }
  }

  Future<void> update(SavingsPlan plan) async {
    await Hive.box(HiveBoxes.settings)
        .put(_savingsPlanKey, jsonEncode(plan.toJson()));
    state = plan;
  }
}

final savingsPlanProvider =
    NotifierProvider<SavingsPlanNotifier, SavingsPlan>(SavingsPlanNotifier.new);
