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
    return '목표: $duration 동안 $amount원 모으기';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return '숨만 쉬어도 나가는 돈(고정비): 월 $amount원';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return '추천 주스 한 잔: 하루 $daily mL / 이번 주 $weekly mL / 이번 달 $monthly mL';
  }

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
  String get setTargetAmountFirst => '목표 금액을 먼저 설정해주세요';

  @override
  String get menuGoalSettingsTitle => '목표 설정';

  @override
  String get menuGoalSettingsSubtitle => '장기 저축 목표, 목표 주기, 주기별 목표 금액';

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
  String get appNameShort => '주스';

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
  String get defaultCardUndeletable => '기본 카드는 삭제할 수 없어요';

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
  String get incomeStepQuestion => '매달 들어오는 주스(월 수입)는\n얼마인가요?';

  @override
  String get incomeStepSubtitle => '세후 실제 통장에 찍히는 금액을 적어주세요.';

  @override
  String get wonSuffixSpaced => ' 원';

  @override
  String get goalStepQuestion => '얼마 동안, 얼마를\n모으고 싶나요?';

  @override
  String get yearsFieldLabel => '년';

  @override
  String get monthsFieldLabel => '개월';

  @override
  String get goalAmountFieldLabel => '목표 모을 금액';

  @override
  String get wonUnit => '원';

  @override
  String get fixedExpenseStepQuestion => '매달 고정으로\n빠져나가는 돈이 있나요?';

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
    return '월 수입 $income원 - 고정비 $fixed원 - 월 저축액을 빼면,';
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
  String get calendarAmountModeCompact => '축약형';

  @override
  String get calendarAmountModeFull => '확장형';

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
}
