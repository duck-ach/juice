import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:juice/core/theme/app_theme.dart';

void main() {
  testWidgets('App theme builds without error', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const Scaffold(body: Text('🍊 Juice')),
        ),
      ),
    );

    expect(find.text('🍊 Juice'), findsOneWidget);
  });
}
