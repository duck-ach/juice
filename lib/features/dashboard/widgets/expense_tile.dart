import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/category.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/income_category.dart';
import '../../../data/models/payment_method.dart';

/// 지출/수입 한 건을 보여주는 카드. 대시보드/캘린더 등에서 공용으로 사용.
/// [category]는 지출일 때만 사용되고, 수입([Expense.isIncome])이면 [IncomeCategory] 목록에서
/// [Expense.categoryId]로 직접 조회한다.
class ExpenseTile extends StatelessWidget {
  const ExpenseTile(
      {super.key, required this.expense, required this.category, this.onTap});

  final Expense expense;
  final Category? category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');
    final dateLabel = DateFormat('M.d (E)', 'ko').format(expense.date);
    final incomeCategory =
        expense.isIncome ? findIncomeCategory(expense.categoryId) : null;

    final color = expense.isIncome
        ? (incomeCategory?.color ?? const Color(0xFF34C759))
        : (category != null ? Color(category!.colorValue) : Colors.grey);
    final name = expense.isIncome
        ? (incomeCategory?.name ?? '수입')
        : (category?.name ?? '알 수 없음');
    final icon = expense.isIncome
        ? (incomeCategory?.icon ?? Icons.attach_money)
        : (category != null
            ? IconData(category!.iconCodePoint,
                fontFamily: category!.iconFontFamily ?? 'MaterialIcons')
            : Icons.help_outline);

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.18),
          child: Icon(icon, color: color),
        ),
        title: Text(name),
        subtitle: Text(
          expense.memo == null || expense.memo!.isEmpty
              ? dateLabel
              : '$dateLabel · ${expense.memo}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              expense.isIncome
                  ? '+${formatter.format(expense.amount)}원'
                  : '${formatter.format(expense.amount)}원',
              style: expense.isIncome
                  ? TextStyle(color: color, fontWeight: FontWeight.w700)
                  : null,
            ),
            if (expense.isFixed)
              Text(
                '고정지출',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 11),
              ),
            if (!expense.isIncome &&
                expense.paymentMethod == PaymentMethod.creditCard)
              Text(
                expense.isInstallment
                    ? '할부 ${expense.currentInstallmentIndex}/${expense.installmentMonths}'
                    : '신용카드',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 11),
              ),
            if (!expense.isIncome &&
                expense.paymentMethod == PaymentMethod.splitBill)
              Text(
                '더치페이',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
