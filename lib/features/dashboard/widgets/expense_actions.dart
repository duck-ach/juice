import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/expense.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/expense_provider.dart';

/// 지출을 삭제하고 "실행취소" 스낵바를 띄운다. 실행취소 시 동일한 id로 그대로 복원.
void deleteExpenseWithUndo(
    BuildContext context, WidgetRef ref, Expense expense) {
  final loc = AppLocalizations.of(context)!;
  ref.read(expenseProvider.notifier).delete(expense.id);
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(loc.deletedMessage),
        action: SnackBarAction(
          label: loc.undoAction,
          onPressed: () => ref.read(expenseProvider.notifier).upsert(expense),
        ),
      ),
    );
}
