import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/expense.dart';
import '../../l10n/app_localizations.dart';

const _utf8Bom = '﻿';

/// 지출 내역을 UTF-8 CSV(엑셀 호환 BOM 포함) 파일로 만들어 임시 경로에 저장하고 반환.
/// [categoryNames]는 카테고리 id -> 현재 언어로 번역된 이름(호출 측에서 BuildContext로
/// 미리 계산해 전달) — 기본 카테고리도 헤더/값이 항상 앱 언어를 따르도록 한다.
Future<File> buildExpenseCsvFile(
  List<Expense> expenses,
  Map<String, String> categoryNames,
  AppLocalizations loc,
) async {
  final dateFormat = DateFormat('yyyy-MM-dd');
  final sorted = [...expenses]..sort((a, b) => a.date.compareTo(b.date));

  final rows = <List<String>>[
    [
      loc.csvHeaderDate,
      loc.csvHeaderCategory,
      loc.csvHeaderAmount,
      loc.csvHeaderIsFixed,
      loc.csvHeaderMemo,
    ],
    for (final e in sorted)
      [
        dateFormat.format(e.date),
        categoryNames[e.categoryId] ?? loc.csvUnknownCategory,
        e.amount.toStringAsFixed(0),
        e.isFixed ? 'Y' : 'N',
        e.memo ?? '',
      ],
  ];

  final csvString = const ListToCsvConverter().convert(rows);
  final dir = await getTemporaryDirectory();
  final file = File(
      '${dir.path}/juice_expenses_${DateTime.now().millisecondsSinceEpoch}.csv');
  return file.writeAsBytes(utf8.encode('$_utf8Bom$csvString'));
}
