import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';

/// 인스타 스토리용 1:1 정사각형 '주스 절약 성공 카드'.
class SavingsCard extends StatelessWidget {
  const SavingsCard({
    super.key,
    required this.budget,
    required this.spent,
    required this.weekLabel,
  });

  final double budget;
  final double spent;
  final String weekLabel;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');
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
                ? [AppColors.citrusYellow, AppColors.freshOrange]
                : [const Color(0xFFB0B0B0), const Color(0xFF6B6B6B)],
          ),
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🍊', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 8),
                const Text(
                  '주스',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
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
              isSuccess ? '이번 주 주스를\n신선하게 지켜냈어요!' : '이번 주 주스가\n조금 넘쳤어요',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${formatter.format(budget)}원 중 ${formatter.format(spent)}원 소비',
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
                    isSuccess ? '성공' : '분발',
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
