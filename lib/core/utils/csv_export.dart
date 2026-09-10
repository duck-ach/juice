import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/category.dart';
import '../../data/models/expense.dart';

const _utf8Bom = '﻿';

/// 지출 내역을 UTF-8 CSV(엑셀 호환 BOM 포함) 파일로 만들어 임시 경로에 저장하고 반환.
Future<File> buildExpenseCsvFile(
  List<Expense> expenses,
  Map<String, Category> categoryMap,
) async {
  final dateFormat = DateFormat('yyyy-MM-dd');
  final sorted = [...expenses]..sort((a, b) => a.date.compareTo(b.date));

  final rows = <List<String>>[
    ['날짜', '카테고리', '금액', '고정지출 여부', '메모'],
    for (final e in sorted)
      [
        dateFormat.format(e.date),
        categoryMap[e.categoryId]?.name ?? '알 수 없음',
        e.amount.toStringAsFixed(0),
        e.isFixed ? 'Y' : 'N',
        e.memo ?? '',
      ],
  ];

  final csvString = const ListToCsvConverter().convert(rows);
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/juice_expenses_${DateTime.now().millisecondsSinceEpoch}.csv');
  return file.writeAsBytes(utf8.encode('$_utf8Bom$csvString'));
}
