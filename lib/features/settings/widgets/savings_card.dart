import 'package:flutter/material.dart';

import '../../../data/models/juice_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';

/// 인스타 스토리용 1:1 정사각형 '주스 절약 성공 카드'. 배경 그라데이션과 이모지는
/// 현재 선택된 주스 테마([JuiceTheme])를 따른다.
class SavingsCard extends StatelessWidget {
  const SavingsCard({
    super.key,
    required this.budget,
    required this.spent,
    required this.weekLabel,
    required this.currency,
    required this.theme,
  });

  final double budget;
  final double spent;
  final String weekLabel;
  final CurrencyItem currency;
  final JuiceTheme theme;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isSuccess = spent <= budget;
    final ratio = budget <= 0 ? 0.0 : (spent / budget).clamp(0.0, 1.0);

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSuccess
                ? [theme.highColor, theme.mediumColor]
                : [const Color(0xFFB0B0B0), const Color(0xFF6B6B6B)],
          ),
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(theme.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 8),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      loc.appTitle,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  weekLabel,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            Text(
              isSuccess
                  ? loc.savingsCardSuccessMessage
                  : loc.savingsCardOverMessage,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              loc.savingsCardSpentLine(
                  currency.format(budget), currency.format(spent)),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 8,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Transform.rotate(
                angle: -0.2,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isSuccess ? loc.savingsCardSuccessStamp : loc.savingsCardOverStamp,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
