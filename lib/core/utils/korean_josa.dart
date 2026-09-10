/// 한글 단어의 받침 유무에 따라 '로'/'으로' 조사를 반환한다.
/// ㄹ받침은 예외적으로 '로'를 사용한다 (예: 생활로, 식비로, 간식으로).
String roJosa(String word) {
  if (word.isEmpty) return '으로';
  final code = word.codeUnitAt(word.length - 1);
  if (code < 0xAC00 || code > 0xD7A3) return '으로';
  final finalConsonantIndex = (code - 0xAC00) % 28;
  return (finalConsonantIndex == 0 || finalConsonantIndex == 8) ? '로' : '으로';
}
