import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Juice Budget';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get setBudgetTitle => 'Đặt ngân sách juice của bạn';

  @override
  String get weeklyBudget => 'Juice còn lại tuần này';

  @override
  String get paymentCheckCard => 'Thẻ ghi nợ';

  @override
  String get paymentCreditCard => 'Thẻ tín dụng';

  @override
  String get defaultCheckCardName => 'Thẻ ghi nợ (Mặc định)';

  @override
  String get defaultCreditCardName => 'Thẻ tín dụng (Mặc định)';

  @override
  String get paymentCash => 'Tiền mặt · Chuyển khoản';

  @override
  String get commonCancel => 'Hủy';

  @override
  String get commonSave => 'Lưu';

  @override
  String get commonDelete => 'Xóa';

  @override
  String get commonEdit => 'Sửa';

  @override
  String get commonAdd => 'Thêm';

  @override
  String get commonNext => 'Tiếp theo';

  @override
  String get goalSettingsTitle => 'Cài đặt mục tiêu';

  @override
  String get activePeriodSectionTitle => 'Chu kỳ mục tiêu đang dùng';

  @override
  String get activePeriodSectionDescription => 'Chu kỳ mà đồng hồ ở màn hình chính dựa vào. Điền sẵn số tiền mục tiêu cho từng chu kỳ bên dưới để khi chuyển đổi sẽ áp dụng ngay.';

  @override
  String get weekStartDayTileTitle => 'Ngày bắt đầu tuần';

  @override
  String get periodTargetSectionTitle => 'Số tiền mục tiêu theo chu kỳ';

  @override
  String get periodTargetSectionDescription => 'Lưu riêng số tiền mục tiêu cho từng chu kỳ và chọn khi cần.';

  @override
  String get periodTargetAmountSuffix => 'Số tiền mục tiêu';

  @override
  String get installmentSectionTitle => 'Cách phản ánh trả góp';

  @override
  String get installmentSectionDescription => 'Chọn thời điểm và cách chi tiêu trả góp được phản ánh vào lịch/đồng hồ juice.';

  @override
  String get recommendedSuffix => 'Đề xuất';

  @override
  String get savingsPlanSectionTitle => 'Kế hoạch tiết kiệm trung/dài hạn';

  @override
  String get savingsPlanSectionDescription => 'Nhập thu nhập hàng tháng, chi phí cố định và mục tiêu tiết kiệm để tính lượng juice bạn có thể chi tiêu.';

  @override
  String get savingsPlanToggleTitle => 'Bạn có mục tiêu tiết kiệm trung/dài hạn không?';

  @override
  String get autoBudgetSetMessage => 'Đã tự động đặt mục tiêu ngày/tuần/tháng 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 Tóm tắt kế hoạch Juice của tôi';

  @override
  String get replanButton => 'Lập lại kế hoạch';

  @override
  String get applyBudgetButton => 'Tự động đặt Juice theo ngân sách này';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years năm $months tháng';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years năm';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months tháng';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return 'Mục tiêu: Tiết kiệm $amount trong $duration';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return 'Chi phí cố định (không thể tránh): $amount/tháng';
  }

  @override
  String get savingsPlanMonthlyRequiredLabel => 'Số tiền cần tiết kiệm mỗi tháng';

  @override
  String savingsPlanMonthlyRequiredAmount(Object amount) {
    return '$amount';
  }

  @override
  String get savingsPlanAchievementRateLabel => 'Tỷ lệ đạt mục tiêu';

  @override
  String get savingsPlanRecommendedSectionLabel => 'Ngân sách chi tiêu đề xuất';

  @override
  String get savingsPlanDailyGridLabel => 'Hằng ngày';

  @override
  String get savingsPlanWeeklyGridLabel => 'Tuần này';

  @override
  String get savingsPlanMonthlyGridLabel => 'Tháng này';

  @override
  String get savingsPlanViewInAssetsButton => 'Xem chi tiết trong tab Tài sản';

  @override
  String savingsPlanActualTraceLine(Object actual, Object goal, Object percent) {
    return 'Đã tiết kiệm thực tế $actual / mục tiêu $goal ($percent%)';
  }

  @override
  String get manageFixedIncomesButton => 'Quản lý thu nhập cố định';

  @override
  String savingsPlanFixedIncomeTotalLine(Object total) {
    return 'Tổng thu nhập cố định: $total';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return 'Juice đề xuất: $daily mL/ngày · $weekly mL/tuần · $monthly mL/tháng';
  }

  @override
  String savingsPlanPaceFasterLine(Object months) {
    return 'Với tốc độ hiện tại, bạn đang đạt mục tiêu sớm hơn $months tháng! 🚀';
  }

  @override
  String savingsPlanPaceSlowerLine(Object months) {
    return 'Với tốc độ hiện tại, bạn có thể chậm hơn kế hoạch $months tháng. Cố lên nhé 💪';
  }

  @override
  String get savingsPlanPaceOnTrackLine => 'Tốc độ hiện tại khớp hoàn hảo với kế hoạch! Cứ tiếp tục như vậy nhé 🍊';

  @override
  String get recalibrateButton => 'Thay đổi thu nhập · Điều chỉnh';

  @override
  String get recalibrateSheetTitle => 'Điều chỉnh kế hoạch';

  @override
  String get recalibrateSheetSubtitle => 'Nhập thu nhập hàng tháng mới và chọn một trong hai cách để áp dụng ngay.';

  @override
  String get recalibrateIncomeFieldLabel => 'Thu nhập hàng tháng mới';

  @override
  String get recalibrateShortenOption => 'Rút ngắn thời hạn mục tiêu';

  @override
  String recalibrateShortenPreview(Object before, Object after) {
    return 'Giữ nguyên ngân sách sinh hoạt hiện tại, rút ngắn thời hạn mục tiêu từ $before xuống $after tháng.';
  }

  @override
  String get recalibrateShortenUnavailable => 'Với thu nhập này, không thể rút ngắn thời hạn nếu vẫn giữ ngân sách sinh hoạt hiện tại.';

  @override
  String get recalibrateBoostOption => 'Tăng juice (ngân sách sinh hoạt)';

  @override
  String recalibrateBoostPreview(Object before, Object after) {
    return 'Giữ nguyên thời hạn mục tiêu, tăng juice mỗi ngày từ $before mL lên $after mL.';
  }

  @override
  String get recalibrateBudgetSliderLabel => 'Ngân sách sinh hoạt (Juice) tháng này';

  @override
  String get recalibrateWeeklyBudgetLabel => 'Mục tiêu hàng tuần';

  @override
  String recalibratePreviewLine(Object before, Object after) {
    return 'Với ngân sách này, thời gian mục tiêu đổi từ $before sang $after tháng';
  }

  @override
  String get recalibrateNoSavingsWarning => 'Với ngân sách này, tháng này bạn sẽ không tiết kiệm được gì. Hãy kéo thanh trượt sang trái.';

  @override
  String get recalibrateStatGoal => 'Số tiền mục tiêu';

  @override
  String get recalibrateStatSaved => 'Đã tiết kiệm';

  @override
  String get recalibrateStatRemaining => 'Còn lại';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get savingsCardSectionTitle => 'Thẻ tiết kiệm tuần này';

  @override
  String get savingsCardSectionDescription => 'Biến một tuần giữ vững ngân sách thành thẻ ảnh và chia sẻ nó.';

  @override
  String get generatingCard => 'Đang tạo thẻ...';

  @override
  String get shareCardButton => 'Chia sẻ thẻ';

  @override
  String shareCardFailedMessage(Object error) {
    return 'Chia sẻ thẻ thất bại: $error';
  }

  @override
  String get setTargetAmountFirst => 'Vui lòng đặt số tiền mục tiêu trước';

  @override
  String get menuGoalSettingsTitle => 'Cài đặt mục tiêu';

  @override
  String get menuGoalSettingsSubtitle => 'Mục tiêu tiết kiệm dài hạn, chu kỳ mục tiêu, số tiền mục tiêu theo chu kỳ';

  @override
  String get menuFixedExpenseManagementTitle => 'Quản lý chi phí cố định';

  @override
  String get menuFixedExpenseManagementSubtitle => 'Quản lý các khoản chi phí cố định và cài đặt tự động điền lịch';

  @override
  String get fixedExpenseManageInfoBanner => 'Liên kết với các khoản chi phí cố định trong kế hoạch tiết kiệm trung/dài hạn — nếu chi phí cố định tăng hoặc giảm, ngân sách khả dụng theo ngày/tuần/tháng của bạn có thể thay đổi.';

  @override
  String get fixedExpensePaymentDayLabel => 'Ngày thanh toán';

  @override
  String fixedExpenseDayOptionLabel(Object day) {
    return 'Ngày $day';
  }

  @override
  String get fixedExpenseLastDayOptionLabel => 'Ngày 31 (cuối tháng)';

  @override
  String get calendarAutoFillTitle => 'Tự động ghi chi phí cố định';

  @override
  String get calendarAutoFillSubtitle => 'Tự động ghi các khoản chi cố định đã đăng ký vào lịch mỗi tháng';

  @override
  String get menuThemeSettingsTitle => 'Cài đặt giao diện';

  @override
  String get menuThemeSettingsSubtitle => 'Chế độ màn hình và chủ đề juice';

  @override
  String get menuWidgetSettingsTitle => 'Cài đặt widget';

  @override
  String get menuWidgetSettingsSubtitle => 'Ẩn số tiền trên widget màn hình chính';

  @override
  String get menuCardManagementTitle => 'Quản lý thẻ của tôi';

  @override
  String get menuCardManagementSubtitle => 'Đăng ký thẻ bạn sở hữu, sắp xếp lại thứ tự';

  @override
  String get menuNotificationSettingsTitle => 'Cài đặt thông báo';

  @override
  String get menuNotificationSettingsSubtitle => 'Bật/tắt nhắc nhở sáng/tối';

  @override
  String get menuBackupSettingsTitle => 'Sao lưu & Khôi phục dữ liệu';

  @override
  String get menuBackupSettingsSubtitle => 'Xuất CSV, xuất/nhập tệp sao lưu';

  @override
  String get menuSecuritySettingsTitle => 'Bảo mật';

  @override
  String get menuSecuritySettingsSubtitle => 'Mã PIN, xác thực sinh trắc học';

  @override
  String get menuContactSupportTitle => 'Liên hệ & Phản hồi';

  @override
  String get menuContactSupportSubtitle => 'Gửi ý kiến của bạn qua email';

  @override
  String get feedbackTitle => 'Liên hệ & Phản hồi 🍊';

  @override
  String get feedbackTypeBug => 'Báo lỗi';

  @override
  String get feedbackTypeFeature => 'Đề xuất tính năng';

  @override
  String get feedbackTypeOther => 'Khác';

  @override
  String get feedbackEmailHint => 'Email của bạn (không bắt buộc, để nhận phản hồi)';

  @override
  String get feedbackContentHint => 'Hãy chia sẻ ý kiến của bạn.';

  @override
  String get feedbackAttachImage => 'Đính kèm ảnh chụp màn hình';

  @override
  String get feedbackSubmit => 'Gửi';

  @override
  String get feedbackDeviceInfoNotice => 'Thông tin thiết bị/hệ điều hành sẽ được gửi kèm để chúng tôi xử lý nhanh hơn.';

  @override
  String get feedbackComposeReplyEmail => 'Email phản hồi';

  @override
  String get feedbackComposeNotEntered => '(chưa nhập)';

  @override
  String get feedbackComposeContent => 'Nội dung';

  @override
  String get feedbackComposeDeviceInfo => 'Thông tin thiết bị';

  @override
  String get feedbackContentRequired => 'Vui lòng nhập nội dung';

  @override
  String get feedbackMailUnavailable => 'Không thể mở ứng dụng Mail, nội dung đã được sao chép.';

  @override
  String get privacyPolicyTitle => 'Chính sách bảo mật';

  @override
  String get menuPrivacyPolicySubtitle => 'Xem cách chúng tôi xử lý thông tin cá nhân của bạn';

  @override
  String get privacyWelcomeTitle => 'Chào mừng bạn đến với Juice Budget!';

  @override
  String get privacyAgreeNotice => 'Juice Budget là sổ chi tiêu cục bộ 100% trên thiết bị — không có bất kỳ thông tin tài chính hay cá nhân nào của bạn được gửi đến máy chủ bên ngoài.';

  @override
  String get viewPrivacyPolicy => 'Xem toàn bộ Chính sách bảo mật';

  @override
  String get agreeAndStart => 'Đồng ý & Bắt đầu';

  @override
  String get savingsCardSuccessMessage => 'Bạn đã giữ juice\ntươi mới tuần này!';

  @override
  String get savingsCardOverMessage => 'Juice tuần này\nđã tràn một chút';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return 'Đã chi $spent trong $budget';
  }

  @override
  String get savingsCardSuccessStamp => 'THÀNH CÔNG';

  @override
  String get savingsCardOverStamp => 'CỐ GẮNG HƠN';

  @override
  String get pinSetupTitle => 'Đặt mật khẩu';

  @override
  String get biometricUnlockReason => 'Xác thực để mở khóa';

  @override
  String get pinConfirmTitle => 'Xác nhận mật khẩu';

  @override
  String get pinConfirmCurrentTitle => 'Xác nhận mật khẩu hiện tại';

  @override
  String get pinSetupNewTitle => 'Đặt mật khẩu mới';

  @override
  String get pinChangedMessage => 'Đã đổi mật khẩu';

  @override
  String get biometricLinkTitle => 'Liên kết xác thực sinh trắc học';

  @override
  String get biometricLinkConfirm => 'Bạn có muốn liên kết xác thực sinh trắc học không?';

  @override
  String get biometricLinkAction => 'Liên kết';

  @override
  String get biometricLinkReason => 'Xác thực để liên kết sinh trắc học';

  @override
  String get biometricUnavailableMessage => 'Không thể sử dụng xác thực sinh trắc học';

  @override
  String get securityTitle => 'Bảo mật';

  @override
  String get securityDescription => 'Khóa ứng dụng bằng mã PIN hoặc sinh trắc học.';

  @override
  String get appLockTitle => 'Khóa ứng dụng';

  @override
  String get appLockDescription => 'Bảo vệ quyền truy cập ứng dụng bằng mã PIN 4 chữ số.';

  @override
  String get changePasswordTitle => 'Đổi mật khẩu';

  @override
  String get biometricUseTitle => 'Dùng sinh trắc học';

  @override
  String get biometricUseDescription => 'Mở khóa nhanh hơn bằng Face ID/vân tay.';

  @override
  String get csvShareText => 'Lịch sử chi tiêu Juice';

  @override
  String get csvHeaderDate => 'Ngày';

  @override
  String get csvHeaderCategory => 'Danh mục';

  @override
  String get csvHeaderAmount => 'Số tiền';

  @override
  String get csvHeaderIsFixed => 'Chi phí cố định';

  @override
  String get csvHeaderMemo => 'Ghi chú';

  @override
  String get csvUnknownCategory => 'Không xác định';

  @override
  String get backupShareText => 'Sao lưu dữ liệu Juice';

  @override
  String backupFailedMessage(Object error) {
    return 'Sao lưu thất bại: $error';
  }

  @override
  String get restoreDataTitle => 'Khôi phục dữ liệu';

  @override
  String get restoreDataConfirm => 'Dữ liệu hiện tại sẽ bị thay thế bằng tệp sao lưu. Tiếp tục?';

  @override
  String get restoreAction => 'Khôi phục';

  @override
  String get restoreSuccessMessage => 'Khôi phục hoàn tất';

  @override
  String get restoreFailedMessage => 'Khôi phục thất bại. Vui lòng kiểm tra đây có phải là tệp sao lưu Juice hợp lệ không';

  @override
  String get backupSettingsTitle => 'Sao lưu & Khôi phục dữ liệu';

  @override
  String get exportExpensesTitle => 'Xuất lịch sử chi tiêu';

  @override
  String get exportExpensesDescription => 'Chia sẻ tệp CSV gồm ngày, danh mục, số tiền, cờ chi phí cố định và ghi chú.';

  @override
  String get exportingCsv => 'Đang xuất...';

  @override
  String get exportCsvButton => 'Xuất dưới dạng CSV';

  @override
  String get backupRestoreTitle => 'Sao lưu · Khôi phục dữ liệu';

  @override
  String get backupRestoreDescription => 'Sao lưu và khôi phục chi tiêu, thu nhập, danh mục và cài đặt ngân sách trong một tệp.';

  @override
  String get backupDataTitle => 'Sao lưu dữ liệu';

  @override
  String get backupDataDescription => 'Lưu qua bảng chia sẻ vào Tệp, email, v.v.';

  @override
  String get restoreDataTileTitle => 'Khôi phục dữ liệu';

  @override
  String get restoreDataTileDescription => 'Chọn một tệp sao lưu để ghi đè dữ liệu hiện tại.';

  @override
  String get categoryDefaultDescription => 'Công thức juice đặc biệt của tôi';

  @override
  String get categoryDeleteTitle => 'Xóa danh mục';

  @override
  String categoryDeleteConfirm(Object name) {
    return 'Xóa danh mục \'$name\'?\nCác chi tiêu đã ghi vẫn được giữ lại.';
  }

  @override
  String get categoryInUseMessage => 'Có mục đang dùng danh mục này. Hãy chuyển chúng sang danh mục khác trước khi xóa.';

  @override
  String get categoryEditTitle => 'Sửa danh mục';

  @override
  String get categoryAddTitle => 'Thêm danh mục';

  @override
  String get categoryNameLabel => 'Tên danh mục';

  @override
  String get categoryDescriptionLabel => 'Mô tả ngắn';

  @override
  String get colorLabel => 'Màu sắc';

  @override
  String get iconLabel => 'Biểu tượng';

  @override
  String get categoryManageTitle => 'Quản lý danh mục';

  @override
  String get expenseCategoryTab => 'Danh mục chi tiêu';

  @override
  String get incomeCategoryTab => 'Danh mục thu nhập';

  @override
  String get defaultCategoryUndeletable => 'Không thể xóa danh mục mặc định';

  @override
  String get cardDeleteTitle => 'Xóa thẻ';

  @override
  String cardDeleteConfirm(Object name) {
    return 'Xóa thẻ \'$name\'?\nCác chi tiêu đã ghi vẫn được giữ lại.';
  }

  @override
  String get cardEditTitle => 'Sửa thẻ';

  @override
  String get cardAddTitle => 'Thêm thẻ';

  @override
  String get cardNameLabel => 'Tên thẻ';

  @override
  String get cardTypeLabel => 'Loại thẻ';

  @override
  String get cardManagementTitle => 'Quản lý thẻ của tôi';

  @override
  String get defaultCardLastOneUndeletable => 'Đây là thẻ duy nhất thuộc loại này nên không thể xóa. Hãy thêm thẻ khác trước.';

  @override
  String get cardTypeCorporate => 'Thẻ công ty/công tác';

  @override
  String get cardTypeCorporateExcluded => 'Công ty (chi phí) · Loại khỏi juice';

  @override
  String get corporateExpenseNotice => '🏢 Chi tiêu công ty/công việc được ghi lại không cần chọn danh mục và tự động loại trừ khỏi chi tiêu cá nhân của bạn.';

  @override
  String get corporateBadgeLabel => '🏢 Công ty/Công việc · Loại trừ khỏi cá nhân';

  @override
  String get corporateCardLabel => 'Thẻ công ty/công việc';

  @override
  String get corporateMemoRequired => 'Vui lòng nhập ghi chú (mục đích) cho chi tiêu công ty/công việc';

  @override
  String get juiceThemeLabel => 'Chủ đề Juice';

  @override
  String get themeSettingsTitle => 'Cài đặt giao diện';

  @override
  String get screenModeLabel => 'Chế độ màn hình';

  @override
  String get themeModeSystem => 'Theo hệ thống';

  @override
  String get themeModeLight => 'Sáng';

  @override
  String get themeModeDark => 'Tối';

  @override
  String get juiceThemeDescription => 'Chọn màu juice thay đổi theo ngân sách còn lại. Màu này cũng trở thành màu nhấn của toàn bộ ứng dụng.';

  @override
  String get themeOrange => 'Cam';

  @override
  String get themeStrawberry => 'Dâu tây';

  @override
  String get themeApple => 'Táo';

  @override
  String get themeGrape => 'Nho';

  @override
  String get themeBlueberry => 'Việt quất';

  @override
  String get themeMulberry => 'Dâu tằm';

  @override
  String get themeRandom => 'Ngẫu nhiên (mỗi lần mở ứng dụng)';

  @override
  String get widgetSettingsTitle => 'Cài đặt widget';

  @override
  String get homeScreenWidgetTitle => 'Widget màn hình chính';

  @override
  String get homeScreenWidgetDescription => 'Bạn có thể thêm widget đồng hồ juice và widget nhập nhanh vào màn hình chính.';

  @override
  String get hideWidgetAmountTitle => 'Ẩn số tiền trên widget';

  @override
  String get hideWidgetAmountDescription => 'Hiển thị ***mL và % còn lại thay vì số tiền.';

  @override
  String get notificationSettingsTitle => 'Cài đặt thông báo';

  @override
  String get notificationScheduleDescription => 'Chúng tôi sẽ gửi nhắc nhở mỗi ngày lúc 7 giờ sáng và 8 giờ tối để khuyến khích ghi chép.';

  @override
  String get receiveNotificationsTitle => 'Nhận thông báo Juice';

  @override
  String get receiveNotificationsDescription => 'Chúng tôi cũng sẽ nhắc bạn quay lại nếu bạn chưa mở ứng dụng một thời gian.';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navCalendar => 'Lịch';

  @override
  String get navAssets => 'Tài sản';

  @override
  String get navStats => 'Thống kê';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 Phần trả góp hôm nay: $amount mL';
  }

  @override
  String get filterVariableOnlyLong => 'Chỉ hiện chi tiêu biến đổi';

  @override
  String get filterAllLong => 'Hiện tất cả';

  @override
  String noGoalTitle(Object period) {
    return 'Chưa đặt số tiền mục tiêu cho $period';
  }

  @override
  String noGoalDescription(Object period) {
    return 'Vui lòng điền mục tiêu $period trong Cài đặt mục tiêu.';
  }

  @override
  String get goToGoalSettings => 'Đến Cài đặt mục tiêu';

  @override
  String get noExpensesYet => 'Chưa có chi tiêu nào được ghi';

  @override
  String remainingJuiceLabel(Object period) {
    return 'Juice còn lại $period';
  }

  @override
  String spentPercentLabel(Object percent) {
    return 'Đã dùng $percent%';
  }

  @override
  String get overBudgetMessage1 => 'Tiếc quá! Tuần sau hãy cố để lại chút juice nhé 🍊';

  @override
  String get overBudgetMessage2 => 'Bình juice đã cạn rồi! Tuần này hãy nghỉ ngơi một chút 🥲';

  @override
  String get overBudgetMessage3 => 'Juice tràn thì cũng đành chịu! Tuần sau đổ đầy lại nhé 🧃';

  @override
  String get overBudgetMessage4 => 'Đến giọt cuối cùng luôn! Tuần sau nhấp chậm lại một chút nhé ✨';

  @override
  String get incomeFallbackName => 'Thu nhập';

  @override
  String get unknownCategoryName => 'Không xác định';

  @override
  String get fixedExpenseLabel => 'Cố định';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return 'Trả góp $index/$months';
  }

  @override
  String get deletedMessage => 'Đã xóa';

  @override
  String get undoAction => 'Hoàn tác';

  @override
  String get amountAndCategoryRequired => 'Vui lòng kiểm tra số tiền và danh mục';

  @override
  String get expenseLabel => 'Chi tiêu';

  @override
  String get incomeLabel => 'Thu nhập';

  @override
  String editTypeTitle(Object type) {
    return 'Sửa $type';
  }

  @override
  String addTypeTitle(Object type) {
    return 'Thêm $type';
  }

  @override
  String deleteTypeTitle(Object type) {
    return 'Xóa $type';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return 'Xóa mục $type này?';
  }

  @override
  String get cardSelectLabel => 'Chọn thẻ';

  @override
  String installmentMemoSuffix(Object index, Object months) {
    return '(Trả góp $index/$months)';
  }

  @override
  String installmentEditNotice(Object index, Object months) {
    return 'Trả góp $index/$months — các kỳ trả góp khác sẽ không thay đổi theo';
  }

  @override
  String get lumpSumLabel => 'Trả một lần';

  @override
  String monthsPresetLabel(Object months) {
    return '$months tháng';
  }

  @override
  String get customInputLabel => 'Tùy chỉnh';

  @override
  String get monthsCountHint => 'Số tháng (2-24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return 'Phản ánh $amount mL mỗi tháng trong $months kỳ trả góp';
  }

  @override
  String get memoHint => 'Ghi chú (tùy chọn)';

  @override
  String get excludeAsFixedTitle => 'Loại trừ dưới dạng chi phí cố định';

  @override
  String get excludeAsFixedSubtitle => 'Tiền thuê nhà, bảo hiểm, v.v. — không phản ánh vào đồng hồ juice';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return 'Đã nhận thu nhập \'$category\' $amount mL! 💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return 'Đã ghi $amount mL cho \'$category\'! 🍊';
  }

  @override
  String get calendarTitle => 'Lịch';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return 'Tháng này: đã chi $expense · đã thu $income';
  }

  @override
  String get filterVariableOnlyShort => 'Chỉ biến đổi';

  @override
  String get filterAllShort => 'Tất cả';

  @override
  String get noExpenseTodayMessage => 'Một ngày sảng khoái không chi tiêu! 🍊';

  @override
  String get assetsTitle => 'Tài sản';

  @override
  String get cumulativeNetWorthLabel => 'Tài sản ròng lũy kế';

  @override
  String get cumulativeNetWorthDescription => 'Tổng thu nhập trừ chi tiêu đã ghi từ trước đến nay.';

  @override
  String get scopeThisYear => 'năm nay';

  @override
  String get scopeLast5Years => '5 năm gần đây';

  @override
  String totalIncomeLabel(Object scope) {
    return 'Tổng thu nhập ($scope)';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return 'Tổng chi tiêu ($scope)';
  }

  @override
  String get netChangeTrendTitle => 'Xu hướng biến động ròng';

  @override
  String get netChangeTrendDescription => 'Biến động ròng = thu nhập trừ chi tiêu. Xanh lá là thặng dư, đỏ là thâm hụt.';

  @override
  String get statsTitle => 'Thống kê';

  @override
  String get filterFixedIncluded => 'Bao gồm chi phí cố định';

  @override
  String get totalExpenseTitle => 'Tổng chi tiêu';

  @override
  String get categorySpendingTitle => 'Chi tiêu theo danh mục';

  @override
  String get paymentMethodSpendingTitle => 'Chi tiêu theo phương thức thanh toán';

  @override
  String get statsPeriodThisWeek => 'Tuần này';

  @override
  String get statsPeriodThisMonth => 'Tháng này';

  @override
  String get statsPeriodLast4Weeks => '4 tuần gần đây';

  @override
  String get statsPeriodMonthly => 'Theo tháng';

  @override
  String get statsPeriodYearly => 'Theo năm';

  @override
  String get cardStatsViewSummary => 'Tóm tắt';

  @override
  String get cardStatsViewByCard => 'Theo thẻ';

  @override
  String get noExpensesInPeriod => 'Không có mục nào trong khoảng thời gian này';

  @override
  String get categoryDetailThisMonthTotal => 'Tổng tháng này';

  @override
  String get categoryDetailMonthlyTrendTitle => 'Xu hướng theo tháng';

  @override
  String get categoryDetailExpenseListTitle => 'Chi tiết giao dịch';

  @override
  String get categoryDetailEmptyMessage => 'Chưa có mục nào được ghi lại';

  @override
  String monthlyTotalLabel(Object month) {
    return 'Tổng $month';
  }

  @override
  String get categoryDetailEmptyMonthMessage => 'Không có chi tiêu trong tháng này 🍊';

  @override
  String get installmentIncludedSuffix => 'gồm cả trả góp';

  @override
  String get cardUnassigned => 'Chưa gán thẻ';

  @override
  String get fillJuiceButton => 'Đổ đầy Juice';

  @override
  String get finishWizardButton => 'Bắt đầu Juice với công thức này';

  @override
  String get incomeTypeFixed => 'Thu nhập cố định';

  @override
  String get incomeTypeVariable => 'Thu nhập biến đổi';

  @override
  String get incomeTypeAllowance => 'Tiền tiêu vặt / Quỹ vốn (Học sinh)';

  @override
  String get freqMonthly => 'Hàng tháng';

  @override
  String get freqBiweekly => 'Mỗi 2 tuần';

  @override
  String get freqWeekly => 'Hàng tuần';

  @override
  String get questionIncomeFixed => 'Mỗi tháng bạn có bao nhiêu juice (thu nhập)? 💰';

  @override
  String get questionIncomeFixedSub => 'Nhập số tiền thực nhận vào tài khoản.';

  @override
  String get questionIncomeVariable => 'Thu nhập an toàn tối thiểu bạn có được ngay cả mùa thấp điểm là bao nhiêu? 💼';

  @override
  String get questionIncomeVariableSub => 'Hãy ước tính thận trọng để kế hoạch vẫn ổn định ngay cả tháng ít việc.';

  @override
  String get questionWeeklyExpenseVariable => 'Mỗi tuần bạn dự định chi bao nhiêu cho sinh hoạt phí (chi tiêu biến đổi)?';

  @override
  String get questionIncomeAllowance => 'Bạn nhận được bao nhiêu tiền tiêu vặt hoặc đã dành dụm được bao nhiêu? 🌱';

  @override
  String get subAllowanceRegular => '🗓️ Tiền tiêu vặt định kỳ';

  @override
  String get subAllowanceIrregular => '🎲 Tiền tiêu vặt/làm thêm không định kỳ';

  @override
  String get questionIrregularMinSave => 'Mỗi tháng, số tiền tối thiểu bạn chắc chắn có thể tiết kiệm là bao nhiêu? 🪙';

  @override
  String praiseVariablePlan(Object amount) {
    return '🍊 Theo mức tối thiểu mùa thấp điểm, bạn có thể an tâm tiết kiệm ít nhất $amount mỗi năm!\nVào những tháng thu nhập cao hơn, hãy dùng juice thưởng để tăng tốc tiết kiệm nhé 🚀';
  }

  @override
  String praiseAllowancePlan(Object amount) {
    return 'Những giọt nước nhỏ rồi sẽ thành biển cả! Sau 1 năm, bạn sẽ có $amount juice tuyệt vời ✨';
  }

  @override
  String get guideExtendGoalPeriod => 'Bạn có muốn kéo dài thời gian mục tiêu một chút để tiết kiệm thoải mái trong khoản tiêu vặt không? 🍊';

  @override
  String freqConversionCaption(Object monthly, Object weekly) {
    return '≈ Quy đổi tháng $monthly · khoảng $weekly mỗi tuần 🍊';
  }

  @override
  String get goalStepQuestion => 'Bạn muốn tiết kiệm\nbao lâu và bao nhiêu?';

  @override
  String get yearsFieldLabel => 'năm';

  @override
  String get monthsFieldLabel => 'tháng';

  @override
  String get goalAmountFieldLabel => 'Số tiền mục tiêu tiết kiệm';

  @override
  String get fixedExpenseStepQuestion => 'Bạn có khoản chi phí\ncố định hàng tháng nào không?';

  @override
  String get fixedExpenseDefaultRent => 'Tiền thuê nhà';

  @override
  String get fixedExpenseDefaultCommunication => 'Cước viễn thông';

  @override
  String get fixedExpenseDefaultInsurance => 'Bảo hiểm';

  @override
  String get fixedExpenseDefaultSubscription => 'Phí đăng ký';

  @override
  String get fixedExpenseStepSubtitle => 'Tiền thuê nhà, bảo hiểm, cước điện thoại, v.v. — chi phí không tính vào bình juice.';

  @override
  String get itemNameHint => 'Tên khoản mục';

  @override
  String get addItemButton => 'Thêm khoản mục';

  @override
  String get resultStepQuestion => 'Kế hoạch juice của riêng bạn\nđã hoàn tất!';

  @override
  String get resultNegativeMessage => 'Chi phí cố định và tiết kiệm vượt quá thu nhập 😥 Hãy quay lại điều chỉnh mục tiêu hoặc thời gian.';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return 'Thu nhập hàng tháng $income - chi phí cố định $fixed - tiền tiết kiệm hàng tháng, còn lại:';
  }

  @override
  String get resultWeeklyPrefix => 'Tuần này bạn có ';

  @override
  String get resultWeeklySuffix => ' juice để thưởng thức! 🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '$daily mL/ngày · $monthly mL/tháng';
  }

  @override
  String get periodDaily => 'Hôm nay';

  @override
  String get periodWeekly => 'Tuần này';

  @override
  String get periodMonthly => 'Tháng này';

  @override
  String get periodSettingDaily => 'Hàng ngày';

  @override
  String get periodSettingWeekly => 'Hàng tuần';

  @override
  String get periodSettingMonthly => 'Hàng tháng';

  @override
  String get weekStartMonday => 'Bắt đầu Thứ Hai (T2–CN)';

  @override
  String get weekStartSunday => 'Bắt đầu Chủ Nhật (CN–T7)';

  @override
  String get installmentModeMonthlyLabel => 'Tính đủ vào tháng sau';

  @override
  String get installmentModeDailyLabel => 'Tính đều mỗi ngày';

  @override
  String get installmentModeMonthlyDescription => 'Giống như sao kê thẻ thực tế, số tiền trả góp được ghi thành một khoản chi vào ngày 1 mỗi tháng.';

  @override
  String get installmentModeDailyDescription => 'Số tiền trả góp của tháng đó được chia theo số ngày và trừ dần mỗi ngày một ít khỏi đồng hồ juice.';

  @override
  String get splashOrangeSubText => 'Ngân sách tuần này, được đổ đầy sảng khoái';

  @override
  String get splashGreenAppleSubText => 'Thói quen chi tiêu tỉnh táo và tươi mới';

  @override
  String get splashGrapeSubText => 'Bảo vệ ngọt ngào giới hạn của riêng bạn';

  @override
  String get splashStrawberrySubText => 'Một ngày được lấp đầy trọn vẹn';

  @override
  String get confirmNewPinPrompt => 'Vui lòng nhập lại mật khẩu mới';

  @override
  String get enterCurrentPinPrompt => 'Vui lòng nhập mật khẩu hiện tại';

  @override
  String get enterNewPinPrompt => 'Vui lòng nhập mật khẩu mới';

  @override
  String get enterPinPrompt => 'Vui lòng nhập mật khẩu';

  @override
  String get juiceLockTitle => 'Juice đang bị khóa';

  @override
  String get pinConfirmMismatchError => 'Mật khẩu không khớp. Vui lòng thử lại';

  @override
  String get pinMismatchError => 'Mật khẩu không khớp';

  @override
  String get shareCardText => 'Thẻ tiết kiệm Juice của tôi';

  @override
  String get unlockJuiceReason => 'Xác thực để mở khóa juice của bạn';

  @override
  String get unlockWithBiometrics => 'Mở khóa bằng sinh trắc học';

  @override
  String yearsPresetLabel(Object years) {
    return '$years năm';
  }

  @override
  String get settingsLanguage => 'Ngôn ngữ';

  @override
  String get settingsCurrency => 'Cài đặt đơn vị tiền tệ gốc';

  @override
  String get currencySelectTitle => 'Chọn đơn vị tiền tệ của bạn';

  @override
  String get commonDone => 'Xong';

  @override
  String get currencyNameKrw => 'Won Hàn Quốc (₩)';

  @override
  String get currencyNameUsd => 'Đô la Mỹ (\$)';

  @override
  String get currencyNameJpy => 'Yên Nhật (¥)';

  @override
  String get currencyNameEur => 'Euro (€)';

  @override
  String get currencyNameVnd => 'Việt Nam Đồng (₫)';

  @override
  String get currencyNameTwd => 'Đô la Đài Loan mới (NT\$)';

  @override
  String get currencyNameCny => 'Nhân dân tệ (¥)';

  @override
  String get currencyNameBrl => 'Real Brazil (R\$)';

  @override
  String get foreignCurrencyPickerTitle => 'Chọn đơn vị tiền thanh toán';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted (tỷ giá hôm nay: $rate)';
  }

  @override
  String get exchangeRateLoadingMessage => 'Đang tải tỷ giá...';

  @override
  String get exchangeRateFailedMessage => 'Không thể tải tỷ giá. Vui lòng nhập thủ công hoặc dùng tỷ giá gần nhất';

  @override
  String get manualRateEntryToggle => 'Nhập tỷ giá thủ công';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => 'Thử lại';

  @override
  String get commonCopy => 'Sao chép';

  @override
  String linkOpenFailedMessage(Object target) {
    return 'Không tìm thấy ứng dụng để mở: $target';
  }

  @override
  String get commonConfirm => 'Xác nhận';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return 'Đổi đơn vị tiền tệ cơ bản sang $toCode? Tất cả số tiền đã ghi trước đó sẽ được tự động quy đổi theo tỷ giá hiện tại.';
  }

  @override
  String get currencyMigrationLoadingMessage => 'Đang quy đổi dữ liệu sổ chi tiêu hiện có sang đơn vị tiền tệ mới... 🍊';

  @override
  String get currencyMigrationFailedMessage => 'Không thể tải tỷ giá nên số tiền hiện có vẫn được giữ nguyên';

  @override
  String get category_food_name => 'Ăn uống';

  @override
  String get category_food_desc => 'Năng lượng thơm ngon cho ngày mới 🍱';

  @override
  String get category_cafe_name => 'Cà phê & Ăn vặt';

  @override
  String get category_cafe_desc => 'Một chút ngọt ngào cho tâm trạng ☕️';

  @override
  String get category_transport_name => 'Giao thông';

  @override
  String get category_transport_desc => 'Di chuyển êm ái đến mọi điểm đến 🚌';

  @override
  String get category_shopping_name => 'Mua sắm';

  @override
  String get category_shopping_desc => 'Niềm vui từ những món đồ ưng ý 🛍️';

  @override
  String get category_culture_name => 'Giải trí';

  @override
  String get category_culture_desc => 'Khoảnh khắc thư giãn ngọt ngào 🎬';

  @override
  String get category_life_name => 'Sinh hoạt';

  @override
  String get category_life_desc => 'Tiện nghi cho cuộc sống thường ngày 🧼';

  @override
  String get category_etc_name => 'Khác';

  @override
  String get category_etc_desc => 'Các khoản chi tiêu đa dạng 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return 'Juice đã giữ được +$amount mL';
  }

  @override
  String get savingHistoryTitle => 'Lịch sử tiết kiệm';

  @override
  String get savingHistoryEmpty => 'Chưa có chu kỳ nào kết thúc.\nHãy hoàn thành chu kỳ đầu tiên!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return 'Đã tiết kiệm +$amount mL!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return 'Chi tiêu vượt $amount mL';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return 'Mục tiêu $target / Đã chi $spent';
  }

  @override
  String get savingOptionTitle => 'Cách xử lý juice còn dư';

  @override
  String get savingOptionDescription => 'Hãy chọn cách xử lý ngân sách chưa dùng hết khi chu kỳ kết thúc.';

  @override
  String get savingOptionRollover => 'Chuyển sang chu kỳ tiếp theo';

  @override
  String get savingOptionSavings => 'Tích lũy làm quỹ dự phòng';

  @override
  String get savedJuiceStoreTooltip => 'Kho Juice đã giữ';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return 'Juice đã giữ được: $amount mL ($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return 'Bao gồm +$amount mL chuyển từ chu kỳ trước';
  }

  @override
  String get savingsAssetCardTitle => 'Tài sản được bảo vệ nhờ tiết kiệm';

  @override
  String get savingsAssetCardDescription => 'Tổng lượng juice còn dư từ các chu kỳ đã đóng với tùy chọn tiết kiệm.';

  @override
  String get savingPraise_1 => 'Bạn đã tiết kiệm được ngần này rồi! Tuyệt vời quá!! Bạn đang tiến gần hơn đến mục tiêu 🍊';

  @override
  String get savingPraise_2 => 'Bạn đã giữ trọn vẹn ly nước quý giá! Thói quen tiết kiệm của bạn thật tuyệt vời ✨';

  @override
  String get savingPraise_3 => 'Từng giọt nước tích lũy đang trở thành tài sản vững chắc! Chúc bạn ngày mới tốt lành 🧃';

  @override
  String get savingPraise_4 => 'Tiết kiệm là một thói quen tuyệt vời! Càng nhiều nước ép dự trữ, tâm trí càng thảnh thơi 🍯';

  @override
  String get savingPraise_5 => 'Bạn thật tuyệt vời khi kiên định giữ vững mục tiêu! Hãy tiếp tục giữ ly nước sau thật tươi mới nhé 🍏';

  @override
  String get savingsLabel => 'Tiết kiệm';

  @override
  String get savingsCategoryTab => 'Danh mục tiết kiệm';

  @override
  String get category_savings_bank_name => 'Tiết kiệm';

  @override
  String get category_savings_bank_desc => 'Khoản tiền lớn dần từng chút một 🏦';

  @override
  String get category_savings_invest_name => 'Đầu tư/Cổ phiếu';

  @override
  String get category_savings_invest_desc => 'Gieo hạt trái cây cho ngày mai 📈';

  @override
  String get category_savings_housing_name => 'Tiết kiệm mua nhà';

  @override
  String get category_savings_housing_desc => 'Giấc mơ ngọt ngào về căn nhà của riêng mình 🏠';

  @override
  String get category_savings_isa_name => 'ISA/Tài khoản tiết kiệm thuế';

  @override
  String get category_savings_isa_desc => 'Chiếc túi tiết kiệm thuế đa năng đáng tin cậy 🛡️';

  @override
  String get category_savings_emergency_name => 'Quỹ khẩn cấp';

  @override
  String get category_savings_emergency_desc => 'Lớp đệm bạn có thể dựa vào bất cứ lúc nào 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return 'Đã ghi $amount mL tiết kiệm cho \'$category\'! 🌱';
  }

  @override
  String get statsTotalIncomeTitle => 'Tổng thu nhập';

  @override
  String get statsTotalSavingsTitle => 'Tổng tiết kiệm';

  @override
  String get incomeCategoryTitleStats => 'Thu nhập theo danh mục';

  @override
  String get savingsCategoryTitleStats => 'Tiết kiệm theo danh mục';

  @override
  String get savingsOverviewSectionTitle => '🌱 Tiết kiệm & Đầu tư';

  @override
  String get savingsThisMonthTotalLabel => 'Tổng tiết kiệm & đầu tư tháng này';

  @override
  String get savingsOverviewEmptyMessage => 'Chưa có khoản tiết kiệm/đầu tư nào được ghi lại';

  @override
  String get scopeThisMonth => 'tháng này';

  @override
  String get calendarSettingsTitle => 'Cài đặt lịch';

  @override
  String get calendarStartDayLabel => 'Ngày bắt đầu lịch';

  @override
  String get calendarStartMon => 'Bắt đầu từ Thứ Hai';

  @override
  String get calendarStartSun => 'Bắt đầu từ Chủ Nhật';

  @override
  String get calendarAmountMode => 'Cách hiển thị số tiền';

  @override
  String get calendarCompactAmount => 'Rút gọn (VD: 56k)';

  @override
  String get calendarFullAmount => 'Đầy đủ (VD: 56.000)';

  @override
  String get calendarShowNoSpendStamp => 'Hiện dấu ngày không chi tiêu';

  @override
  String get calendarHighlightWeekend => 'Tô màu cuối tuần';

  @override
  String get savingsAllTimeTotalLabel => 'Tổng tiết kiệm & đầu tư (từ trước đến nay)';

  @override
  String get currencyWarningNotice => 'Số tiền được quy đổi theo tỷ giá thực tế nên có thể có chênh lệch nhỏ trong dữ liệu cũ. Vui lòng chỉ thay đổi khi thật sự cần thiết!';

  @override
  String get onboardingStep1Title => 'Cùng đặt ngân sách chi tiêu thoải mái nhé?';

  @override
  String get onboardingBudgetLabelDaily => 'Ngân sách mỗi ngày';

  @override
  String get onboardingBudgetLabelWeekly => 'Ngân sách tuần này';

  @override
  String get onboardingBudgetLabelMonthly => 'Ngân sách tháng này';

  @override
  String get onboardingStep1NextButton => 'Tiếp theo: Đặt mục tiêu dài hạn (1/2)';

  @override
  String get onboardingFooterHint => 'Bạn có thể thay đổi bất cứ lúc nào trong phần Cài đặt!';

  @override
  String get onboardingStep2Title => 'Bạn có mục tiêu tiết kiệm cho vài năm tới không?';

  @override
  String get onboardingStep2Subtitle => 'Đặt mục tiêu để chúng tôi tính toán thông minh số tiền cần tiết kiệm mỗi tháng và juice khả dụng.';

  @override
  String get onboardingDurationLabel => 'Thời hạn mục tiêu';

  @override
  String get onboardingGoalAmountLabel => 'Số tiền mục tiêu';

  @override
  String get onboardingCompleteButton => 'Đặt mục tiêu và bắt đầu';

  @override
  String get onboardingSkipButton => 'Bỏ qua lúc này';

  @override
  String get commonBack => 'Quay lại';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return 'Juice (mL) chính là số tiền bạn có thể chi tiêu! (1$symbol = 1 mL)';
  }

  @override
  String get customDuration => 'Tùy chỉnh';

  @override
  String get yearUnit => 'năm';

  @override
  String get monthUnit => 'tháng';

  @override
  String totalDurationLabel(Object months) {
    return 'Tổng cộng $months tháng';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return 'Tiết kiệm khoảng $amount mỗi tháng trong $months tháng là bạn sẽ đạt được mục tiêu! 🌱';
  }

  @override
  String get onboardingChooseGoalType => 'Bạn muốn bắt đầu với mục tiêu nào?';

  @override
  String get onboardingShortTermTitle => 'Ngân sách sinh hoạt ngắn hạn nhẹ nhàng';

  @override
  String get onboardingShortTermDesc => 'Đặt lượng juice bạn sẽ uống hôm nay, tuần này hoặc tháng này và quản lý chi tiêu một cách nhẹ nhàng.';

  @override
  String get onboardingLongTermTitle => 'Mục tiêu tiết kiệm trung, dài hạn vững chắc';

  @override
  String get onboardingLongTermDesc => 'Đặt mục tiêu số tiền lớn bạn muốn đạt được sau vài năm và tiết kiệm một cách thông minh.';

  @override
  String get startWithJuice => 'Đổ đầy juice và bắt đầu';

  @override
  String get startWithLongPlan => 'Lưu kế hoạch và bắt đầu';

  @override
  String get category_income_salary_name => 'Lương';

  @override
  String get category_income_salary_desc => 'Thành quả ngọt ngào của mồ hôi công sức 💼';

  @override
  String get category_income_side_name => 'Thu nhập phụ/Làm thêm';

  @override
  String get category_income_side_desc => 'Khoản thưởng nhỏ ngọt ngào 🍯';

  @override
  String get category_income_allowance_name => 'Tiền tiêu vặt';

  @override
  String get category_income_allowance_desc => 'Món quà bất ngờ đầy niềm vui 🎁';

  @override
  String get category_income_finance_name => 'Thu nhập tài chính (lãi/cổ tức)';

  @override
  String get category_income_finance_desc => 'Trái ngọt từ tiền sinh ra tiền 📈';

  @override
  String get category_income_etc_name => 'Thu nhập khác';

  @override
  String get category_income_etc_desc => 'Các khoản thu nhập đa dạng khác 💧';

  @override
  String get notifEveningMon1Title => '🍊 Thứ Hai vất vả rồi!';

  @override
  String get notifEveningMon1Body => 'Kết thúc ngày bằng 3 giây ghi lại hóa đơn nhé. Khoản ghi đầu tiên của tuần ngọt nhất đấy.';

  @override
  String get notifEveningMon2Title => '📒 Giờ sổ chi tiêu thứ Hai';

  @override
  String get notifEveningMon2Body => 'Đầu tuần là quan trọng nhất. Ghi lại khoản đã chi hôm nay, bạn đã hoàn thành nửa việc quản lý nước ép tuần này!';

  @override
  String get notifEveningMon3Title => '🧃 Đánh bại chứng ngại thứ Hai!';

  @override
  String get notifEveningMon3Body => 'Bạn đã vượt qua ngày đầu tuần rồi. Ghi lại chi tiêu và có một buổi tối ấm áp nhé.';

  @override
  String get notifEveningMon4Title => '☕️ Bạn đã ghi tiền cà phê thứ Hai chưa?';

  @override
  String get notifEveningMon4Body => 'Thứ Hai thường uống thêm một ly. Đừng quên ghi cả những khoản nhỏ hôm nay nhé.';

  @override
  String get notifEveningMon5Title => '🌙 Ngày đầu tuần, chiếc ly thế nào?';

  @override
  String get notifEveningMon5Body => 'Nước ép tuần này vẫn còn nhiều. Chỉ cần ghi đúng khoản đã chi, 6 ngày còn lại sẽ thoải mái hơn hẳn.';

  @override
  String get notifEveningTue1Title => '🍊 Kiểm tra nước ép thứ Ba';

  @override
  String get notifEveningTue1Body => 'Giữ đà từ thứ Hai nhé! Ghi lại chi tiêu hôm nay để thấy nhịp tuần chỉ trong một cái nhìn.';

  @override
  String get notifEveningTue2Title => '🧾 Trước khi hóa đơn chất đống!';

  @override
  String get notifEveningTue2Body => 'Hóa đơn dồn lại càng lười ghi. Dành một phút cho phần hôm nay thôi nhé.';

  @override
  String get notifEveningTue3Title => '🥤 Bạn đã ghi tiền bữa trưa chưa?';

  @override
  String get notifEveningTue3Body => 'Bữa trưa, cà phê, đồ ăn vặt… khoản càng nhỏ càng dễ quên. Ghi hết một lượt trước khi ngủ nhé?';

  @override
  String get notifEveningTue4Title => '🌿 Thói quen nhỏ giữ nước ép của bạn';

  @override
  String get notifEveningTue4Body => 'Một phút ghi chép tối thứ Ba bảo vệ số dư tháng này. Bạn đang làm rất tốt!';

  @override
  String get notifEveningTue5Title => '🎯 Hôm nay đã đạt mục tiêu chưa?';

  @override
  String get notifEveningTue5Body => 'Nếu bạn không vượt quá phần nước ép của hôm nay thì đáng khen lắm! Mở ứng dụng để xem kết quả nhé.';

  @override
  String get notifEveningWed1Title => '⛰ Thứ Tư, đỉnh của tuần!';

  @override
  String get notifEveningWed1Body => 'Vừa đúng nửa tuần. Kiểm tra nước ép còn đủ không và lên kế hoạch cho nửa còn lại nhé.';

  @override
  String get notifEveningWed2Title => '📊 Kiểm tra giữa tuần mực nước ép';

  @override
  String get notifEveningWed2Body => 'Tối thứ Tư là lúc kiểm tra giữa kỳ! Ghi chi tiêu hôm nay và xem nhịp độ tuần này nhé.';

  @override
  String get notifEveningWed3Title => '🍹 Bạn đã qua nửa tuần rồi';

  @override
  String get notifEveningWed3Body => 'Cảm ơn bạn đã cố gắng đến đây. Ghi lại khoản đã chi hôm nay rồi nghỉ ngơi nhé.';

  @override
  String get notifEveningWed4Title => '🐪 Bền bỉ như lạc đà';

  @override
  String get notifEveningWed4Body => 'Hãy kiểm tra chiếc ly trước khi thứ Năm, thứ Sáu đến. Ghi ngay bây giờ, cuối tuần sẽ yên tâm hơn nhiều.';

  @override
  String get notifEveningWed5Title => '🧮 Qua nửa tuần rồi, nước ép còn bao nhiêu?';

  @override
  String get notifEveningWed5Body => 'Cứ ghi lại, phần tính toán để ứng dụng lo. Nhập chi tiêu hôm nay nhé!';

  @override
  String get notifEveningThu1Title => '🌆 Mai là thứ Sáu rồi!';

  @override
  String get notifEveningThu1Body => 'Hãy sắp xếp chi tiêu hôm nay trước cơn sốt thứ Sáu. Biết lượng nước ép còn lại, ngày mai sẽ vui hơn.';

  @override
  String get notifEveningThu2Title => '🛡 Bật khiên phòng thủ cho thứ Sáu';

  @override
  String get notifEveningThu2Body => 'Nếu mai có hẹn, nước ép tiết kiệm hôm nay sẽ là trợ thủ lớn. Ghi chi tiêu hôm nay và chuẩn bị thật vững!';

  @override
  String get notifEveningThu3Title => '🍋 Thứ Năm, ví bắt đầu ngứa ngáy';

  @override
  String get notifEveningThu3Body => 'Cuối tuần càng gần, chiếc ví càng háo hức. Ghi chi tiêu hôm nay để trấn an nó thêm lần nữa.';

  @override
  String get notifEveningThu4Title => '📝 Sắp hết một tuần rồi';

  @override
  String get notifEveningThu4Body => 'Cố thêm chút nữa là đến cuối tuần! Một dòng ghi chép thứ Năm giúp giữ mục tiêu tuần này.';

  @override
  String get notifEveningThu5Title => '🌙 Hôm nay đã kiểm tra ly chưa?';

  @override
  String get notifEveningThu5Body => 'Đón thứ Sáu khi biết mực nước ép khác hẳn đón thứ Sáu mà không biết gì. Xem ngay nhé.';

  @override
  String get notifEveningFri1Title => '🍻 Cuộc chiến giữ ví thứ Sáu bắt đầu!';

  @override
  String get notifEveningFri1Body => 'Tối nay là chiến dịch bảo vệ ví! Cứ vui ăn uống, nhưng mỗi lần thanh toán đều phải ghi lại.';

  @override
  String get notifEveningFri2Title => '🔒 Bật chế độ giữ ví';

  @override
  String get notifEveningFri2Body => 'Cám dỗ thứ Sáu đang ập tới. Nhịn một chút, xem lại ghi chép hôm nay rồi hãy vui nhé!';

  @override
  String get notifEveningFri3Title => '🍕 Khoan đã trước khi mở app giao đồ ăn!';

  @override
  String get notifEveningFri3Body => 'Hãy xem mực nước ép trước. Còn nhiều thì cứ thoải mái, còn ít thì gọi nửa suất thôi!';

  @override
  String get notifEveningFri4Title => '🎉 Cả tuần vất vả rồi, thứ Sáu đây';

  @override
  String get notifEveningFri4Body => 'Vui thì tốt nhưng đừng tiêu quá tay! Ghi đúng khoản đã chi, thứ Hai bạn sẽ mỉm cười.';

  @override
  String get notifEveningFri5Title => '🧃 Tối thứ Sáu, đừng để ly tràn!';

  @override
  String get notifEveningFri5Body => 'Thứ Sáu càng vui, nước ép càng dễ rỉ ra. Hãy gom chi tiêu hôm nay vào sổ nhé.';

  @override
  String get notifEveningSat1Title => '🛍 Ghi lại chi tiêu đi chơi thứ Bảy!';

  @override
  String get notifEveningSat1Body => 'Gặp bạn bè, mua sắm, ăn ngon… hãy ghi lại một lượt khoản đã chi hôm nay trước khi quên.';

  @override
  String get notifEveningSat2Title => '🌇 Cuối tuần của bạn vui chứ?';

  @override
  String get notifEveningSat2Body => 'Chi tiêu hạnh phúc là chi tiêu tốt. Chỉ đừng quên ghi lại! Ngày mai sẽ bớt hối tiếc.';

  @override
  String get notifEveningSat3Title => '🍰 Khoản chi ngọt ngào hôm nay đã ghi chưa?';

  @override
  String get notifEveningSat3Body => 'Ghi cả những khoản xa xỉ nhỏ thì cảm giác tội lỗi cũng tan đi. Để lại một dòng ngay bây giờ nhé?';

  @override
  String get notifEveningSat4Title => '🧺 Giờ tổng kết chi tiêu cuối tuần';

  @override
  String get notifEveningSat4Body => 'Đi chơi cả ngày thì hóa đơn cũng đầy túi nhỉ? Sắp xếp nhanh trước khi ngủ nhé.';

  @override
  String get notifEveningSat5Title => '🌙 Kiểm tra nước ép tối thứ Bảy';

  @override
  String get notifEveningSat5Body => 'Thêm một ngày nữa là nước ép được làm mới. Ghi chi tiêu hôm nay và khép lại ngày thật gọn nhé.';

  @override
  String get notifEveningSun1Title => '🧺 Tối Chủ nhật: khép lại một tuần';

  @override
  String get notifEveningSun1Body => 'Hãy để lại ghi chép cuối cùng của tuần. Nhìn lại một tuần sẽ khiến tuần sau nhẹ nhàng hơn nhiều.';

  @override
  String get notifEveningSun2Title => '🔄 Ngày mai nước ép sẽ được làm mới';

  @override
  String get notifEveningSun2Body => 'Ghi nốt chi tiêu hôm nay là bảng điểm tuần này hoàn tất! Chuẩn bị đón nước ép mới nhé.';

  @override
  String get notifEveningSun3Title => '🍽 Cám dỗ giao đồ ăn tối Chủ nhật';

  @override
  String get notifEveningSun3Body => 'Chỉ cần vượt qua ngày cuối là đạt mục tiêu tuần này! Xem mực nước ép trước khi đặt đồ nhé!';

  @override
  String get notifEveningSun4Title => '🏆 Tuần này bạn cũng vất vả rồi';

  @override
  String get notifEveningSun4Body => 'Bạn đã ghi chép đến cùng, thật đáng nể. Thêm chi tiêu hôm nay rồi nghỉ ngơi thật ngon nhé.';

  @override
  String get notifEveningSun5Title => '🌌 Kiểm tra cuối cùng cho tuần mới';

  @override
  String get notifEveningSun5Body => 'Từ mai chiếc ly lại đầy ắp. Hãy khép lại tuần này thật gọn bằng ghi chép hôm nay.';

  @override
  String get notifMondayTitle => '🍊 Nước ép mới đã đầy ắp rồi!';

  @override
  String get notifMondayBody => 'Tuần trước bạn đã cố gắng rất tốt. Cùng bắt đầu tuần mới tươi mát với ngân sách đầy ắp nhé? ✨';

  @override
  String get notifWeekday1Title => '🌅 Lời tự nhủ của hôm nay';

  @override
  String get notifWeekday1Body => 'Hôm nay tôi dùng nước ép của mình thật khôn ngoan. Tiết kiệm chút ít, cười thật nhiều — chúc bạn một ngày vui!';

  @override
  String get notifWeekday2Title => '🔮 Vận may nước ép hôm nay';

  @override
  String get notifWeekday2Body => 'Hôm nay một lựa chọn nhỏ sẽ thành vị ngọt lớn! Dừng lại 3 giây trước khi mua sắm bốc đồng, may mắn sẽ theo bạn 🍀';

  @override
  String get notifWeekday3Title => '📖 Câu nói của ngày';

  @override
  String get notifWeekday3Body => '“Những giọt nước nhỏ góp lại thành biển cả.” Vài mL bạn tiết kiệm hôm nay rồi sẽ thành mục tiêu lớn.';

  @override
  String get notifWeekday4Title => '☀️ Chào buổi sáng, thật tươi mới nhé!';

  @override
  String get notifWeekday4Body => 'Hôm nay sẽ được lấp đầy đúng theo hình dạng bạn muốn. Bắt đầu thong thả, từng ngụm một.';

  @override
  String get notifWeekday5Title => '🍀 Điểm may mắn hôm nay';

  @override
  String get notifWeekday5Body => 'May mắn hôm nay là “ghi chép”! Ghi lại khoản đã chi, lòng và ví đều nhẹ nhõm hơn.';

  @override
  String get notifWeekday6Title => '🌱 Tâm thế của hôm nay';

  @override
  String get notifWeekday6Body => 'Không cần hoàn hảo đâu. Chỉ cần tiết kiệm hơn hôm qua một chút là bạn đã làm rất tốt.';

  @override
  String get notifWeekday7Title => '🌈 Một thìa cổ vũ';

  @override
  String get notifWeekday7Body => 'Bạn đang làm tốt hơn mình nghĩ nhiều. Hôm nay cũng cổ vũ cho những lựa chọn khôn ngoan của bạn!';

  @override
  String get notifWeekday8Title => '✨ Vận hôm nay: đại cát';

  @override
  String get notifWeekday8Body => 'Hôm nay ví của bạn tràn đầy năng lượng tốt. Rộng rãi đúng chỗ cần, dứt khoát đúng chỗ không cần!';

  @override
  String get notifSunday1Title => '🌤 Lời tự nhủ Chủ nhật';

  @override
  String get notifSunday1Body => 'Tôi đã sống tốt một tuần và sẽ làm tốt cả tuần mới. Chúc bạn một Chủ nhật thư thái.';

  @override
  String get notifSunday2Title => '📖 Câu nói Chủ nhật';

  @override
  String get notifSunday2Body => '“Thời gian dừng lại nhìn lại đưa ta đi xa nhất.” Hôm nay là ngày lặng lẽ nhìn lại nước ép của tuần này.';

  @override
  String get notifSunday3Title => '🔮 Vận Chủ nhật: nạp năng lượng';

  @override
  String get notifSunday3Body => 'Ngày tuyệt vời để nạp năng lượng cho ngày mai! Nghỉ ngơi thong thả thay vì chi tiêu lớn sẽ mang may mắn đến 🍀';

  @override
  String get notifComeback1Title => '🍊 Quả cam buồn quá nên bắt đầu tự bóc vỏ.';

  @override
  String get notifComeback1Body => 'Hai ngày không ghé… chắc không phải vì lén tiêu tiền rồi ngại mở ứng dụng nước ép chứ? Vào ngay và thú nhận đi.';

  @override
  String get notifComeback2Title => '🧃 Đáy bình nước ép đang mọc mốc…';

  @override
  String get notifComeback2Body => 'Hóa đơn 3 ngày chưa ghi đang gặm nhấm tài khoản của bạn. Làm ơn mở tôi lên và cắt bỏ những khoản chi thối rữa đi! 😱';

  @override
  String get notifComeback3Title => '🍋 [KHẨN CẤP] Số dư tài khoản đang rỉ ra.';

  @override
  String get notifComeback3Body => 'Tưởng không mở ứng dụng thì tiền đã tiêu sẽ biến mất sao? Hóa đơn biết hết đấy. Hôm nay mà không vào, tôi sẽ hất đổ ly nước ép của bạn đấy? 💥';

  @override
  String get notifComeback4Title => '🫗 …Tôi đã làm gì sai sao?';

  @override
  String get notifComeback4Body => 'Cả tuần nay bạn bỏ đói nước ép rồi. Ly trống đang đóng bụi. Mục tiêu tiết kiệm của bạn cũng đang bay đi như bụi… hu hu.';

  @override
  String get notifComeback5Title => '💀 Chúc mừng! Nước ép đã bay hơi hoàn toàn.';

  @override
  String get notifComeback5Body => '2 tuần không ghé thì chắc đã cháy túi rồi nhỉ. Vào ngay để cứu lấy giọt lương tâm cuối cùng còn sót lại nhé? 🏃‍♂️💨';

  @override
  String get notifChannelName => 'Nhắc nhở Juice';

  @override
  String get notifChannelDescription => 'Nhắc ghi chép chi tiêu buổi sáng/tối và tin nhắn cổ vũ';
}
