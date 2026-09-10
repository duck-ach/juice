import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/thousands_formatter.dart';
import '../../providers/budget_settings_provider.dart';

/// 첫 실행 시 노출되는 단일 인풋 온보딩 화면.
/// 목표 금액 입력 즉시 저장되며, AppRoot가 targetAmountProvider 상태 변화를 감지해
/// 별도 네비게이션 없이 대시보드로 전환된다.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final amount = double.tryParse(_controller.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) return;

    setState(() => _submitting = true);
    await ref.read(targetAmountProvider.notifier).setTargetAmount(amount);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🍊', style: TextStyle(fontSize: 56)),
                const SizedBox(height: 20),
                Text(
                  '이번 주 쓸 돈(예산)을\n적어보세요',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [ThousandsSeparatorInputFormatter()],
                  style: textTheme.headlineLarge,
                  decoration: const InputDecoration(
                    hintText: '0',
                    suffixText: ' mL',
                  ),
                  onSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: _submitting ? null : _submit,
                    child: const Text('주스 채우기'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
