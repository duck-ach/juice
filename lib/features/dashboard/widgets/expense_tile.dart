import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/models/category.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/payment_method.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';

/// 이 지출이 "현재" 기준 통화와 다른 외화로 결제됐다면 원본 통화 금액을 병기한 문자열
/// (예: "20,840₩ ($15.50)")을, 아니면(기준 통화로 결제됐거나, 기준 통화가 바뀌어 원본
/// 통화와 같아졌다면) 기준 통화 금액만 반환한다.
String _formatAmount(Expense expense, CurrencyItem baseCurrency) {
  final formatted = baseCurrency.format(expense.amount);
  if (!expense.isForeignCurrency || expense.originalCurrency == baseCurrency.code) {
    return formatted;
  }
  final original = currencyByCode(expense.originalCurrency!)
      .format(expense.originalAmount!);
  return '$formatted ($original)';
}

/// 지출/수입 한 건을 보여주는 카드. 대시보드/캘린더 등에서 공용으로 사용.
/// [category]는 호출부가 [Expense.categoryId]로 미리 조회해 전달한다(지출/수입 카테고리 공용).
class ExpenseTile extends ConsumerWidget {
  const ExpenseTile(
      {super.key, required this.expense, required this.category, this.onTap});

  final Expense expense;
  final Category? category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final currency = ref.watch(currencyProvider).currency;
    final dateLabel =
        DateFormat('M.d (E)', loc.localeName).format(expense.date);

    final color = category != null
        ? Color(category!.colorValue)
        : (expense.isIncome ? const Color(0xFF34C759) : Colors.grey);
    final name = category?.getLocalizedName(context) ??
        (expense.isIncome ? loc.incomeFallbackName : loc.unknownCategoryName);
    final icon = category != null
        ? IconData(category!.iconCodePoint,
            fontFamily: category!.iconFontFamily ?? 'MaterialIcons')
        : (expense.isIncome ? Icons.attach_money : Icons.help_outline);

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
                  ? '+${_formatAmount(expense, currency)}'
                  : _formatAmount(expense, currency),
              style: expense.isIncome
                  ? TextStyle(color: color, fontWeight: FontWeight.w700)
                  : null,
            ),
            if (expense.isFixed)
              Text(
                loc.fixedExpenseLabel,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 11),
              ),
            if (!expense.isIncome &&
                expense.paymentMethod == PaymentMethod.creditCard)
              Text(
                expense.isInstallment
                    ? loc.installmentProgressLabel(
                        expense.currentInstallmentIndex,
                        expense.installmentMonths)
                    : loc.paymentCreditCard,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 11),
              ),
            if (!expense.isIncome &&
                expense.paymentMethod == PaymentMethod.splitBill)
              Text(
                loc.paymentSplitBill,
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
