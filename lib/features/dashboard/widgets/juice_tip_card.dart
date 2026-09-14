import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/quote_item.dart';
import '../../../providers/juice_theme_provider.dart';

/// 홈 화면 게이지와 필터 탭 사이에 노출되는 '오늘의 주스 팁' 카드.
/// 금융 명언/브랜드 슬로건을 현재 언어로 보여주고, 탭할 때마다 가벼운 햅틱과 함께
/// 다음 명언으로 부드럽게(페이드) 랜덤 전환된다. 좌측 과일 이모지는 현재 선택된
/// 주스 테마([resolvedJuiceThemeProvider])를 따른다.
class JuiceTipCard extends ConsumerStatefulWidget {
  const JuiceTipCard({super.key});

  @override
  ConsumerState<JuiceTipCard> createState() => _JuiceTipCardState();
}

class _JuiceTipCardState extends ConsumerState<JuiceTipCard> {
  static List<QuoteItem>? _cachedQuotes;

  final _random = Random();
  List<QuoteItem>? _quotes;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (_cachedQuotes != null) {
      setState(() {
        _quotes = _cachedQuotes;
        _index = _random.nextInt(_cachedQuotes!.length);
      });
      return;
    }
    final raw = await rootBundle.loadString('assets/data/juice_quotes.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    final quotes = decoded
        .map((e) => QuoteItem.fromJson(e as Map<String, dynamic>))
        .toList();
    _cachedQuotes = quotes;
    if (!mounted) return;
    setState(() {
      _quotes = quotes;
      _index = _random.nextInt(quotes.length);
    });
  }

  void _showNext() {
    final quotes = _quotes;
    if (quotes == null || quotes.length < 2) return;
    HapticFeedback.lightImpact();
    var next = _random.nextInt(quotes.length);
    while (next == _index) {
      next = _random.nextInt(quotes.length);
    }
    setState(() => _index = next);
  }

  @override
  Widget build(BuildContext context) {
    final quotes = _quotes;
    if (quotes == null || quotes.isEmpty) return const SizedBox.shrink();
    final quote = quotes[_index];

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF241E1A) : const Color(0xFFF9F5F0);
    final textColor = isDark ? Colors.white : const Color(0xFF2E241E);
    final mutedColor = isDark ? Colors.white38 : const Color(0xFF8A7A6C);
    final fruitEmoji = ref.watch(resolvedJuiceThemeProvider).emoji;

    return GestureDetector(
      onTap: _showNext,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: isDark
              ? null
              : Border.all(color: const Color(0xFFEADBCE), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fruitEmoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                child: Column(
                  key: ValueKey(quote.id),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quote.getLocalizedText(context),
                      style: TextStyle(
                        fontSize: 13,
                        color: textColor,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '— ${quote.getLocalizedAuthor(context)}',
                      style: TextStyle(
                        fontSize: 11,
                        color: mutedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.sync, size: 16, color: mutedColor),
          ],
        ),
      ),
    );
  }
}
