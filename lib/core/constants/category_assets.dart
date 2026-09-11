import 'package:flutter/material.dart';

/// 카테고리 생성/수정 시트에서 고르는 정적 팔레트/아이콘 프리셋.
class CategoryAssets {
  CategoryAssets._();

  /// 새 커스텀 카테고리의 기본 설명(사용자가 자유롭게 수정 가능).
  static const defaultCustomDescription = '나만의 특별한 주스 레시피 🍊';

  /// 20종 트렌디 쥬시/비비드 팔레트 (다크 테마에서 빛나는 색상)
  static const List<Color> palette = [
    Color(0xFFFF7A00), // 01. 시그니처 탠저린 오렌지
    Color(0xFFFF4D4D), // 02. 스칼렛 스트로베리
    Color(0xFFFF3366), // 03. 비비드 체리 핑크
    Color(0xFFFF7597), // 04. 피치 블러셔
    Color(0xFFFFB800), // 05. 망고 옐로우
    Color(0xFFFFE600), // 06. 레몬 제스트
    Color(0xFFCCFF00), // 07. 네온 라임
    Color(0xFF34C759), // 08. 프레시 그린 애플
    Color(0xFF00E5A3), // 09. 쿨 민트
    Color(0xFF00D2D3), // 10. 블루 하와이
    Color(0xFF00A8FF), // 11. 오션 소다
    Color(0xFF5352ED), // 12. 블루베리 일렉트릭
    Color(0xFF706FD3), // 13. 라벤더 시럽
    Color(0xFF9B51E0), // 14. 포도 젤리
    Color(0xFFFF4081), // 15. 라즈베리 마카롱
    Color(0xFFA55EEA), // 16. 플럼 펀치
    Color(0xFFE58E26), // 17. 캐러멜 애플
    Color(0xFF8B572A), // 18. 로스티드 헤이즐넛
    Color(0xFF747D8C), // 19. 스모키 소다 그레이
    Color(0xFF57606F), // 20. 딥 나이트 블랙베리
  ];

  /// 카테고리 추천 아이콘 목록 (지출 성격별)
  static const List<IconData> icons = [
    Icons.restaurant,
    Icons.local_cafe,
    Icons.shopping_bag,
    Icons.home,
    Icons.directions_bus,
    Icons.movie,
    Icons.card_giftcard,
    Icons.pets,
    Icons.fitness_center,
    Icons.local_hospital,
    Icons.flight,
    Icons.school,
    Icons.sports_esports,
    Icons.content_cut,
    Icons.receipt_long,
    Icons.local_bar,
    Icons.savings,
    Icons.phone_iphone,
    Icons.work,
    Icons.more_horiz,
  ];
}
