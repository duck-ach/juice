import 'package:flutter/widgets.dart';

/// 홈 화면 '오늘의 주스 팁' 카드에 노출되는 금융 명언/브랜드 슬로건 하나.
/// [text]/[author]는 언어 코드('ko'/'en'/'ja'/'vi') → 문자열 맵으로, 지원하지 않는
/// 언어면 영어로 대체(fallback)한다.
class QuoteItem {
  const QuoteItem({
    required this.id,
    required this.text,
    required this.author,
  });

  final int id;
  final Map<String, String> text;
  final Map<String, String> author;

  factory QuoteItem.fromJson(Map<String, dynamic> json) => QuoteItem(
        id: json['id'] as int,
        text: Map<String, String>.from(json['text'] as Map),
        author: Map<String, String>.from(json['author'] as Map),
      );

  /// 현재 [context]의 언어에 맞는 명언 본문. 지원하지 않는 언어면 영어로 대체.
  String getLocalizedText(BuildContext context) => _localized(text, context);

  /// 현재 [context]의 언어에 맞는 저자/출처. 지원하지 않는 언어면 영어로 대체.
  String getLocalizedAuthor(BuildContext context) =>
      _localized(author, context);

  String _localized(Map<String, String> map, BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    return map[languageCode] ?? map['en'] ?? map.values.first;
  }
}
