import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/category.dart';
import '../../../data/models/expense.dart';

/// 지출 한 건을 보여주는 카드. 대시보드/캘린더 등에서 공용으로 사용.
class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense, required this.category, this.onTap});

  final Expense expense;
  final Category? category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');
    final dateLabel = DateFormat('M.d (E)', 'ko').format(expense.date);
    final color = category != null ? Color(category!.colorValue) : Colors.grey;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.18),
          child: Icon(
            category != null
                ? IconData(category!.iconCodePoint, fontFamily: category!.iconFontFamily ?? 'MaterialIcons')
                : Icons.help_outline,
            color: color,
          ),
        ),
        title: Text(category?.name ?? '알 수 없음'),
        subtitle: Text(
          expense.memo == null || expense.memo!.isEmpty ? dateLabel : '$dateLabel · ${expense.memo}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${formatter.format(expense.amount)}원'),
            if (expense.isFixed)
              Text(
                '고정지출',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
