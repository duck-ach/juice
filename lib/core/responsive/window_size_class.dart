/// 화면 너비 기준 창 크기 분류(Material 3 window size classes).
/// 스마트폰 세로 = [compact], 태블릿 세로/폴더블 펼침 = [medium], 태블릿 가로/큰 화면 = [expanded].
enum WindowSizeClass {
  compact,
  medium,
  expanded;

  static const mediumBreakpoint = 600.0;
  static const expandedBreakpoint = 840.0;

  static WindowSizeClass fromWidth(double width) {
    if (width >= expandedBreakpoint) return WindowSizeClass.expanded;
    if (width >= mediumBreakpoint) return WindowSizeClass.medium;
    return WindowSizeClass.compact;
  }

  bool get isCompact => this == WindowSizeClass.compact;
  bool get isMediumUp => this != WindowSizeClass.compact;
}
