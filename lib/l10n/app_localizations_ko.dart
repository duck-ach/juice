import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '주스 버젯';

  @override
  String get selectLanguage => '언어를 선택해 주세요';

  @override
  String get setBudgetTitle => '목표 주스를 채워볼까요?';

  @override
  String get weeklyBudget => '이번 주 남은 주스';

  @override
  String get paymentCheckCard => '체크카드';

  @override
  String get paymentCreditCard => '신용카드';

  @override
  String get defaultCheckCardName => '체크카드 (기본)';

  @override
  String get defaultCreditCardName => '신용카드 (기본)';

  @override
  String get paymentCash => '현금·이체';

  @override
  String get commonCancel => '취소';

  @override
  String get commonSave => '저장';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonEdit => '수정';

  @override
  String get commonAdd => '추가';

  @override
  String get commonNext => '다음';

  @override
  String get goalSettingsTitle => '목표 설정';

  @override
  String get activePeriodSectionTitle => '활성 목표 주기';

  @override
  String get activePeriodSectionDescription => '홈 화면 게이지가 기준으로 삼는 주기예요. 아래에서 각 주기의 목표 금액을 미리 채워두면 전환할 때 바로 반영돼요.';

  @override
  String get weekStartDayTileTitle => '주간 시작 요일';

  @override
  String get periodTargetSectionTitle => '주기별 목표 금액';

  @override
  String get periodTargetSectionDescription => '주기마다 목표 금액을 따로 저장해두고 필요할 때 골라 쓸 수 있어요.';

  @override
  String get periodTargetAmountSuffix => '목표 금액';

  @override
  String get installmentSectionTitle => '신용카드 할부 반영 방식';

  @override
  String get installmentSectionDescription => '할부로 등록한 지출을 캘린더/주스 게이지에 언제, 어떻게 나눠 반영할지 골라주세요.';

  @override
  String get recommendedSuffix => '추천';

  @override
  String get savingsPlanSectionTitle => '중/장기 저축 목표 플래너';

  @override
  String get savingsPlanSectionDescription => '월 수입과 고정지출, 저축 목표를 입력하면 변동지출로 쓸 수 있는 주스 용량을 계산해드려요.';

  @override
  String get savingsPlanToggleTitle => '중/장기 저축 목표가 있으신가요?';

  @override
  String get autoBudgetSetMessage => '일/주/월 목표 금액이 자동 설정됐어요 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 나의 주스 플랜 요약';

  @override
  String get replanButton => '플랜 다시 짜기';

  @override
  String get applyBudgetButton => '이 예산으로 주스 자동 세팅하기';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years년 $months개월';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years년';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months개월';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return '목표: $duration 동안 $amount 모으기';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return '숨만 쉬어도 나가는 돈(고정비): 월 $amount';
  }

  @override
  String get savingsPlanMonthlyRequiredLabel => '매월 저축해야 하는 금액';

  @override
  String savingsPlanMonthlyRequiredAmount(Object amount) {
    return '$amount';
  }

  @override
  String get savingsPlanAchievementRateLabel => '목표 달성률';

  @override
  String get savingsPlanRecommendedSectionLabel => '추천 사용 가능 금액';

  @override
  String get savingsPlanDailyGridLabel => '하루';

  @override
  String get savingsPlanWeeklyGridLabel => '이번 주';

  @override
  String get savingsPlanMonthlyGridLabel => '이번 달';

  @override
  String get savingsPlanViewInAssetsButton => '자산 탭에서 자세히 보기';

  @override
  String savingsPlanActualTraceLine(Object actual, Object goal, Object percent) {
    return '실제 저축 $actual / 목표 $goal ($percent%)';
  }

  @override
  String get manageFixedIncomesButton => '고정수입 관리';

  @override
  String savingsPlanFixedIncomeTotalLine(Object total) {
    return '고정수입 합계: $total';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return '추천 주스 한 잔: 하루 $daily mL / 이번 주 $weekly mL / 이번 달 $monthly mL';
  }

  @override
  String savingsPlanPaceFasterLine(Object months) {
    return '현재 저축 페이스라면 목표보다 $months개월 빠르게 달성 중이에요! 🚀';
  }

  @override
  String savingsPlanPaceSlowerLine(Object months) {
    return '지금 페이스라면 목표보다 $months개월 늦어질 수 있어요. 조금만 더 힘내봐요 💪';
  }

  @override
  String get savingsPlanPaceOnTrackLine => '지금 페이스가 계획과 딱 맞아요! 이대로 쭉 가봐요 🍊';

  @override
  String get recalibrateButton => '소득 변동 · 재조정';

  @override
  String get recalibrateSheetTitle => '플랜 재조정';

  @override
  String get recalibrateSheetSubtitle => '달라진 월 수입을 입력하면 두 가지 방법 중 골라 바로 반영할 수 있어요.';

  @override
  String get recalibrateIncomeFieldLabel => '새 월 수입';

  @override
  String get recalibrateShortenOption => '목표 기간 단축하기';

  @override
  String recalibrateShortenPreview(Object before, Object after) {
    return '생활비는 지금 그대로, 목표 기간을 $before개월 → $after개월로 줄여요.';
  }

  @override
  String get recalibrateShortenUnavailable => '새 수입으로는 지금 생활비를 유지한 채 기간을 줄일 수 없어요.';

  @override
  String get recalibrateBoostOption => '주스(생활비) 늘리기';

  @override
  String recalibrateBoostPreview(Object before, Object after) {
    return '목표 기간은 그대로, 하루 주스를 $before mL → $after mL로 늘려요.';
  }

  @override
  String get recalibrateBudgetSliderLabel => '이번 달 생활비(주스) 예산';

  @override
  String get recalibrateWeeklyBudgetLabel => '주간 목표';

  @override
  String recalibratePreviewLine(Object before, Object after) {
    return '이 예산이면 목표 기간이 $before개월 → $after개월로 바뀌어요';
  }

  @override
  String get recalibrateNoSavingsWarning => '이 예산이면 이번 달은 저축을 못 해요. 슬라이더를 왼쪽으로 옮겨보세요';

  @override
  String get recalibrateStatGoal => '목표 금액';

  @override
  String get recalibrateStatSaved => '모은 금액';

  @override
  String get recalibrateStatRemaining => '남은 금액';

  @override
  String get settingsTitle => '설정';

  @override
  String get savingsCardSectionTitle => '이번 주 절약 카드';

  @override
  String get savingsCardSectionDescription => '예산 방어에 성공한 한 주를 카드로 만들어 공유해보세요.';

  @override
  String get generatingCard => '카드 생성 중...';

  @override
  String get shareCardButton => '카드 공유하기';

  @override
  String shareCardFailedMessage(Object error) {
    return '카드 공유에 실패했어요: $error';
  }

  @override
  String get setTargetAmountFirst => '목표 금액을 먼저 설정해주세요';

  @override
  String get menuGoalSettingsTitle => '목표 설정';

  @override
  String get menuGoalSettingsSubtitle => '장기 저축 목표, 목표 주기, 주기별 목표 금액';

  @override
  String get menuFixedExpenseManagementTitle => '고정지출 관리';

  @override
  String get menuFixedExpenseManagementSubtitle => '고정지출 항목 관리 및 캘린더 자동 기입 설정';

  @override
  String get fixedExpenseManageInfoBanner => '중/장기 저축플랜의 고정지출과 연동되어 고정지출이 늘어나거나 줄어들 경우 일/주/월 사용 가능 예산이 달라질 수 있습니다.';

  @override
  String get fixedExpensePaymentDayLabel => '지급일';

  @override
  String fixedExpenseDayOptionLabel(Object day) {
    return '$day일';
  }

  @override
  String get fixedExpenseLastDayOptionLabel => '31일 (말일)';

  @override
  String get calendarAutoFillTitle => '고정지출 캘린더 자동 기입';

  @override
  String get calendarAutoFillSubtitle => '매월 등록한 고정지출을 캘린더에 자동으로 기록해요';

  @override
  String get menuThemeSettingsTitle => '테마 설정';

  @override
  String get menuThemeSettingsSubtitle => '화면 모드 및 주스 테마';

  @override
  String get menuWidgetSettingsTitle => '위젯 설정';

  @override
  String get menuWidgetSettingsSubtitle => '홈 화면 위젯 금액 가리기';

  @override
  String get menuCardManagementTitle => '내 카드 관리';

  @override
  String get menuCardManagementSubtitle => '보유 카드 등록, 순서 변경';

  @override
  String get menuNotificationSettingsTitle => '알림 설정';

  @override
  String get menuNotificationSettingsSubtitle => '아침/저녁 리마인더 알림 켜기/끄기';

  @override
  String get menuBackupSettingsTitle => '데이터 백업 및 복원';

  @override
  String get menuBackupSettingsSubtitle => 'CSV 내보내기, 백업 파일 내보내기/불러오기';

  @override
  String get menuSecuritySettingsTitle => '보안';

  @override
  String get menuSecuritySettingsSubtitle => 'PIN 번호, 생체인증';

  @override
  String get menuContactSupportTitle => '문의 및 피드백 보내기';

  @override
  String get menuContactSupportSubtitle => '이메일로 의견을 보내주세요';

  @override
  String get feedbackTitle => '문의 및 피드백 🍊';

  @override
  String get feedbackTypeBug => '버그 제보';

  @override
  String get feedbackTypeFeature => '기능 제안';

  @override
  String get feedbackTypeOther => '기타';

  @override
  String get feedbackEmailHint => '답변받으실 이메일 (선택)';

  @override
  String get feedbackContentHint => '소중한 의견을 남겨주세요.';

  @override
  String get feedbackAttachImage => '스크린샷 첨부';

  @override
  String get feedbackSubmit => '보내기';

  @override
  String get feedbackDeviceInfoNotice => '원활한 문의 해결을 위해 기기/OS 정보가 함께 전송됩니다.';

  @override
  String get feedbackComposeReplyEmail => '회신 이메일';

  @override
  String get feedbackComposeNotEntered => '(미입력)';

  @override
  String get feedbackComposeContent => '내용';

  @override
  String get feedbackComposeDeviceInfo => '기기 정보';

  @override
  String get feedbackContentRequired => '문의 내용을 입력해 주세요';

  @override
  String get feedbackMailUnavailable => '메일 앱을 열 수 없어 문의 내용이 복사되었어요.';

  @override
  String get privacyPolicyTitle => '개인정보 처리방침';

  @override
  String get menuPrivacyPolicySubtitle => '개인정보를 어떻게 다루는지 확인해보세요';

  @override
  String get privacyWelcomeTitle => '주스 버젯에 오신 것을 환영해요!';

  @override
  String get privacyAgreeNotice => '주스 버젯은 100% 온디바이스 로컬 가계부로, 회원의 어떠한 금융 정보나 개인정보도 외부 서버로 전송하지 않습니다.';

  @override
  String get viewPrivacyPolicy => '개인정보 처리방침 전문 보기';

  @override
  String get agreeAndStart => '동의하고 시작하기';

  @override
  String get savingsCardSuccessMessage => '이번 주 주스를\n신선하게 지켜냈어요!';

  @override
  String get savingsCardOverMessage => '이번 주 주스가\n조금 넘쳤어요';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return '$budget 중 $spent 소비';
  }

  @override
  String get savingsCardSuccessStamp => '성공';

  @override
  String get savingsCardOverStamp => '분발';

  @override
  String get pinSetupTitle => '비밀번호 설정';

  @override
  String get biometricUnlockReason => '잠금을 해제하려면 인증해주세요';

  @override
  String get pinConfirmTitle => '비밀번호 확인';

  @override
  String get pinConfirmCurrentTitle => '현재 비밀번호 확인';

  @override
  String get pinSetupNewTitle => '새 비밀번호 설정';

  @override
  String get pinChangedMessage => '비밀번호가 변경되었어요';

  @override
  String get biometricLinkTitle => '생체인증 연동';

  @override
  String get biometricLinkConfirm => '생체인증을 연동하시겠습니까?';

  @override
  String get biometricLinkAction => '연동';

  @override
  String get biometricLinkReason => '생체인증을 연동하려면 인증해주세요';

  @override
  String get biometricUnavailableMessage => '생체인증을 사용할 수 없어요';

  @override
  String get securityTitle => '보안';

  @override
  String get securityDescription => 'PIN 번호와 생체인증으로 앱을 잠글 수 있어요.';

  @override
  String get appLockTitle => '앱 잠금';

  @override
  String get appLockDescription => 'PIN 4자리로 앱 진입을 보호해요.';

  @override
  String get changePasswordTitle => '비밀번호 변경';

  @override
  String get biometricUseTitle => '생체인증 사용';

  @override
  String get biometricUseDescription => 'Face ID/지문으로 더 빠르게 잠금을 해제해요.';

  @override
  String get csvShareText => '주스 지출 내역';

  @override
  String get csvHeaderDate => '날짜';

  @override
  String get csvHeaderCategory => '카테고리';

  @override
  String get csvHeaderAmount => '금액';

  @override
  String get csvHeaderIsFixed => '고정지출 여부';

  @override
  String get csvHeaderMemo => '메모';

  @override
  String get csvUnknownCategory => '알 수 없음';

  @override
  String get backupShareText => '주스 데이터 백업';

  @override
  String backupFailedMessage(Object error) {
    return '백업에 실패했어요: $error';
  }

  @override
  String get restoreDataTitle => '데이터 복원';

  @override
  String get restoreDataConfirm => '기존 데이터가 백업 파일 내용으로 대체됩니다. 계속할까요?';

  @override
  String get restoreAction => '복원';

  @override
  String get restoreSuccessMessage => '복원이 완료됐어요';

  @override
  String get restoreFailedMessage => '복원에 실패했어요. 올바른 주스 백업 파일인지 확인해주세요';

  @override
  String get backupSettingsTitle => '데이터 백업 및 복원';

  @override
  String get exportExpensesTitle => '지출 내역 내보내기';

  @override
  String get exportExpensesDescription => '날짜, 카테고리, 금액, 고정지출 여부, 메모가 담긴 CSV 파일을 공유해요.';

  @override
  String get exportingCsv => '내보내는 중...';

  @override
  String get exportCsvButton => 'CSV로 내보내기';

  @override
  String get backupRestoreTitle => '데이터 백업 · 복원';

  @override
  String get backupRestoreDescription => '지출/수입 내역, 카테고리, 예산 설정을 파일 하나로 백업하고 복원할 수 있어요.';

  @override
  String get backupDataTitle => '데이터 백업하기';

  @override
  String get backupDataDescription => '공유창을 통해 파일 앱, 이메일 등으로 저장해요.';

  @override
  String get restoreDataTileTitle => '데이터 복원하기';

  @override
  String get restoreDataTileDescription => '백업 파일을 선택해 기존 데이터를 덮어써요.';

  @override
  String get categoryDefaultDescription => '나만의 특별한 주스 레시피';

  @override
  String get categoryDeleteTitle => '카테고리 삭제';

  @override
  String categoryDeleteConfirm(Object name) {
    return '\'$name\' 카테고리를 삭제할까요?\n이미 기록된 지출 내역은 유지돼요.';
  }

  @override
  String get categoryInUseMessage => '이 카테고리를 사용 중인 내역이 있어요. 먼저 다른 카테고리로 옮긴 뒤 삭제해주세요';

  @override
  String get categoryEditTitle => '카테고리 수정';

  @override
  String get categoryAddTitle => '카테고리 추가';

  @override
  String get categoryNameLabel => '카테고리 이름';

  @override
  String get categoryDescriptionLabel => '한 줄 설명';

  @override
  String get colorLabel => '색상';

  @override
  String get iconLabel => '아이콘';

  @override
  String get categoryManageTitle => '카테고리 관리';

  @override
  String get expenseCategoryTab => '지출 카테고리';

  @override
  String get incomeCategoryTab => '수입 카테고리';

  @override
  String get defaultCategoryUndeletable => '기본 카테고리는 삭제할 수 없어요';

  @override
  String get cardDeleteTitle => '카드 삭제';

  @override
  String cardDeleteConfirm(Object name) {
    return '\'$name\' 카드를 삭제할까요?\n이미 기록된 지출 내역은 유지돼요.';
  }

  @override
  String get cardEditTitle => '카드 수정';

  @override
  String get cardAddTitle => '카드 추가';

  @override
  String get cardNameLabel => '카드 이름';

  @override
  String get cardTypeLabel => '카드 종류';

  @override
  String get cardManagementTitle => '내 카드 관리';

  @override
  String get defaultCardLastOneUndeletable => '같은 종류의 카드가 이것뿐이라 삭제할 수 없어요. 다른 카드를 먼저 추가해 주세요.';

  @override
  String get cardTypeCorporate => '법인/업무용';

  @override
  String get cardTypeCorporateExcluded => '법인(경비) · 주스 제외';

  @override
  String get corporateExpenseNotice => '🏢 법인/업무용 지출은 카테고리 선택 없이 개인 지출에서 자동 제외돼요.';

  @override
  String get corporateBadgeLabel => '🏢 법인/업무용 · 개인 지출 제외';

  @override
  String get corporateCardLabel => '법인/업무용 카드';

  @override
  String get corporateMemoRequired => '법인/업무용 지출은 메모(용도)를 입력해야 해요';

  @override
  String get juiceThemeLabel => '주스 테마';

  @override
  String get themeSettingsTitle => '테마 설정';

  @override
  String get screenModeLabel => '화면 모드';

  @override
  String get themeModeSystem => '시스템';

  @override
  String get themeModeLight => '라이트';

  @override
  String get themeModeDark => '다크';

  @override
  String get juiceThemeDescription => '잔여량에 따라 색이 바뀌는 홈 화면 주스 색을 골라보세요. 앱 전체 포인트 컬러에도 반영돼요.';

  @override
  String get themeOrange => '오렌지';

  @override
  String get themeStrawberry => '딸기';

  @override
  String get themeApple => '사과';

  @override
  String get themeGrape => '포도';

  @override
  String get themeBlueberry => '블루베리';

  @override
  String get themeMulberry => '오디';

  @override
  String get themeRandom => '랜덤 (앱 켤 때마다)';

  @override
  String get widgetSettingsTitle => '위젯 설정';

  @override
  String get homeScreenWidgetTitle => '홈 화면 위젯';

  @override
  String get homeScreenWidgetDescription => '홈 화면에 주스 게이지 위젯과 빠른 입력 위젯을 추가할 수 있어요.';

  @override
  String get hideWidgetAmountTitle => '위젯에서 금액 가리기';

  @override
  String get hideWidgetAmountDescription => '금액 대신 ***mL와 잔여 % 수위만 표시해요.';

  @override
  String get notificationSettingsTitle => '알림 설정';

  @override
  String get notificationScheduleDescription => '매일 아침 7시, 저녁 8시에 기록을 유도하는 알림을 보내드려요.';

  @override
  String get receiveNotificationsTitle => '주스 알림 받기';

  @override
  String get receiveNotificationsDescription => '오래 접속하지 않으면 재방문을 유도하는 알림도 함께 보내요.';

  @override
  String get navHome => '홈';

  @override
  String get navCalendar => '캘린더';

  @override
  String get navAssets => '자산';

  @override
  String get navStats => '통계';

  @override
  String get navSettings => '설정';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 오늘의 할부 분할액: $amount mL';
  }

  @override
  String get filterVariableOnlyLong => '변동지출만 보기';

  @override
  String get filterAllLong => '전체 내역 보기';

  @override
  String noGoalTitle(Object period) {
    return '$period 목표 금액이 아직 없어요';
  }

  @override
  String noGoalDescription(Object period) {
    return '목표 설정에서 $period 목표 금액을 채워주세요.';
  }

  @override
  String get goToGoalSettings => '목표 설정으로 이동';

  @override
  String get noExpensesYet => '아직 기록된 지출이 없어요';

  @override
  String remainingJuiceLabel(Object period) {
    return '$period 남은 주스';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '소진율 $percent%';
  }

  @override
  String get overBudgetMessage1 => '아쉬워요! 다음 주엔 주스 남기기 꼭 성공해 봐요 🍊';

  @override
  String get overBudgetMessage2 => '주스 통이 텅 비었어요! 이번 주는 잠시 쉬어가요 🥲';

  @override
  String get overBudgetMessage3 => '넘친 주스는 어쩔 수 없죠! 다음 주에 다시 꽉 채워봐요 🧃';

  @override
  String get overBudgetMessage4 => '마지막 한 방울까지 탈탈! 다음 주엔 조금만 천천히 마셔요 ✨';

  @override
  String get incomeFallbackName => '수입';

  @override
  String get unknownCategoryName => '알 수 없음';

  @override
  String get fixedExpenseLabel => '고정지출';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return '할부 $index/$months';
  }

  @override
  String get deletedMessage => '삭제되었습니다';

  @override
  String get undoAction => '실행취소';

  @override
  String get amountAndCategoryRequired => '금액과 카테고리를 확인해주세요';

  @override
  String get expenseLabel => '지출';

  @override
  String get incomeLabel => '수입';

  @override
  String editTypeTitle(Object type) {
    return '$type 수정';
  }

  @override
  String addTypeTitle(Object type) {
    return '$type 추가';
  }

  @override
  String deleteTypeTitle(Object type) {
    return '$type 삭제';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return '이 $type 내역을 삭제할까요?';
  }

  @override
  String get cardSelectLabel => '카드 선택';

  @override
  String installmentMemoSuffix(Object index, Object months) {
    return '($index/$months회차)';
  }

  @override
  String installmentEditNotice(Object index, Object months) {
    return '할부 $index/$months회차 — 다른 회차 금액은 함께 바뀌지 않아요';
  }

  @override
  String get lumpSumLabel => '일시불';

  @override
  String monthsPresetLabel(Object months) {
    return '$months개월';
  }

  @override
  String get customInputLabel => '직접 입력';

  @override
  String get monthsCountHint => '개월 수 (2~24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return '매달 $amount mL씩 $months회 분할 반영돼요';
  }

  @override
  String get memoHint => '메모 (선택)';

  @override
  String get excludeAsFixedTitle => '고정지출로 제외';

  @override
  String get excludeAsFixedSubtitle => '월세, 보험료 등 — 주스 게이지에 반영되지 않아요';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return '\'$category\' 수입 $amount mL가 들어왔어요! 💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return '\'$category\' 지출 $amount mL를 기록했어요! 🍊';
  }

  @override
  String get calendarTitle => '캘린더';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return '이번 달 총 지출 $expense · 총 수입 $income';
  }

  @override
  String get filterVariableOnlyShort => '변동지출만';

  @override
  String get filterAllShort => '전체 내역';

  @override
  String get noExpenseTodayMessage => '지출 없는 상쾌한 날이에요! 🍊';

  @override
  String get assetsTitle => '자산';

  @override
  String get cumulativeNetWorthLabel => '누적 순자산';

  @override
  String get cumulativeNetWorthDescription => '지금까지 기록된 모든 수입에서 지출을 뺀 값이에요.';

  @override
  String get scopeThisYear => '올해';

  @override
  String get scopeLast5Years => '5년간';

  @override
  String totalIncomeLabel(Object scope) {
    return '$scope 총 수입';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return '$scope 총 지출';
  }

  @override
  String get netChangeTrendTitle => '순증감 추이';

  @override
  String get netChangeTrendDescription => '수입에서 지출을 뺀 순증감이에요. 초록은 흑자, 빨강은 적자예요.';

  @override
  String get statsTitle => '통계';

  @override
  String get filterFixedIncluded => '고정비 포함';

  @override
  String get totalExpenseTitle => '총 지출';

  @override
  String get categorySpendingTitle => '카테고리별 소비';

  @override
  String get paymentMethodSpendingTitle => '결제 수단별 소비';

  @override
  String get statsPeriodThisWeek => '이번 주';

  @override
  String get statsPeriodThisMonth => '이번 달';

  @override
  String get statsPeriodLast4Weeks => '최근 4주';

  @override
  String get statsPeriodMonthly => '월별';

  @override
  String get statsPeriodYearly => '연도별';

  @override
  String get cardStatsViewSummary => '대분류 요약';

  @override
  String get cardStatsViewByCard => '카드별 상세';

  @override
  String get noExpensesInPeriod => '해당 기간에 내역이 없어요';

  @override
  String get categoryDetailThisMonthTotal => '이번 달 합계';

  @override
  String get categoryDetailMonthlyTrendTitle => '월별 추이';

  @override
  String get categoryDetailExpenseListTitle => '상세 내역';

  @override
  String get categoryDetailEmptyMessage => '아직 기록된 내역이 없어요';

  @override
  String monthlyTotalLabel(Object month) {
    return '$month 합계';
  }

  @override
  String get categoryDetailEmptyMonthMessage => '이 달에는 지출 내역이 없어요 🍊';

  @override
  String get installmentIncludedSuffix => '할부 포함';

  @override
  String get cardUnassigned => '카드 미지정';

  @override
  String get fillJuiceButton => '주스 채우기';

  @override
  String get finishWizardButton => '이 레시피로 주스 시작하기';

  @override
  String get incomeTypeFixed => '고정 소득 (직장인·알바)';

  @override
  String get incomeTypeVariable => '불규칙 소득 (프리랜서·자영업)';

  @override
  String get incomeTypeAllowance => '용돈·시드머니 (학생)';

  @override
  String get freqMonthly => '매월';

  @override
  String get freqBiweekly => '2주마다';

  @override
  String get freqWeekly => '매주';

  @override
  String get questionIncomeFixed => '매달 들어오는 주스(수입)는 얼마인가요? 💰';

  @override
  String get questionIncomeFixedSub => '실제 통장에 들어오는 금액을 적어주세요.';

  @override
  String get questionIncomeVariable => '비수기에도 들어오는 최소 안전 수입은 얼마인가요? 💼';

  @override
  String get questionIncomeVariableSub => '보수적으로 잡아야 일이 적은 달에도 플랜을 유지할 수 있어요.';

  @override
  String get questionWeeklyExpenseVariable => '일주일에 생활비(변동지출)로 얼마를 쓰실 예정인가요?';

  @override
  String get questionIncomeAllowance => '받는 용돈이나 모아둔 금액은 얼마인가요? 🌱';

  @override
  String get subAllowanceRegular => '🗓️ 정기적인 용돈';

  @override
  String get subAllowanceIrregular => '🎲 비정기 용돈/알바';

  @override
  String get questionIrregularMinSave => '한 달에 \'이 정도는 꼭 저축할 수 있다\' 하는 최소 금액은 얼마인가요? 🪙';

  @override
  String praiseVariablePlan(Object amount) {
    return '🍊 비수기 기준, 1년에 최소 $amount 규모를 든든하게 지켜낼 수 있어요!\n수입이 더 많이 들어온 달에는 보너스 주스로 저축 속도를 확 당겨봐요 🚀';
  }

  @override
  String praiseAllowancePlan(Object amount) {
    return '작은 물방울이 모여 바다가 돼요! 1년 뒤엔 $amount 규모의 멋진 주스가 완성돼요 ✨';
  }

  @override
  String get guideExtendGoalPeriod => '용돈 안에서 편안하게 모을 수 있도록 목표 기간을 조금만 늘려볼까요? 🍊';

  @override
  String freqConversionCaption(Object monthly, Object weekly) {
    return '≈ 월 환산 $monthly / 주간 가용 약 $weekly 🍊';
  }

  @override
  String get goalStepQuestion => '얼마 동안, 얼마를\n모으고 싶나요?';

  @override
  String get yearsFieldLabel => '년';

  @override
  String get monthsFieldLabel => '개월';

  @override
  String get goalAmountFieldLabel => '목표 모을 금액';

  @override
  String get fixedExpenseStepQuestion => '매달 고정으로\n빠져나가는 돈이 있나요?';

  @override
  String get fixedExpenseDefaultRent => '월세';

  @override
  String get fixedExpenseDefaultCommunication => '통신비';

  @override
  String get fixedExpenseDefaultInsurance => '보험료';

  @override
  String get fixedExpenseDefaultSubscription => '구독료';

  @override
  String get fixedExpenseStepSubtitle => '월세, 보험료, 통신비 등 주스 통에 담지 않을 비용이에요.';

  @override
  String get itemNameHint => '항목명';

  @override
  String get addItemButton => '항목 추가';

  @override
  String get resultStepQuestion => '나만의 주스 플랜이\n완성되었어요!';

  @override
  String get resultNegativeMessage => '고정지출과 저축액이 수입보다 많아요 😥 이전 단계로 돌아가 목표나 기간을 조정해보세요.';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return '월 수입 $income - 고정비 $fixed - 월 저축액을 빼면,';
  }

  @override
  String get resultWeeklyPrefix => '이번 주 ';

  @override
  String get resultWeeklySuffix => '의 주스를 마실 수 있어요! 🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '하루 $daily mL · 한 달 $monthly mL';
  }

  @override
  String get periodDaily => '오늘';

  @override
  String get periodWeekly => '이번 주';

  @override
  String get periodMonthly => '이번 달';

  @override
  String get periodSettingDaily => '일간';

  @override
  String get periodSettingWeekly => '주간';

  @override
  String get periodSettingMonthly => '월간';

  @override
  String get weekStartMonday => '월요일 시작 (월~일)';

  @override
  String get weekStartSunday => '일요일 시작 (일~토)';

  @override
  String get installmentModeMonthlyLabel => '익월 1일 일괄 청구';

  @override
  String get installmentModeDailyLabel => '매일 균등 분할 청구';

  @override
  String get installmentModeMonthlyDescription => '실제 카드 대금처럼, 할부 회차 금액이 매월 1일에 한 번에 지출로 잡혀요.';

  @override
  String get installmentModeDailyDescription => '그 달의 할부 회차 금액을 일수만큼 나눠 매일 조금씩 주스 게이지에서 빠져나가요.';

  @override
  String get splashOrangeSubText => '상쾌하게 채우는 이번 주 예산';

  @override
  String get splashGreenAppleSubText => '싱그럽게 아끼는 소비 습관';

  @override
  String get splashGrapeSubText => '달콤하게 지켜내는 나만의 한도';

  @override
  String get splashStrawberrySubText => '기분 좋게 채워지는 하루';

  @override
  String get confirmNewPinPrompt => '새 비밀번호를 다시 입력해주세요';

  @override
  String get enterCurrentPinPrompt => '현재 비밀번호를 입력해주세요';

  @override
  String get enterNewPinPrompt => '새 비밀번호를 입력해주세요';

  @override
  String get enterPinPrompt => '비밀번호를 입력해주세요';

  @override
  String get juiceLockTitle => '주스가 잠겨있어요';

  @override
  String get pinConfirmMismatchError => '비밀번호가 일치하지 않아요. 다시 입력해주세요';

  @override
  String get pinMismatchError => '비밀번호가 일치하지 않아요';

  @override
  String get shareCardText => '나의 주스 절약 카드';

  @override
  String get unlockJuiceReason => '주스 잠금을 해제하려면 인증해주세요';

  @override
  String get unlockWithBiometrics => '생체인증으로 잠금 해제';

  @override
  String yearsPresetLabel(Object years) {
    return '$years년';
  }

  @override
  String get settingsLanguage => '언어 설정';

  @override
  String get settingsCurrency => '기준 통화 단위 설정';

  @override
  String get currencySelectTitle => '통화 단위를 선택해주세요';

  @override
  String get commonDone => '완료';

  @override
  String get currencyNameKrw => '대한민국 원 (₩)';

  @override
  String get currencyNameUsd => '미국 달러 (\$)';

  @override
  String get currencyNameJpy => '일본 엔 (¥)';

  @override
  String get currencyNameEur => '유로 (€)';

  @override
  String get currencyNameVnd => '베트남 동 (₫)';

  @override
  String get currencyNameTwd => '신대만 달러 (NT\$)';

  @override
  String get currencyNameCny => '중국 위안 (¥)';

  @override
  String get currencyNameBrl => '브라질 헤알 (R\$)';

  @override
  String get foreignCurrencyPickerTitle => '결제 통화 선택';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted (당일 환율: $rate)';
  }

  @override
  String get exchangeRateLoadingMessage => '환율 조회 중...';

  @override
  String get exchangeRateFailedMessage => '환율을 불러오지 못했어요. 직접 입력하거나 마지막 환율을 사용해주세요';

  @override
  String get manualRateEntryToggle => '환율 직접 입력';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => '다시 시도';

  @override
  String get commonCopy => '복사';

  @override
  String linkOpenFailedMessage(Object target) {
    return '열어 줄 앱을 찾지 못했어요: $target';
  }

  @override
  String get commonConfirm => '확인';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return '기준 통화를 $toCode로 변경하시겠습니까? 기존에 기록된 모든 금액이 현재 환율 기준으로 자동 환산됩니다.';
  }

  @override
  String get currencyMigrationLoadingMessage => '기존 가계부 데이터를 새 통화에 맞게 환산하고 있어요... 🍊';

  @override
  String get currencyMigrationFailedMessage => '환율을 가져오지 못해 기존 금액은 이전 그대로 유지돼요';

  @override
  String get category_food_name => '식비';

  @override
  String get category_food_desc => '오늘 마신 맛있는 에너지 🍱';

  @override
  String get category_cafe_name => '카페/간식';

  @override
  String get category_cafe_desc => '기분 좋아지는 디저트 한 스푼 ☕️';

  @override
  String get category_transport_name => '교통';

  @override
  String get category_transport_desc => '목적지까지 부드러운 이동 🚌';

  @override
  String get category_shopping_name => '쇼핑';

  @override
  String get category_shopping_desc => '나를 채우는 득템의 즐거움 🛍️';

  @override
  String get category_culture_name => '문화/여가';

  @override
  String get category_culture_desc => '영혼을 채우는 달콤한 휴식 🎬';

  @override
  String get category_life_name => '생활';

  @override
  String get category_life_desc => '쾌적한 일상을 위한 한 모금 🧼';

  @override
  String get category_etc_name => '기타';

  @override
  String get category_etc_desc => '어디에나 어울리는 다채로운 소비 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return '지켜낸 주스 +$amount mL';
  }

  @override
  String get savingHistoryTitle => '절약 기록';

  @override
  String get savingHistoryEmpty => '아직 마감된 주기가 없어요.\n첫 주기를 채워보세요!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '+$amount mL 절약 성공!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return '초과 소비 $amount mL';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return '목표 $target / 소비 $spent';
  }

  @override
  String get savingOptionTitle => '남긴 주스 처리 방식';

  @override
  String get savingOptionDescription => '주기가 끝났을 때 남은 목표량을 어떻게 쓸지 골라주세요.';

  @override
  String get savingOptionRollover => '다음 주기로 이월';

  @override
  String get savingOptionSavings => '비상금/저축 자산으로 적립';

  @override
  String get savedJuiceStoreTooltip => '지켜낸 주스 보관함';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return '지켜낸 주스: $amount mL ($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return '지난 주기 이월 +$amount mL 포함';
  }

  @override
  String get savingsAssetCardTitle => '절약으로 지켜낸 자산';

  @override
  String get savingsAssetCardDescription => '저축 옵션으로 마감된 주기들의 남은 주스 누적 합계예요.';

  @override
  String get savingPraise_1 => '벌써 이만큼 더 저축했어요! 대단해요!! 목표에 한 걸음 더 가까워지고 있어요 🍊';

  @override
  String get savingPraise_2 => '소중한 주스를 신선하게 지켜냈어요! 당신의 절약 습관이 빛나고 있어요 ✨';

  @override
  String get savingPraise_3 => '차곡차곡 모인 주스가 든든한 자산이 되고 있어요! 오늘 하루도 파이팅 🧃';

  @override
  String get savingPraise_4 => '절약도 하나의 멋진 습관! 주스 잔고가 차오를수록 여유도 함께 차올라요 달콤한 성과네요 🍯';

  @override
  String get savingPraise_5 => '흔들리지 않고 목표를 방어해 낸 멋진 당신! 다음 주스도 상쾌하게 지켜봐요 🍏';

  @override
  String get savingsLabel => '저축';

  @override
  String get savingsCategoryTab => '저축 카테고리';

  @override
  String get category_savings_bank_name => '저축';

  @override
  String get category_savings_bank_desc => '차곡차곡 쌓이는 목돈 🏦';

  @override
  String get category_savings_invest_name => '투자/주식';

  @override
  String get category_savings_invest_desc => '내일을 위해 심는 과일 씨앗 📈';

  @override
  String get category_savings_housing_name => '주택청약저축';

  @override
  String get category_savings_housing_desc => '달콤한 내 집 마련의 꿈 🏠';

  @override
  String get category_savings_isa_name => 'ISA/절세계좌';

  @override
  String get category_savings_isa_desc => '든든한 만능 절세 주머니 🛡️';

  @override
  String get category_savings_emergency_name => '비상금';

  @override
  String get category_savings_emergency_desc => '언제든 기댈 수 있는 완충재 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return '\'$category\' 저축 $amount mL를 기록했어요! 🌱';
  }

  @override
  String get statsTotalIncomeTitle => '총 수입';

  @override
  String get statsTotalSavingsTitle => '총 저축';

  @override
  String get incomeCategoryTitleStats => '카테고리별 수입';

  @override
  String get savingsCategoryTitleStats => '카테고리별 저축';

  @override
  String get savingsOverviewSectionTitle => '🌱 저축 · 투자 현황';

  @override
  String get savingsThisMonthTotalLabel => '이번 달 총 저축 · 투자';

  @override
  String get savingsOverviewEmptyMessage => '아직 기록된 저축/투자 내역이 없어요';

  @override
  String get scopeThisMonth => '이번 달';

  @override
  String get calendarSettingsTitle => '캘린더 설정';

  @override
  String get calendarStartDayLabel => '달력 시작 요일';

  @override
  String get calendarStartMon => '월요일 시작';

  @override
  String get calendarStartSun => '일요일 시작';

  @override
  String get calendarAmountMode => '금액 표시 방식';

  @override
  String get calendarCompactAmount => '축약형 (5.6만)';

  @override
  String get calendarFullAmount => '전체 금액 (56,000)';

  @override
  String get calendarShowNoSpendStamp => '무지출 스탬프 표시';

  @override
  String get calendarHighlightWeekend => '주말 색상 강조';

  @override
  String get savingsAllTimeTotalLabel => '전체 누적 저축 · 투자';

  @override
  String get currencyWarningNotice => '실시간 환율을 반영하여 계산되므로 기존 데이터의 금액에 미세한 차이가 생길 수 있어요. 꼭 필요한 경우에만 변경해 주세요!';

  @override
  String get onboardingStep1Title => '마음 편히 마실 생활비 예산을 정해볼까요?';

  @override
  String get onboardingBudgetLabelDaily => '하루 예산';

  @override
  String get onboardingBudgetLabelWeekly => '이번 주 예산';

  @override
  String get onboardingBudgetLabelMonthly => '한 달 예산';

  @override
  String get onboardingStep1NextButton => '다음: 장기 목표 정하기 (1/2)';

  @override
  String get onboardingFooterHint => '설정에서 언제든지 자유롭게 변경할 수 있어요!';

  @override
  String get onboardingStep2Title => 'n년 후를 위한 나만의 저축 목표가 있나요?';

  @override
  String get onboardingStep2Subtitle => '목표를 정하면 매달 모아야 할 저축액과 가용 주스를 똑똑하게 계산해 드려요.';

  @override
  String get onboardingDurationLabel => '목표 기간';

  @override
  String get onboardingGoalAmountLabel => '목표 금액';

  @override
  String get onboardingCompleteButton => '목표 설정 완료하고 시작하기';

  @override
  String get onboardingSkipButton => '지금은 건너뛸래요';

  @override
  String get commonBack => '뒤로';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return '주스(mL)는 내가 쓸 수 있는 돈이에요! (1$symbol = 1 mL)';
  }

  @override
  String get customDuration => '직접 설정';

  @override
  String get yearUnit => '년';

  @override
  String get monthUnit => '개월';

  @override
  String totalDurationLabel(Object months) {
    return '총 $months개월 동안';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return '$months개월 동안 매달 약 $amount씩 모으면 달성할 수 있어요! 🌱';
  }

  @override
  String get onboardingChooseGoalType => '어떤 목표부터 시작해 볼까요?';

  @override
  String get onboardingShortTermTitle => '가벼운 단기 생활비 예산';

  @override
  String get onboardingShortTermDesc => '오늘, 이번 주, 이번 달 동안 마실 주스 용량을 정하고 가볍게 지출을 관리해요.';

  @override
  String get onboardingLongTermTitle => '든든한 중·장기 저축 목표';

  @override
  String get onboardingLongTermDesc => 'N년 후 이루고 싶은 목돈 목표를 정하고 스마트하게 모아가요.';

  @override
  String get startWithJuice => '주스 채우고 시작하기';

  @override
  String get startWithLongPlan => '플랜 저장하고 시작하기';

  @override
  String get category_income_salary_name => '월급';

  @override
  String get category_income_salary_desc => '달콤한 피와 땀의 결실 💼';

  @override
  String get category_income_side_name => '부수입/알바';

  @override
  String get category_income_side_desc => '쏠쏠하게 차오르는 보너스 꿀 🍯';

  @override
  String get category_income_allowance_name => '용돈';

  @override
  String get category_income_allowance_desc => '기분 좋은 서프라이즈 선물 🎁';

  @override
  String get category_income_finance_name => '금융소득(이자/배당)';

  @override
  String get category_income_finance_desc => '돈이 돈을 벌어온 열매 📈';

  @override
  String get category_income_etc_name => '기타 수입';

  @override
  String get category_income_etc_desc => '기타 다채로운 수입 💧';

  @override
  String get notifEveningMon1Title => '🍊 월요일 고생 많았어요';

  @override
  String get notifEveningMon1Body => '월요병 이겨낸 오늘, 영수증 3초 정리로 가볍게 마무리해요. 한 주의 첫 기록이 가장 달콤해요.';

  @override
  String get notifEveningMon2Title => '📒 월요일 가계부 정리 타임';

  @override
  String get notifEveningMon2Body => '한 주의 시작이 가장 중요해요. 오늘 쓴 돈만 톡 기록하면 이번 주 주스 관리는 벌써 절반 성공!';

  @override
  String get notifEveningMon3Title => '🧃 월요병 퇴치 완료!';

  @override
  String get notifEveningMon3Body => '오늘도 해냈다니 대단해요. 퇴근길 지출 기록하고 따뜻한 저녁 보내세요.';

  @override
  String get notifEveningMon4Title => '☕️ 월요일 커피값, 기록했나요?';

  @override
  String get notifEveningMon4Body => '월요일엔 커피가 평소보다 한 잔 더 들어가죠. 오늘 나간 소소한 지출도 빠짐없이 담아봐요.';

  @override
  String get notifEveningMon5Title => '🌙 한 주의 첫날, 컵은 안녕한가요?';

  @override
  String get notifEveningMon5Body => '이번 주 주스는 아직 넉넉해요. 쓴 만큼만 기록하면 남은 6일이 한결 여유로워져요.';

  @override
  String get notifEveningTue1Title => '🍊 화요일 주스 점검';

  @override
  String get notifEveningTue1Body => '월요일의 기세, 화요일에도 이어가요! 오늘 쓴 돈을 기록하면 이번 주 흐름이 한눈에 보여요.';

  @override
  String get notifEveningTue2Title => '🧾 영수증이 쌓이기 전에!';

  @override
  String get notifEveningTue2Body => '쌓인 영수증은 기록하기 더 귀찮아져요. 오늘 것만 딱 1분 투자해서 털어버려요.';

  @override
  String get notifEveningTue3Title => '🥤 오늘 점심값 기록했나요?';

  @override
  String get notifEveningTue3Body => '점심, 커피, 간식… 소소해서 더 잊기 쉬워요. 자기 전에 한꺼번에 톡 기록해 볼까요?';

  @override
  String get notifEveningTue4Title => '🌿 소소한 습관이 주스를 지켜요';

  @override
  String get notifEveningTue4Body => '화요일 밤의 1분 기록이 이번 달 통장을 지켜줘요. 오늘도 잘하고 있어요!';

  @override
  String get notifEveningTue5Title => '🎯 오늘 목표 달성했나요?';

  @override
  String get notifEveningTue5Body => '오늘 쓸 주스를 넘기지 않았다면 칭찬받을 일! 결과가 궁금하다면 지금 앱을 열어보세요.';

  @override
  String get notifEveningWed1Title => '⛰ 한 주의 정상, 수요일!';

  @override
  String get notifEveningWed1Body => '일주일의 딱 절반이에요. 남은 주스가 충분한지 확인하고, 나머지 반을 계획해 봐요.';

  @override
  String get notifEveningWed2Title => '📊 주스 수위 중간 점검';

  @override
  String get notifEveningWed2Body => '수요일 밤은 중간 점검의 시간! 오늘 지출을 기록하고 이번 주 페이스를 확인해 보세요.';

  @override
  String get notifEveningWed3Title => '🍹 주중 반환점을 돌았어요';

  @override
  String get notifEveningWed3Body => '여기까지 오느라 고생했어요. 오늘 쓴 돈만 기록하고 편하게 쉬세요.';

  @override
  String get notifEveningWed4Title => '🐪 낙타처럼 버텨봐요';

  @override
  String get notifEveningWed4Body => '목요일, 금요일이 오기 전에 컵을 점검해 둬요. 지금 기록하면 주말이 훨씬 든든해져요.';

  @override
  String get notifEveningWed5Title => '🧮 절반 왔는데 주스는 얼마나 남았지?';

  @override
  String get notifEveningWed5Body => '기록만 해두면 계산은 앱이 해줄게요. 오늘 지출을 톡 입력해 보세요.';

  @override
  String get notifEveningThu1Title => '🌆 내일이 금요일이에요!';

  @override
  String get notifEveningThu1Body => '불금 전에 오늘 지출부터 정리해요. 주스 남은 양을 알면 내일이 더 즐거워져요.';

  @override
  String get notifEveningThu2Title => '🛡 금요일 대비 방어막 켜기';

  @override
  String get notifEveningThu2Body => '내일 약속이 있다면 오늘 아낀 주스가 큰 힘이 돼요. 오늘 지출 기록하고 든든하게 준비!';

  @override
  String get notifEveningThu3Title => '🍋 목요일, 지갑이 슬슬 근질근질';

  @override
  String get notifEveningThu3Body => '주말이 다가오면 지갑이 먼저 들떠요. 오늘의 소비를 기록하며 한 번 더 진정시켜 봐요.';

  @override
  String get notifEveningThu4Title => '📝 한 주 거의 다 왔어요';

  @override
  String get notifEveningThu4Body => '조금만 더 버티면 주말이에요! 목요일 기록 한 줄이 이번 주 목표를 지켜줘요.';

  @override
  String get notifEveningThu5Title => '🌙 오늘도 컵 점검 완료?';

  @override
  String get notifEveningThu5Body => '남은 주스를 알고 맞는 금요일과 모르고 맞는 금요일은 달라요. 지금 확인해 보세요.';

  @override
  String get notifEveningFri1Title => '🍻 불금 방어전 시작!';

  @override
  String get notifEveningFri1Body => '오늘 밤 지갑 사수 작전! 먹고 마시는 건 즐기되, 결제할 때마다 기록은 꼭 남겨요.';

  @override
  String get notifEveningFri2Title => '🔒 지갑 사수 모드 ON';

  @override
  String get notifEveningFri2Body => '불금의 유혹이 몰려와요. 한 번만 참고, 오늘 기록부터 확인한 뒤에 즐겨요!';

  @override
  String get notifEveningFri3Title => '🍕 배달앱 열기 전에 잠깐!';

  @override
  String get notifEveningFri3Body => '주스 수위부터 확인하고 주문해요. 남은 주스가 넉넉하다면 마음껏, 아니면 반만!';

  @override
  String get notifEveningFri4Title => '🎉 한 주 고생했어요, 불금이에요';

  @override
  String get notifEveningFri4Body => '즐기는 건 좋지만 과소비는 NO! 오늘 쓴 만큼만 기록하면 월요일에 웃을 수 있어요.';

  @override
  String get notifEveningFri5Title => '🧃 금요일 밤, 컵이 쏟아지지 않게!';

  @override
  String get notifEveningFri5Body => '신나는 금요일일수록 주스가 줄줄 새기 쉬워요. 오늘 지출을 챙겨 담아 둬요.';

  @override
  String get notifEveningSat1Title => '🛍 토요일 외출 지출 기록!';

  @override
  String get notifEveningSat1Body => '친구 만나고, 쇼핑하고, 맛집 가고… 오늘 쓴 돈 잊기 전에 한꺼번에 기록해 두세요.';

  @override
  String get notifEveningSat2Title => '🌇 즐거운 주말 보내고 있나요?';

  @override
  String get notifEveningSat2Body => '행복한 소비는 좋은 소비예요. 다만 기록은 잊지 말기! 내일 후회가 줄어들어요.';

  @override
  String get notifEveningSat3Title => '🍰 오늘의 달콤한 지출, 기록 완료?';

  @override
  String get notifEveningSat3Body => '소소한 사치도 기록하면 죄책감이 사라져요. 지금 한 줄만 남겨볼까요?';

  @override
  String get notifEveningSat4Title => '🧺 주말 지출 정산 타임';

  @override
  String get notifEveningSat4Body => '하루 종일 놀았다면 영수증도 한가득이겠죠? 잠들기 전 톡톡 정리해 봐요.';

  @override
  String get notifEveningSat5Title => '🌙 토요일 밤, 주스 점검';

  @override
  String get notifEveningSat5Body => '내일 하루만 지나면 주스가 리셋돼요. 오늘 소비를 기록하고 마무리를 깔끔하게 해요.';

  @override
  String get notifEveningSun1Title => '🧺 일요일 저녁, 한 주 마무리';

  @override
  String get notifEveningSun1Body => '이번 주 마지막 기록을 남겨요. 한 주를 돌아보면 다음 주가 훨씬 가벼워져요.';

  @override
  String get notifEveningSun2Title => '🔄 내일이면 주스가 리셋돼요';

  @override
  String get notifEveningSun2Body => '오늘 지출까지 기록하면 이번 주 성적표 완성! 새 주스를 맞이할 준비를 해요.';

  @override
  String get notifEveningSun3Title => '🍽 일요일 저녁 배달의 유혹';

  @override
  String get notifEveningSun3Body => '마지막 하루만 잘 넘기면 이번 주 목표 달성이에요! 주문 전에 주스 수위 확인!';

  @override
  String get notifEveningSun4Title => '🏆 이번 주도 수고했어요';

  @override
  String get notifEveningSun4Body => '기록을 끝까지 이어온 당신, 정말 대단해요. 오늘 지출만 마저 적고 푹 쉬세요.';

  @override
  String get notifEveningSun5Title => '🌌 새로운 한 주를 위한 마지막 점검';

  @override
  String get notifEveningSun5Body => '내일부터 다시 가득 찬 컵이에요. 오늘의 기록으로 이번 주를 깔끔하게 닫아요.';

  @override
  String get notifMondayTitle => '🍊 새로운 주스가 가득 채워졌어요!';

  @override
  String get notifMondayBody => '지난주도 잘 버텨냈어요. 찰랑거리는 이번 주 예산과 함께 상큼하게 한 주를 시작해 볼까요? ✨';

  @override
  String get notifWeekday1Title => '🌅 오늘의 한 줄 확언';

  @override
  String get notifWeekday1Body => '나는 오늘도 내 주스를 똑똑하게 쓰는 사람이에요. 작게 아끼고 크게 웃는 하루 되세요!';

  @override
  String get notifWeekday2Title => '🔮 오늘의 주스 운세';

  @override
  String get notifWeekday2Body => '오늘은 작은 선택 하나가 큰 달콤함이 되는 날! 충동구매 앞에서 딱 3초만 멈추면 행운이 따라와요 🍀';

  @override
  String get notifWeekday3Title => '📖 오늘의 한 줄 명언';

  @override
  String get notifWeekday3Body => '“작은 물방울이 모여 바다를 이룬다.” 오늘 아낀 몇 mL가 언젠가 큰 목표가 돼요.';

  @override
  String get notifWeekday4Title => '☀️ 좋은 아침, 오늘도 상쾌하게!';

  @override
  String get notifWeekday4Body => '오늘 하루도 당신이 원하는 모양으로 채워질 거예요. 한 모금 한 모금 여유롭게 시작해요.';

  @override
  String get notifWeekday5Title => '🍀 오늘의 행운 포인트';

  @override
  String get notifWeekday5Body => '오늘의 행운은 ‘기록하기’! 쓴 만큼 적으면 마음도 지갑도 가벼워지는 하루가 될 거예요.';

  @override
  String get notifWeekday6Title => '🌱 오늘의 마음가짐';

  @override
  String get notifWeekday6Body => '완벽하지 않아도 괜찮아요. 어제보다 조금만 더 알뜰하면 그걸로 충분히 잘하고 있는 거예요.';

  @override
  String get notifWeekday7Title => '🌈 오늘의 응원 한 스푼';

  @override
  String get notifWeekday7Body => '당신은 생각보다 훨씬 잘하고 있어요. 오늘도 나를 위한 현명한 선택, 응원할게요!';

  @override
  String get notifWeekday8Title => '✨ 오늘의 운세: 대길';

  @override
  String get notifWeekday8Body => '오늘은 지갑이 든든해지는 기운이 가득해요. 필요한 곳엔 아낌없이, 아닌 곳엔 단호하게!';

  @override
  String get notifSunday1Title => '🌤 일요일의 한 줄 확언';

  @override
  String get notifSunday1Body => '나는 한 주를 잘 살아냈고, 새로운 한 주도 잘 해낼 거예요. 편안하게 쉬어가는 일요일 되세요.';

  @override
  String get notifSunday2Title => '📖 일요일의 명언';

  @override
  String get notifSunday2Body => '“멈춰서 돌아보는 시간이 가장 멀리 가게 한다.” 오늘은 이번 주 주스를 가만히 돌아보는 날이에요.';

  @override
  String get notifSunday3Title => '🔮 일요일 운세: 재충전';

  @override
  String get notifSunday3Body => '내일을 위해 충전하기 좋은 날! 무리한 지출 대신 여유로운 휴식이 행운을 불러와요 🍀';

  @override
  String get notifComeback1Title => '🍊 오렌지가 서운해서 껍질을 까기 시작했어요.';

  @override
  String get notifComeback1Body => '이틀 동안 안 오다니… 혹시 몰래 돈 펑펑 쓰고 주스 앱 눈치 보여서 못 켜는 거 아니죠? 지금 들어와서 자백하세요.';

  @override
  String get notifComeback2Title => '🧃 주스 통 바닥에 곰팡이가 피어오르는 중…';

  @override
  String get notifComeback2Body => '기록 안 한 3일 치 영수증이 당신의 통장을 갉아먹고 있어요. 제발 저를 켜서 썩은 지출을 도려내 주세요! 😱';

  @override
  String get notifComeback3Title => '🍋 [긴급] 통장 잔고가 줄줄 새고 있습니다.';

  @override
  String get notifComeback3Body => '앱 안 켠다고 쓴 돈이 사라질 것 같죠? 안 쓴 척해도 영수증은 다 알아요. 오늘 안 오면 주스 컵 확 엎어버립니다? 💥';

  @override
  String get notifComeback4Title => '🫗 …제가 무슨 잘못이라도 했나요?';

  @override
  String get notifComeback4Body => '일주일째 주스를 굶기고 계시네요. 텅 빈 컵에 먼지만 쌓여가요. 당신의 저축 목표도 먼지처럼 날아가는 중… 흑흑.';

  @override
  String get notifComeback5Title => '💀 축하합니다! 주스가 완전히 증발했습니다.';

  @override
  String get notifComeback5Body => '2주 동안 안 온 걸 보니 이미 거지가 되셨군요. 마지막 남은 양심 한 방울이라도 건지러 지금 당장 들어오시죠? 🏃‍♂️💨';

  @override
  String get notifChannelName => '주스 알림';

  @override
  String get notifChannelDescription => '아침/저녁 지출 기록 리마인더 및 응원 메시지';
}
