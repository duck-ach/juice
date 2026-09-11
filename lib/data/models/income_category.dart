import 'package:flutter/material.dart';

/// 수입 등록 시 선택하는 고정 카테고리. 지출 카테고리와 달리 사용자가 추가/수정하지 않는다.
class IncomeCategory {
  const IncomeCategory(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color});

  final String id;
  final String name;
  final IconData icon;
  final Color color;
}

const List<IncomeCategory> incomeCategories = [
  IncomeCategory(
      id: 'income_salary',
      name: '월급',
      icon: Icons.work_outline,
      color: Color(0xFF34C759)),
  IncomeCategory(
      id: 'income_side',
      name: '부업',
      icon: Icons.laptop_mac,
      color: Color(0xFF00A8FF)),
  IncomeCategory(
      id: 'income_allowance',
      name: '용돈',
      icon: Icons.card_giftcard,
      color: Color(0xFFFF7A00)),
  IncomeCategory(
      id: 'income_bonus',
      name: '보너스',
      icon: Icons.redeem,
      color: Color(0xFF9B51E0)),
  IncomeCategory(
      id: 'income_finance',
      name: '금융수입',
      icon: Icons.trending_up,
      color: Color(0xFF00D2D3)),
  IncomeCategory(
      id: 'income_etc',
      name: '기타',
      icon: Icons.more_horiz,
      color: Color(0xFF8A7A6C)),
];

IncomeCategory? findIncomeCategory(String id) {
  for (final c in incomeCategories) {
    if (c.id == id) return c;
  }
  return null;
}
