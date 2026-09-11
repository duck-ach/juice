import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/home_widget_settings_provider.dart';

/// 홈 화면 위젯 관련 설정 서브 화면.
class WidgetSettingsScreen extends ConsumerWidget {
  const WidgetSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideWidgetAmount = ref.watch(hideWidgetAmountProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('위젯 설정')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text('홈 화면 위젯', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '홈 화면에 주스 게이지 위젯과 빠른 입력 위젯을 추가할 수 있어요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: hideWidgetAmount,
            onChanged: (value) =>
                ref.read(hideWidgetAmountProvider.notifier).setHidden(value),
            title: const Text('위젯에서 금액 가리기'),
            subtitle: const Text('금액 대신 ***mL와 잔여 % 수위만 표시해요.'),
          ),
        ],
      ),
    );
  }
}
