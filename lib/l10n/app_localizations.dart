import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('vi')
  ];

  /// 앱 이름
  ///
  /// In ko, this message translates to:
  /// **'주스 가계부'**
  String get appTitle;

  /// 언어 선택 온보딩 화면 제목
  ///
  /// In ko, this message translates to:
  /// **'언어를 선택해 주세요'**
  String get selectLanguage;

  /// 최초 목표 예산 설정 화면 제목
  ///
  /// In ko, this message translates to:
  /// **'목표 주스를 채워볼까요?'**
  String get setBudgetTitle;

  /// 주간 목표 잔여량 라벨
  ///
  /// In ko, this message translates to:
  /// **'이번 주 남은 주스'**
  String get weeklyBudget;

  /// No description provided for @paymentCheckCard.
  ///
  /// In ko, this message translates to:
  /// **'체크카드'**
  String get paymentCheckCard;

  /// No description provided for @paymentCreditCard.
  ///
  /// In ko, this message translates to:
  /// **'신용카드'**
  String get paymentCreditCard;

  /// No description provided for @paymentCash.
  ///
  /// In ko, this message translates to:
  /// **'현금·이체'**
  String get paymentCash;

  /// No description provided for @paymentSplitBill.
  ///
  /// In ko, this message translates to:
  /// **'더치페이'**
  String get paymentSplitBill;

  /// No description provided for @commonCancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In ko, this message translates to:
  /// **'저장'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In ko, this message translates to:
  /// **'수정'**
  String get commonEdit;

  /// No description provided for @commonAdd.
  ///
  /// In ko, this message translates to:
  /// **'추가'**
  String get commonAdd;

  /// No description provided for @commonNext.
  ///
  /// In ko, this message translates to:
  /// **'다음'**
  String get commonNext;

  /// No description provided for @goalSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'목표 설정'**
  String get goalSettingsTitle;

  /// No description provided for @activePeriodSectionTitle.
  ///
  /// In ko, this message translates to:
  /// **'활성 목표 주기'**
  String get activePeriodSectionTitle;

  /// No description provided for @activePeriodSectionDescription.
  ///
  /// In ko, this message translates to:
  /// **'홈 화면 게이지가 기준으로 삼는 주기예요. 아래에서 각 주기의 목표 금액을 미리 채워두면 전환할 때 바로 반영돼요.'**
  String get activePeriodSectionDescription;

  /// No description provided for @weekStartDayTileTitle.
  ///
  /// In ko, this message translates to:
  /// **'주간 시작 요일'**
  String get weekStartDayTileTitle;

  /// No description provided for @periodTargetSectionTitle.
  ///
  /// In ko, this message translates to:
  /// **'주기별 목표 금액'**
  String get periodTargetSectionTitle;

  /// No description provided for @periodTargetSectionDescription.
  ///
  /// In ko, this message translates to:
  /// **'주기마다 목표 금액을 따로 저장해두고 필요할 때 골라 쓸 수 있어요.'**
  String get periodTargetSectionDescription;

  /// No description provided for @periodTargetAmountSuffix.
  ///
  /// In ko, this message translates to:
  /// **'목표 금액'**
  String get periodTargetAmountSuffix;

  /// No description provided for @installmentSectionTitle.
  ///
  /// In ko, this message translates to:
  /// **'신용카드 할부 반영 방식'**
  String get installmentSectionTitle;

  /// No description provided for @installmentSectionDescription.
  ///
  /// In ko, this message translates to:
  /// **'할부로 등록한 지출을 캘린더/주스 게이지에 언제, 어떻게 나눠 반영할지 골라주세요.'**
  String get installmentSectionDescription;

  /// No description provided for @recommendedSuffix.
  ///
  /// In ko, this message translates to:
  /// **'추천'**
  String get recommendedSuffix;

  /// No description provided for @savingsPlanSectionTitle.
  ///
  /// In ko, this message translates to:
  /// **'중/장기 저축 목표 플래너'**
  String get savingsPlanSectionTitle;

  /// No description provided for @savingsPlanSectionDescription.
  ///
  /// In ko, this message translates to:
  /// **'월 수입과 고정지출, 저축 목표를 입력하면 변동지출로 쓸 수 있는 주스 용량을 계산해드려요.'**
  String get savingsPlanSectionDescription;

  /// No description provided for @savingsPlanToggleTitle.
  ///
  /// In ko, this message translates to:
  /// **'중/장기 저축 목표가 있으신가요?'**
  String get savingsPlanToggleTitle;

  /// No description provided for @autoBudgetSetMessage.
  ///
  /// In ko, this message translates to:
  /// **'일/주/월 목표 금액이 자동 설정됐어요 🍊'**
  String get autoBudgetSetMessage;

  /// No description provided for @savingsPlanSummaryTitle.
  ///
  /// In ko, this message translates to:
  /// **'🍊 나의 주스 플랜 요약'**
  String get savingsPlanSummaryTitle;

  /// No description provided for @replanButton.
  ///
  /// In ko, this message translates to:
  /// **'플랜 다시 짜기'**
  String get replanButton;

  /// No description provided for @applyBudgetButton.
  ///
  /// In ko, this message translates to:
  /// **'이 예산으로 주스 자동 세팅하기'**
  String get applyBudgetButton;

  /// No description provided for @durationYearsAndMonths.
  ///
  /// In ko, this message translates to:
  /// **'{years}년 {months}개월'**
  String durationYearsAndMonths(Object years, Object months);

  /// No description provided for @durationYearsOnly.
  ///
  /// In ko, this message translates to:
  /// **'{years}년'**
  String durationYearsOnly(Object years);

  /// No description provided for @durationMonthsOnly.
  ///
  /// In ko, this message translates to:
  /// **'{months}개월'**
  String durationMonthsOnly(Object months);

  /// No description provided for @savingsPlanGoalLine.
  ///
  /// In ko, this message translates to:
  /// **'목표: {duration} 동안 {amount}원 모으기'**
  String savingsPlanGoalLine(Object duration, Object amount);

  /// No description provided for @savingsPlanFixedExpenseLine.
  ///
  /// In ko, this message translates to:
  /// **'숨만 쉬어도 나가는 돈(고정비): 월 {amount}원'**
  String savingsPlanFixedExpenseLine(Object amount);

  /// No description provided for @savingsPlanRecommendedLine.
  ///
  /// In ko, this message translates to:
  /// **'추천 주스 한 잔: 하루 {daily} mL / 이번 주 {weekly} mL / 이번 달 {monthly} mL'**
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly);

  /// No description provided for @settingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settingsTitle;

  /// No description provided for @savingsCardSectionTitle.
  ///
  /// In ko, this message translates to:
  /// **'이번 주 절약 카드'**
  String get savingsCardSectionTitle;

  /// No description provided for @savingsCardSectionDescription.
  ///
  /// In ko, this message translates to:
  /// **'예산 방어에 성공한 한 주를 카드로 만들어 공유해보세요.'**
  String get savingsCardSectionDescription;

  /// No description provided for @generatingCard.
  ///
  /// In ko, this message translates to:
  /// **'카드 생성 중...'**
  String get generatingCard;

  /// No description provided for @shareCardButton.
  ///
  /// In ko, this message translates to:
  /// **'카드 공유하기'**
  String get shareCardButton;

  /// No description provided for @setTargetAmountFirst.
  ///
  /// In ko, this message translates to:
  /// **'목표 금액을 먼저 설정해주세요'**
  String get setTargetAmountFirst;

  /// No description provided for @menuGoalSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'목표 설정'**
  String get menuGoalSettingsTitle;

  /// No description provided for @menuGoalSettingsSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'장기 저축 목표, 목표 주기, 주기별 목표 금액'**
  String get menuGoalSettingsSubtitle;

  /// No description provided for @menuThemeSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'테마 설정'**
  String get menuThemeSettingsTitle;

  /// No description provided for @menuThemeSettingsSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'화면 모드 및 주스 테마'**
  String get menuThemeSettingsSubtitle;

  /// No description provided for @menuWidgetSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'위젯 설정'**
  String get menuWidgetSettingsTitle;

  /// No description provided for @menuWidgetSettingsSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'홈 화면 위젯 금액 가리기'**
  String get menuWidgetSettingsSubtitle;

  /// No description provided for @menuCardManagementTitle.
  ///
  /// In ko, this message translates to:
  /// **'내 카드 관리'**
  String get menuCardManagementTitle;

  /// No description provided for @menuCardManagementSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'보유 카드 등록, 순서 변경'**
  String get menuCardManagementSubtitle;

  /// No description provided for @menuNotificationSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'알림 설정'**
  String get menuNotificationSettingsTitle;

  /// No description provided for @menuNotificationSettingsSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'아침/저녁 리마인더 알림 켜기/끄기'**
  String get menuNotificationSettingsSubtitle;

  /// No description provided for @menuBackupSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'데이터 백업 및 복원'**
  String get menuBackupSettingsTitle;

  /// No description provided for @menuBackupSettingsSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'CSV 내보내기, 백업 파일 내보내기/불러오기'**
  String get menuBackupSettingsSubtitle;

  /// No description provided for @menuSecuritySettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'보안'**
  String get menuSecuritySettingsTitle;

  /// No description provided for @menuSecuritySettingsSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'PIN 번호, 생체인증'**
  String get menuSecuritySettingsSubtitle;

  /// No description provided for @appNameShort.
  ///
  /// In ko, this message translates to:
  /// **'주스'**
  String get appNameShort;

  /// No description provided for @savingsCardSuccessMessage.
  ///
  /// In ko, this message translates to:
  /// **'이번 주 주스를\n신선하게 지켜냈어요!'**
  String get savingsCardSuccessMessage;

  /// No description provided for @savingsCardOverMessage.
  ///
  /// In ko, this message translates to:
  /// **'이번 주 주스가\n조금 넘쳤어요'**
  String get savingsCardOverMessage;

  /// No description provided for @savingsCardSpentLine.
  ///
  /// In ko, this message translates to:
  /// **'{budget} 중 {spent} 소비'**
  String savingsCardSpentLine(Object budget, Object spent);

  /// No description provided for @savingsCardSuccessStamp.
  ///
  /// In ko, this message translates to:
  /// **'성공'**
  String get savingsCardSuccessStamp;

  /// No description provided for @savingsCardOverStamp.
  ///
  /// In ko, this message translates to:
  /// **'분발'**
  String get savingsCardOverStamp;

  /// No description provided for @pinSetupTitle.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 설정'**
  String get pinSetupTitle;

  /// No description provided for @biometricUnlockReason.
  ///
  /// In ko, this message translates to:
  /// **'잠금을 해제하려면 인증해주세요'**
  String get biometricUnlockReason;

  /// No description provided for @pinConfirmTitle.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 확인'**
  String get pinConfirmTitle;

  /// No description provided for @pinConfirmCurrentTitle.
  ///
  /// In ko, this message translates to:
  /// **'현재 비밀번호 확인'**
  String get pinConfirmCurrentTitle;

  /// No description provided for @pinSetupNewTitle.
  ///
  /// In ko, this message translates to:
  /// **'새 비밀번호 설정'**
  String get pinSetupNewTitle;

  /// No description provided for @pinChangedMessage.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호가 변경되었어요'**
  String get pinChangedMessage;

  /// No description provided for @biometricLinkTitle.
  ///
  /// In ko, this message translates to:
  /// **'생체인증 연동'**
  String get biometricLinkTitle;

  /// No description provided for @biometricLinkConfirm.
  ///
  /// In ko, this message translates to:
  /// **'생체인증을 연동하시겠습니까?'**
  String get biometricLinkConfirm;

  /// No description provided for @biometricLinkAction.
  ///
  /// In ko, this message translates to:
  /// **'연동'**
  String get biometricLinkAction;

  /// No description provided for @biometricLinkReason.
  ///
  /// In ko, this message translates to:
  /// **'생체인증을 연동하려면 인증해주세요'**
  String get biometricLinkReason;

  /// No description provided for @biometricUnavailableMessage.
  ///
  /// In ko, this message translates to:
  /// **'생체인증을 사용할 수 없어요'**
  String get biometricUnavailableMessage;

  /// No description provided for @securityTitle.
  ///
  /// In ko, this message translates to:
  /// **'보안'**
  String get securityTitle;

  /// No description provided for @securityDescription.
  ///
  /// In ko, this message translates to:
  /// **'PIN 번호와 생체인증으로 앱을 잠글 수 있어요.'**
  String get securityDescription;

  /// No description provided for @appLockTitle.
  ///
  /// In ko, this message translates to:
  /// **'앱 잠금'**
  String get appLockTitle;

  /// No description provided for @appLockDescription.
  ///
  /// In ko, this message translates to:
  /// **'PIN 4자리로 앱 진입을 보호해요.'**
  String get appLockDescription;

  /// No description provided for @changePasswordTitle.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호 변경'**
  String get changePasswordTitle;

  /// No description provided for @biometricUseTitle.
  ///
  /// In ko, this message translates to:
  /// **'생체인증 사용'**
  String get biometricUseTitle;

  /// No description provided for @biometricUseDescription.
  ///
  /// In ko, this message translates to:
  /// **'Face ID/지문으로 더 빠르게 잠금을 해제해요.'**
  String get biometricUseDescription;

  /// No description provided for @csvShareText.
  ///
  /// In ko, this message translates to:
  /// **'주스 지출 내역'**
  String get csvShareText;

  /// No description provided for @backupShareText.
  ///
  /// In ko, this message translates to:
  /// **'주스 데이터 백업'**
  String get backupShareText;

  /// No description provided for @backupFailedMessage.
  ///
  /// In ko, this message translates to:
  /// **'백업에 실패했어요: {error}'**
  String backupFailedMessage(Object error);

  /// No description provided for @restoreDataTitle.
  ///
  /// In ko, this message translates to:
  /// **'데이터 복원'**
  String get restoreDataTitle;

  /// No description provided for @restoreDataConfirm.
  ///
  /// In ko, this message translates to:
  /// **'기존 데이터가 백업 파일 내용으로 대체됩니다. 계속할까요?'**
  String get restoreDataConfirm;

  /// No description provided for @restoreAction.
  ///
  /// In ko, this message translates to:
  /// **'복원'**
  String get restoreAction;

  /// No description provided for @restoreSuccessMessage.
  ///
  /// In ko, this message translates to:
  /// **'복원이 완료됐어요'**
  String get restoreSuccessMessage;

  /// No description provided for @restoreFailedMessage.
  ///
  /// In ko, this message translates to:
  /// **'복원에 실패했어요. 올바른 주스 백업 파일인지 확인해주세요'**
  String get restoreFailedMessage;

  /// No description provided for @backupSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'데이터 백업 및 복원'**
  String get backupSettingsTitle;

  /// No description provided for @exportExpensesTitle.
  ///
  /// In ko, this message translates to:
  /// **'지출 내역 내보내기'**
  String get exportExpensesTitle;

  /// No description provided for @exportExpensesDescription.
  ///
  /// In ko, this message translates to:
  /// **'날짜, 카테고리, 금액, 고정지출 여부, 메모가 담긴 CSV 파일을 공유해요.'**
  String get exportExpensesDescription;

  /// No description provided for @exportingCsv.
  ///
  /// In ko, this message translates to:
  /// **'내보내는 중...'**
  String get exportingCsv;

  /// No description provided for @exportCsvButton.
  ///
  /// In ko, this message translates to:
  /// **'CSV로 내보내기'**
  String get exportCsvButton;

  /// No description provided for @backupRestoreTitle.
  ///
  /// In ko, this message translates to:
  /// **'데이터 백업 · 복원'**
  String get backupRestoreTitle;

  /// No description provided for @backupRestoreDescription.
  ///
  /// In ko, this message translates to:
  /// **'지출/수입 내역, 카테고리, 예산 설정을 파일 하나로 백업하고 복원할 수 있어요.'**
  String get backupRestoreDescription;

  /// No description provided for @backupDataTitle.
  ///
  /// In ko, this message translates to:
  /// **'데이터 백업하기'**
  String get backupDataTitle;

  /// No description provided for @backupDataDescription.
  ///
  /// In ko, this message translates to:
  /// **'공유창을 통해 파일 앱, 이메일 등으로 저장해요.'**
  String get backupDataDescription;

  /// No description provided for @restoreDataTileTitle.
  ///
  /// In ko, this message translates to:
  /// **'데이터 복원하기'**
  String get restoreDataTileTitle;

  /// No description provided for @restoreDataTileDescription.
  ///
  /// In ko, this message translates to:
  /// **'백업 파일을 선택해 기존 데이터를 덮어써요.'**
  String get restoreDataTileDescription;

  /// No description provided for @categoryDefaultDescription.
  ///
  /// In ko, this message translates to:
  /// **'나만의 특별한 주스 레시피'**
  String get categoryDefaultDescription;

  /// No description provided for @categoryDeleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 삭제'**
  String get categoryDeleteTitle;

  /// No description provided for @categoryDeleteConfirm.
  ///
  /// In ko, this message translates to:
  /// **'\'{name}\' 카테고리를 삭제할까요?\n이미 기록된 지출 내역은 유지돼요.'**
  String categoryDeleteConfirm(Object name);

  /// No description provided for @categoryInUseMessage.
  ///
  /// In ko, this message translates to:
  /// **'이 카테고리를 사용 중인 수입 내역이 있어요. 먼저 다른 카테고리로 옮긴 뒤 삭제해주세요'**
  String get categoryInUseMessage;

  /// No description provided for @categoryEditTitle.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 수정'**
  String get categoryEditTitle;

  /// No description provided for @categoryAddTitle.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 추가'**
  String get categoryAddTitle;

  /// No description provided for @categoryNameLabel.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 이름'**
  String get categoryNameLabel;

  /// No description provided for @categoryDescriptionLabel.
  ///
  /// In ko, this message translates to:
  /// **'한 줄 설명'**
  String get categoryDescriptionLabel;

  /// No description provided for @colorLabel.
  ///
  /// In ko, this message translates to:
  /// **'색상'**
  String get colorLabel;

  /// No description provided for @iconLabel.
  ///
  /// In ko, this message translates to:
  /// **'아이콘'**
  String get iconLabel;

  /// No description provided for @categoryManageTitle.
  ///
  /// In ko, this message translates to:
  /// **'카테고리 관리'**
  String get categoryManageTitle;

  /// No description provided for @expenseCategoryTab.
  ///
  /// In ko, this message translates to:
  /// **'지출 카테고리'**
  String get expenseCategoryTab;

  /// No description provided for @incomeCategoryTab.
  ///
  /// In ko, this message translates to:
  /// **'수입 카테고리'**
  String get incomeCategoryTab;

  /// No description provided for @defaultCategoryUndeletable.
  ///
  /// In ko, this message translates to:
  /// **'기본 카테고리는 삭제할 수 없어요'**
  String get defaultCategoryUndeletable;

  /// No description provided for @cardDeleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'카드 삭제'**
  String get cardDeleteTitle;

  /// No description provided for @cardDeleteConfirm.
  ///
  /// In ko, this message translates to:
  /// **'\'{name}\' 카드를 삭제할까요?\n이미 기록된 지출 내역은 유지돼요.'**
  String cardDeleteConfirm(Object name);

  /// No description provided for @cardEditTitle.
  ///
  /// In ko, this message translates to:
  /// **'카드 수정'**
  String get cardEditTitle;

  /// No description provided for @cardAddTitle.
  ///
  /// In ko, this message translates to:
  /// **'카드 추가'**
  String get cardAddTitle;

  /// No description provided for @cardNameLabel.
  ///
  /// In ko, this message translates to:
  /// **'카드 이름'**
  String get cardNameLabel;

  /// No description provided for @cardTypeLabel.
  ///
  /// In ko, this message translates to:
  /// **'카드 종류'**
  String get cardTypeLabel;

  /// No description provided for @cardManagementTitle.
  ///
  /// In ko, this message translates to:
  /// **'내 카드 관리'**
  String get cardManagementTitle;

  /// No description provided for @defaultCardUndeletable.
  ///
  /// In ko, this message translates to:
  /// **'기본 카드는 삭제할 수 없어요'**
  String get defaultCardUndeletable;

  /// No description provided for @cardTypeCorporate.
  ///
  /// In ko, this message translates to:
  /// **'법인/업무용'**
  String get cardTypeCorporate;

  /// No description provided for @cardTypeCorporateExcluded.
  ///
  /// In ko, this message translates to:
  /// **'법인(경비) · 주스 제외'**
  String get cardTypeCorporateExcluded;

  /// No description provided for @juiceThemeLabel.
  ///
  /// In ko, this message translates to:
  /// **'주스 테마'**
  String get juiceThemeLabel;

  /// No description provided for @themeSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'테마 설정'**
  String get themeSettingsTitle;

  /// No description provided for @screenModeLabel.
  ///
  /// In ko, this message translates to:
  /// **'화면 모드'**
  String get screenModeLabel;

  /// No description provided for @themeModeSystem.
  ///
  /// In ko, this message translates to:
  /// **'시스템'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In ko, this message translates to:
  /// **'라이트'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In ko, this message translates to:
  /// **'다크'**
  String get themeModeDark;

  /// No description provided for @juiceThemeDescription.
  ///
  /// In ko, this message translates to:
  /// **'잔여량에 따라 색이 바뀌는 홈 화면 주스 색을 골라보세요. 앱 전체 포인트 컬러에도 반영돼요.'**
  String get juiceThemeDescription;

  /// No description provided for @themeOrange.
  ///
  /// In ko, this message translates to:
  /// **'오렌지'**
  String get themeOrange;

  /// No description provided for @themeStrawberry.
  ///
  /// In ko, this message translates to:
  /// **'딸기'**
  String get themeStrawberry;

  /// No description provided for @themeApple.
  ///
  /// In ko, this message translates to:
  /// **'사과'**
  String get themeApple;

  /// No description provided for @themeGrape.
  ///
  /// In ko, this message translates to:
  /// **'포도'**
  String get themeGrape;

  /// No description provided for @themeBlueberry.
  ///
  /// In ko, this message translates to:
  /// **'블루베리'**
  String get themeBlueberry;

  /// No description provided for @themeMulberry.
  ///
  /// In ko, this message translates to:
  /// **'오디'**
  String get themeMulberry;

  /// No description provided for @themeRandom.
  ///
  /// In ko, this message translates to:
  /// **'랜덤 (앱 켤 때마다)'**
  String get themeRandom;

  /// No description provided for @widgetSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'위젯 설정'**
  String get widgetSettingsTitle;

  /// No description provided for @homeScreenWidgetTitle.
  ///
  /// In ko, this message translates to:
  /// **'홈 화면 위젯'**
  String get homeScreenWidgetTitle;

  /// No description provided for @homeScreenWidgetDescription.
  ///
  /// In ko, this message translates to:
  /// **'홈 화면에 주스 게이지 위젯과 빠른 입력 위젯을 추가할 수 있어요.'**
  String get homeScreenWidgetDescription;

  /// No description provided for @hideWidgetAmountTitle.
  ///
  /// In ko, this message translates to:
  /// **'위젯에서 금액 가리기'**
  String get hideWidgetAmountTitle;

  /// No description provided for @hideWidgetAmountDescription.
  ///
  /// In ko, this message translates to:
  /// **'금액 대신 ***mL와 잔여 % 수위만 표시해요.'**
  String get hideWidgetAmountDescription;

  /// No description provided for @notificationSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'알림 설정'**
  String get notificationSettingsTitle;

  /// No description provided for @notificationScheduleDescription.
  ///
  /// In ko, this message translates to:
  /// **'매일 아침 7시, 저녁 8시에 기록을 유도하는 알림을 보내드려요.'**
  String get notificationScheduleDescription;

  /// No description provided for @receiveNotificationsTitle.
  ///
  /// In ko, this message translates to:
  /// **'주스 알림 받기'**
  String get receiveNotificationsTitle;

  /// No description provided for @receiveNotificationsDescription.
  ///
  /// In ko, this message translates to:
  /// **'오래 접속하지 않으면 재방문을 유도하는 알림도 함께 보내요.'**
  String get receiveNotificationsDescription;

  /// No description provided for @navHome.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get navHome;

  /// No description provided for @navCalendar.
  ///
  /// In ko, this message translates to:
  /// **'캘린더'**
  String get navCalendar;

  /// No description provided for @navAssets.
  ///
  /// In ko, this message translates to:
  /// **'자산'**
  String get navAssets;

  /// No description provided for @navStats.
  ///
  /// In ko, this message translates to:
  /// **'지출통계'**
  String get navStats;

  /// No description provided for @navSettings.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get navSettings;

  /// No description provided for @todayInstallmentLabel.
  ///
  /// In ko, this message translates to:
  /// **'🧊 오늘의 할부 분할액: {amount} mL'**
  String todayInstallmentLabel(Object amount);

  /// No description provided for @filterVariableOnlyLong.
  ///
  /// In ko, this message translates to:
  /// **'변동지출만 보기'**
  String get filterVariableOnlyLong;

  /// No description provided for @filterAllLong.
  ///
  /// In ko, this message translates to:
  /// **'전체 내역 보기'**
  String get filterAllLong;

  /// No description provided for @noGoalTitle.
  ///
  /// In ko, this message translates to:
  /// **'{period} 목표 금액이 아직 없어요'**
  String noGoalTitle(Object period);

  /// No description provided for @noGoalDescription.
  ///
  /// In ko, this message translates to:
  /// **'목표 설정에서 {period} 목표 금액을 채워주세요.'**
  String noGoalDescription(Object period);

  /// No description provided for @goToGoalSettings.
  ///
  /// In ko, this message translates to:
  /// **'목표 설정으로 이동'**
  String get goToGoalSettings;

  /// No description provided for @noExpensesYet.
  ///
  /// In ko, this message translates to:
  /// **'아직 기록된 지출이 없어요'**
  String get noExpensesYet;

  /// No description provided for @remainingJuiceLabel.
  ///
  /// In ko, this message translates to:
  /// **'{period} 남은 주스'**
  String remainingJuiceLabel(Object period);

  /// No description provided for @spentPercentLabel.
  ///
  /// In ko, this message translates to:
  /// **'소진율 {percent}%'**
  String spentPercentLabel(Object percent);

  /// No description provided for @overBudgetMessage1.
  ///
  /// In ko, this message translates to:
  /// **'아쉬워요! 다음 주엔 주스 남기기 꼭 성공해 봐요 🍊'**
  String get overBudgetMessage1;

  /// No description provided for @overBudgetMessage2.
  ///
  /// In ko, this message translates to:
  /// **'주스 통이 텅 비었어요! 이번 주는 잠시 쉬어가요 🥲'**
  String get overBudgetMessage2;

  /// No description provided for @overBudgetMessage3.
  ///
  /// In ko, this message translates to:
  /// **'넘친 주스는 어쩔 수 없죠! 다음 주에 다시 꽉 채워봐요 🧃'**
  String get overBudgetMessage3;

  /// No description provided for @overBudgetMessage4.
  ///
  /// In ko, this message translates to:
  /// **'마지막 한 방울까지 탈탈! 다음 주엔 조금만 천천히 마셔요 ✨'**
  String get overBudgetMessage4;

  /// No description provided for @incomeFallbackName.
  ///
  /// In ko, this message translates to:
  /// **'수입'**
  String get incomeFallbackName;

  /// No description provided for @unknownCategoryName.
  ///
  /// In ko, this message translates to:
  /// **'알 수 없음'**
  String get unknownCategoryName;

  /// No description provided for @fixedExpenseLabel.
  ///
  /// In ko, this message translates to:
  /// **'고정지출'**
  String get fixedExpenseLabel;

  /// No description provided for @installmentProgressLabel.
  ///
  /// In ko, this message translates to:
  /// **'할부 {index}/{months}'**
  String installmentProgressLabel(Object index, Object months);

  /// No description provided for @deletedMessage.
  ///
  /// In ko, this message translates to:
  /// **'삭제되었습니다'**
  String get deletedMessage;

  /// No description provided for @undoAction.
  ///
  /// In ko, this message translates to:
  /// **'실행취소'**
  String get undoAction;

  /// No description provided for @amountAndCategoryRequired.
  ///
  /// In ko, this message translates to:
  /// **'금액과 카테고리를 확인해주세요'**
  String get amountAndCategoryRequired;

  /// No description provided for @expenseLabel.
  ///
  /// In ko, this message translates to:
  /// **'지출'**
  String get expenseLabel;

  /// No description provided for @incomeLabel.
  ///
  /// In ko, this message translates to:
  /// **'수입'**
  String get incomeLabel;

  /// No description provided for @editTypeTitle.
  ///
  /// In ko, this message translates to:
  /// **'{type} 수정'**
  String editTypeTitle(Object type);

  /// No description provided for @addTypeTitle.
  ///
  /// In ko, this message translates to:
  /// **'{type} 추가'**
  String addTypeTitle(Object type);

  /// No description provided for @deleteTypeTitle.
  ///
  /// In ko, this message translates to:
  /// **'{type} 삭제'**
  String deleteTypeTitle(Object type);

  /// No description provided for @deleteTypeConfirm.
  ///
  /// In ko, this message translates to:
  /// **'이 {type} 내역을 삭제할까요?'**
  String deleteTypeConfirm(Object type);

  /// No description provided for @splitBillAutoFillHelper.
  ///
  /// In ko, this message translates to:
  /// **'아래에서 총 금액과 인원 수를 입력하면 자동으로 채워져요'**
  String get splitBillAutoFillHelper;

  /// No description provided for @cardSelectLabel.
  ///
  /// In ko, this message translates to:
  /// **'카드 선택'**
  String get cardSelectLabel;

  /// No description provided for @installmentEditNotice.
  ///
  /// In ko, this message translates to:
  /// **'할부 {index}/{months}회차 — 다른 회차 금액은 함께 바뀌지 않아요'**
  String installmentEditNotice(Object index, Object months);

  /// No description provided for @lumpSumLabel.
  ///
  /// In ko, this message translates to:
  /// **'일시불'**
  String get lumpSumLabel;

  /// No description provided for @monthsPresetLabel.
  ///
  /// In ko, this message translates to:
  /// **'{months}개월'**
  String monthsPresetLabel(Object months);

  /// No description provided for @customInputLabel.
  ///
  /// In ko, this message translates to:
  /// **'직접 입력'**
  String get customInputLabel;

  /// No description provided for @monthsCountHint.
  ///
  /// In ko, this message translates to:
  /// **'개월 수 (2~24)'**
  String get monthsCountHint;

  /// No description provided for @installmentMonthlyHint.
  ///
  /// In ko, this message translates to:
  /// **'매달 {amount} mL씩 {months}회 분할 반영돼요'**
  String installmentMonthlyHint(Object amount, Object months);

  /// No description provided for @totalPaymentAmountLabel.
  ///
  /// In ko, this message translates to:
  /// **'총 결제 금액'**
  String get totalPaymentAmountLabel;

  /// No description provided for @splitPeopleCountLabel.
  ///
  /// In ko, this message translates to:
  /// **'함께한 인원 수'**
  String get splitPeopleCountLabel;

  /// No description provided for @peopleCountSuffix.
  ///
  /// In ko, this message translates to:
  /// **'{count}명'**
  String peopleCountSuffix(Object count);

  /// No description provided for @splitBillHint.
  ///
  /// In ko, this message translates to:
  /// **'내가 낼 주스: {amount} mL (총 {total} mL ÷ {count}명)'**
  String splitBillHint(Object amount, Object total, Object count);

  /// No description provided for @splitBillMemoTag.
  ///
  /// In ko, this message translates to:
  /// **'(총 {total}mL / {count}명 더치페이)'**
  String splitBillMemoTag(Object total, Object count);

  /// No description provided for @memoHint.
  ///
  /// In ko, this message translates to:
  /// **'메모 (선택)'**
  String get memoHint;

  /// No description provided for @excludeAsFixedTitle.
  ///
  /// In ko, this message translates to:
  /// **'고정지출로 제외'**
  String get excludeAsFixedTitle;

  /// No description provided for @excludeAsFixedSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'월세, 보험료 등 — 주스 게이지에 반영되지 않아요'**
  String get excludeAsFixedSubtitle;

  /// No description provided for @incomeRecordedMessage.
  ///
  /// In ko, this message translates to:
  /// **'\'{category}\' 수입 {amount} mL가 들어왔어요! 💰'**
  String incomeRecordedMessage(Object category, Object amount);

  /// No description provided for @expenseRecordedMessage.
  ///
  /// In ko, this message translates to:
  /// **'\'{category}\' 지출 {amount} mL를 기록했어요! 🍊'**
  String expenseRecordedMessage(Object category, Object amount);

  /// No description provided for @calendarTitle.
  ///
  /// In ko, this message translates to:
  /// **'캘린더'**
  String get calendarTitle;

  /// No description provided for @monthlyTotalsLine.
  ///
  /// In ko, this message translates to:
  /// **'이번 달 총 지출 {expense} · 총 수입 {income}'**
  String monthlyTotalsLine(Object expense, Object income);

  /// No description provided for @filterVariableOnlyShort.
  ///
  /// In ko, this message translates to:
  /// **'변동지출만'**
  String get filterVariableOnlyShort;

  /// No description provided for @filterAllShort.
  ///
  /// In ko, this message translates to:
  /// **'전체 내역'**
  String get filterAllShort;

  /// No description provided for @noExpenseTodayMessage.
  ///
  /// In ko, this message translates to:
  /// **'지출 없는 상쾌한 날이에요! 🍊'**
  String get noExpenseTodayMessage;

  /// No description provided for @assetsTitle.
  ///
  /// In ko, this message translates to:
  /// **'자산'**
  String get assetsTitle;

  /// No description provided for @cumulativeNetWorthLabel.
  ///
  /// In ko, this message translates to:
  /// **'누적 순자산'**
  String get cumulativeNetWorthLabel;

  /// No description provided for @cumulativeNetWorthDescription.
  ///
  /// In ko, this message translates to:
  /// **'지금까지 기록된 모든 수입에서 지출을 뺀 값이에요.'**
  String get cumulativeNetWorthDescription;

  /// No description provided for @scopeThisYear.
  ///
  /// In ko, this message translates to:
  /// **'올해'**
  String get scopeThisYear;

  /// No description provided for @scopeLast5Years.
  ///
  /// In ko, this message translates to:
  /// **'5년간'**
  String get scopeLast5Years;

  /// No description provided for @totalIncomeLabel.
  ///
  /// In ko, this message translates to:
  /// **'{scope} 총 수입'**
  String totalIncomeLabel(Object scope);

  /// No description provided for @totalExpenseLabel.
  ///
  /// In ko, this message translates to:
  /// **'{scope} 총 지출'**
  String totalExpenseLabel(Object scope);

  /// No description provided for @netChangeTrendTitle.
  ///
  /// In ko, this message translates to:
  /// **'순증감 추이'**
  String get netChangeTrendTitle;

  /// No description provided for @netChangeTrendDescription.
  ///
  /// In ko, this message translates to:
  /// **'수입에서 지출을 뺀 순증감이에요. 초록은 흑자, 빨강은 적자예요.'**
  String get netChangeTrendDescription;

  /// No description provided for @statsTitle.
  ///
  /// In ko, this message translates to:
  /// **'통계'**
  String get statsTitle;

  /// No description provided for @filterFixedIncluded.
  ///
  /// In ko, this message translates to:
  /// **'고정비 포함'**
  String get filterFixedIncluded;

  /// No description provided for @totalExpenseTitle.
  ///
  /// In ko, this message translates to:
  /// **'총 지출'**
  String get totalExpenseTitle;

  /// No description provided for @categorySpendingTitle.
  ///
  /// In ko, this message translates to:
  /// **'카테고리별 소비'**
  String get categorySpendingTitle;

  /// No description provided for @paymentMethodSpendingTitle.
  ///
  /// In ko, this message translates to:
  /// **'결제 수단별 소비'**
  String get paymentMethodSpendingTitle;

  /// No description provided for @statsPeriodThisWeek.
  ///
  /// In ko, this message translates to:
  /// **'이번 주'**
  String get statsPeriodThisWeek;

  /// No description provided for @statsPeriodThisMonth.
  ///
  /// In ko, this message translates to:
  /// **'이번 달'**
  String get statsPeriodThisMonth;

  /// No description provided for @statsPeriodLast4Weeks.
  ///
  /// In ko, this message translates to:
  /// **'최근 4주'**
  String get statsPeriodLast4Weeks;

  /// No description provided for @statsPeriodMonthly.
  ///
  /// In ko, this message translates to:
  /// **'월별'**
  String get statsPeriodMonthly;

  /// No description provided for @statsPeriodYearly.
  ///
  /// In ko, this message translates to:
  /// **'연도별'**
  String get statsPeriodYearly;

  /// No description provided for @cardStatsViewSummary.
  ///
  /// In ko, this message translates to:
  /// **'대분류 요약'**
  String get cardStatsViewSummary;

  /// No description provided for @cardStatsViewByCard.
  ///
  /// In ko, this message translates to:
  /// **'카드별 상세'**
  String get cardStatsViewByCard;

  /// No description provided for @noExpensesInPeriod.
  ///
  /// In ko, this message translates to:
  /// **'해당 기간에 지출 내역이 없어요'**
  String get noExpensesInPeriod;

  /// No description provided for @installmentIncludedSuffix.
  ///
  /// In ko, this message translates to:
  /// **'할부 포함'**
  String get installmentIncludedSuffix;

  /// No description provided for @cardUnassigned.
  ///
  /// In ko, this message translates to:
  /// **'카드 미지정'**
  String get cardUnassigned;

  /// No description provided for @fillJuiceButton.
  ///
  /// In ko, this message translates to:
  /// **'주스 채우기'**
  String get fillJuiceButton;

  /// No description provided for @finishWizardButton.
  ///
  /// In ko, this message translates to:
  /// **'이 레시피로 주스 시작하기'**
  String get finishWizardButton;

  /// No description provided for @incomeStepQuestion.
  ///
  /// In ko, this message translates to:
  /// **'매달 들어오는 주스(월 수입)는\n얼마인가요?'**
  String get incomeStepQuestion;

  /// No description provided for @incomeStepSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'세후 실제 통장에 찍히는 금액을 적어주세요.'**
  String get incomeStepSubtitle;

  /// No description provided for @wonSuffixSpaced.
  ///
  /// In ko, this message translates to:
  /// **' 원'**
  String get wonSuffixSpaced;

  /// No description provided for @goalStepQuestion.
  ///
  /// In ko, this message translates to:
  /// **'얼마 동안, 얼마를\n모으고 싶나요?'**
  String get goalStepQuestion;

  /// No description provided for @yearsFieldLabel.
  ///
  /// In ko, this message translates to:
  /// **'년'**
  String get yearsFieldLabel;

  /// No description provided for @monthsFieldLabel.
  ///
  /// In ko, this message translates to:
  /// **'개월'**
  String get monthsFieldLabel;

  /// No description provided for @goalAmountFieldLabel.
  ///
  /// In ko, this message translates to:
  /// **'목표 모을 금액'**
  String get goalAmountFieldLabel;

  /// No description provided for @wonUnit.
  ///
  /// In ko, this message translates to:
  /// **'원'**
  String get wonUnit;

  /// No description provided for @fixedExpenseStepQuestion.
  ///
  /// In ko, this message translates to:
  /// **'매달 고정으로\n빠져나가는 돈이 있나요?'**
  String get fixedExpenseStepQuestion;

  /// No description provided for @fixedExpenseStepSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'월세, 보험료, 통신비 등 주스 통에 담지 않을 비용이에요.'**
  String get fixedExpenseStepSubtitle;

  /// No description provided for @itemNameHint.
  ///
  /// In ko, this message translates to:
  /// **'항목명'**
  String get itemNameHint;

  /// No description provided for @addItemButton.
  ///
  /// In ko, this message translates to:
  /// **'항목 추가'**
  String get addItemButton;

  /// No description provided for @resultStepQuestion.
  ///
  /// In ko, this message translates to:
  /// **'나만의 주스 플랜이\n완성되었어요!'**
  String get resultStepQuestion;

  /// No description provided for @resultNegativeMessage.
  ///
  /// In ko, this message translates to:
  /// **'고정지출과 저축액이 수입보다 많아요 😥 이전 단계로 돌아가 목표나 기간을 조정해보세요.'**
  String get resultNegativeMessage;

  /// No description provided for @resultBreakdownLine.
  ///
  /// In ko, this message translates to:
  /// **'월 수입 {income}원 - 고정비 {fixed}원 - 월 저축액을 빼면,'**
  String resultBreakdownLine(Object income, Object fixed);

  /// No description provided for @resultWeeklyPrefix.
  ///
  /// In ko, this message translates to:
  /// **'이번 주 '**
  String get resultWeeklyPrefix;

  /// No description provided for @resultWeeklySuffix.
  ///
  /// In ko, this message translates to:
  /// **'의 주스를 마실 수 있어요! 🍊'**
  String get resultWeeklySuffix;

  /// No description provided for @resultDailyMonthlyLine.
  ///
  /// In ko, this message translates to:
  /// **'하루 {daily} mL · 한 달 {monthly} mL'**
  String resultDailyMonthlyLine(Object daily, Object monthly);

  /// No description provided for @periodDaily.
  ///
  /// In ko, this message translates to:
  /// **'오늘'**
  String get periodDaily;

  /// No description provided for @periodWeekly.
  ///
  /// In ko, this message translates to:
  /// **'이번 주'**
  String get periodWeekly;

  /// No description provided for @periodMonthly.
  ///
  /// In ko, this message translates to:
  /// **'이번 달'**
  String get periodMonthly;

  /// No description provided for @periodSettingDaily.
  ///
  /// In ko, this message translates to:
  /// **'일간'**
  String get periodSettingDaily;

  /// No description provided for @periodSettingWeekly.
  ///
  /// In ko, this message translates to:
  /// **'주간'**
  String get periodSettingWeekly;

  /// No description provided for @periodSettingMonthly.
  ///
  /// In ko, this message translates to:
  /// **'월간'**
  String get periodSettingMonthly;

  /// No description provided for @weekStartMonday.
  ///
  /// In ko, this message translates to:
  /// **'월요일 시작 (월~일)'**
  String get weekStartMonday;

  /// No description provided for @weekStartSunday.
  ///
  /// In ko, this message translates to:
  /// **'일요일 시작 (일~토)'**
  String get weekStartSunday;

  /// No description provided for @installmentModeMonthlyLabel.
  ///
  /// In ko, this message translates to:
  /// **'익월 1일 일괄 청구'**
  String get installmentModeMonthlyLabel;

  /// No description provided for @installmentModeDailyLabel.
  ///
  /// In ko, this message translates to:
  /// **'매일 균등 분할 청구'**
  String get installmentModeDailyLabel;

  /// No description provided for @installmentModeMonthlyDescription.
  ///
  /// In ko, this message translates to:
  /// **'실제 카드 대금처럼, 할부 회차 금액이 매월 1일에 한 번에 지출로 잡혀요.'**
  String get installmentModeMonthlyDescription;

  /// No description provided for @installmentModeDailyDescription.
  ///
  /// In ko, this message translates to:
  /// **'그 달의 할부 회차 금액을 일수만큼 나눠 매일 조금씩 주스 게이지에서 빠져나가요.'**
  String get installmentModeDailyDescription;

  /// No description provided for @splashOrangeSubText.
  ///
  /// In ko, this message translates to:
  /// **'상쾌하게 채우는 이번 주 예산'**
  String get splashOrangeSubText;

  /// No description provided for @splashGreenAppleSubText.
  ///
  /// In ko, this message translates to:
  /// **'싱그럽게 아끼는 소비 습관'**
  String get splashGreenAppleSubText;

  /// No description provided for @splashGrapeSubText.
  ///
  /// In ko, this message translates to:
  /// **'달콤하게 지켜내는 나만의 한도'**
  String get splashGrapeSubText;

  /// No description provided for @splashStrawberrySubText.
  ///
  /// In ko, this message translates to:
  /// **'기분 좋게 채워지는 하루'**
  String get splashStrawberrySubText;

  /// No description provided for @confirmNewPinPrompt.
  ///
  /// In ko, this message translates to:
  /// **'새 비밀번호를 다시 입력해주세요'**
  String get confirmNewPinPrompt;

  /// No description provided for @enterCurrentPinPrompt.
  ///
  /// In ko, this message translates to:
  /// **'현재 비밀번호를 입력해주세요'**
  String get enterCurrentPinPrompt;

  /// No description provided for @enterNewPinPrompt.
  ///
  /// In ko, this message translates to:
  /// **'새 비밀번호를 입력해주세요'**
  String get enterNewPinPrompt;

  /// No description provided for @enterPinPrompt.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호를 입력해주세요'**
  String get enterPinPrompt;

  /// No description provided for @juiceLockTitle.
  ///
  /// In ko, this message translates to:
  /// **'주스가 잠겨있어요'**
  String get juiceLockTitle;

  /// No description provided for @pinConfirmMismatchError.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호가 일치하지 않아요. 다시 입력해주세요'**
  String get pinConfirmMismatchError;

  /// No description provided for @pinMismatchError.
  ///
  /// In ko, this message translates to:
  /// **'비밀번호가 일치하지 않아요'**
  String get pinMismatchError;

  /// No description provided for @shareCardText.
  ///
  /// In ko, this message translates to:
  /// **'나의 주스 절약 카드'**
  String get shareCardText;

  /// No description provided for @unlockJuiceReason.
  ///
  /// In ko, this message translates to:
  /// **'주스 잠금을 해제하려면 인증해주세요'**
  String get unlockJuiceReason;

  /// No description provided for @unlockWithBiometrics.
  ///
  /// In ko, this message translates to:
  /// **'생체인증으로 잠금 해제'**
  String get unlockWithBiometrics;

  /// No description provided for @yearsPresetLabel.
  ///
  /// In ko, this message translates to:
  /// **'{years}년'**
  String yearsPresetLabel(Object years);

  /// No description provided for @settingsLanguage.
  ///
  /// In ko, this message translates to:
  /// **'언어 설정'**
  String get settingsLanguage;

  /// No description provided for @settingsCurrency.
  ///
  /// In ko, this message translates to:
  /// **'통화 단위 설정'**
  String get settingsCurrency;

  /// No description provided for @currencySelectTitle.
  ///
  /// In ko, this message translates to:
  /// **'통화 단위를 선택해주세요'**
  String get currencySelectTitle;

  /// No description provided for @commonDone.
  ///
  /// In ko, this message translates to:
  /// **'완료'**
  String get commonDone;

  /// No description provided for @currencyNameKrw.
  ///
  /// In ko, this message translates to:
  /// **'대한민국 원 (₩)'**
  String get currencyNameKrw;

  /// No description provided for @currencyNameUsd.
  ///
  /// In ko, this message translates to:
  /// **'미국 달러 (\$)'**
  String get currencyNameUsd;

  /// No description provided for @currencyNameJpy.
  ///
  /// In ko, this message translates to:
  /// **'일본 엔 (¥)'**
  String get currencyNameJpy;

  /// No description provided for @currencyNameEur.
  ///
  /// In ko, this message translates to:
  /// **'유로 (€)'**
  String get currencyNameEur;

  /// No description provided for @currencyNameVnd.
  ///
  /// In ko, this message translates to:
  /// **'베트남 동 (₫)'**
  String get currencyNameVnd;

  /// No description provided for @foreignCurrencyPickerTitle.
  ///
  /// In ko, this message translates to:
  /// **'결제 통화 선택'**
  String get foreignCurrencyPickerTitle;

  /// No description provided for @exchangeRateHint.
  ///
  /// In ko, this message translates to:
  /// **'≈ {converted} (당일 환율: {rate})'**
  String exchangeRateHint(Object converted, Object rate);

  /// No description provided for @exchangeRateLoadingMessage.
  ///
  /// In ko, this message translates to:
  /// **'환율 조회 중...'**
  String get exchangeRateLoadingMessage;

  /// No description provided for @exchangeRateFailedMessage.
  ///
  /// In ko, this message translates to:
  /// **'환율을 불러오지 못했어요. 직접 입력하거나 마지막 환율을 사용해주세요'**
  String get exchangeRateFailedMessage;

  /// No description provided for @manualRateEntryToggle.
  ///
  /// In ko, this message translates to:
  /// **'환율 직접 입력'**
  String get manualRateEntryToggle;

  /// No description provided for @manualExchangeRateLabel.
  ///
  /// In ko, this message translates to:
  /// **'1 {code} = ? {baseCode}'**
  String manualExchangeRateLabel(Object code, Object baseCode);

  /// No description provided for @commonRetry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도'**
  String get commonRetry;

  /// No description provided for @commonConfirm.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get commonConfirm;

  /// No description provided for @currencyMigrationConfirmMessage.
  ///
  /// In ko, this message translates to:
  /// **'기준 통화를 {toCode}로 변경하시겠습니까? 기존에 기록된 모든 금액이 현재 환율 기준으로 자동 환산됩니다.'**
  String currencyMigrationConfirmMessage(Object toCode);

  /// No description provided for @currencyMigrationLoadingMessage.
  ///
  /// In ko, this message translates to:
  /// **'기존 가계부 데이터를 새 통화에 맞게 환산하고 있어요... 🍊'**
  String get currencyMigrationLoadingMessage;

  /// No description provided for @currencyMigrationFailedMessage.
  ///
  /// In ko, this message translates to:
  /// **'환율을 가져오지 못해 기존 금액은 이전 그대로 유지돼요'**
  String get currencyMigrationFailedMessage;

  /// No description provided for @category_food_name.
  ///
  /// In ko, this message translates to:
  /// **'식비'**
  String get category_food_name;

  /// No description provided for @category_food_desc.
  ///
  /// In ko, this message translates to:
  /// **'오늘 마신 맛있는 에너지 🍱'**
  String get category_food_desc;

  /// No description provided for @category_cafe_name.
  ///
  /// In ko, this message translates to:
  /// **'카페/간식'**
  String get category_cafe_name;

  /// No description provided for @category_cafe_desc.
  ///
  /// In ko, this message translates to:
  /// **'기분 좋아지는 디저트 한 스푼 ☕️'**
  String get category_cafe_desc;

  /// No description provided for @category_transport_name.
  ///
  /// In ko, this message translates to:
  /// **'교통'**
  String get category_transport_name;

  /// No description provided for @category_transport_desc.
  ///
  /// In ko, this message translates to:
  /// **'목적지까지 부드러운 이동 🚌'**
  String get category_transport_desc;

  /// No description provided for @category_shopping_name.
  ///
  /// In ko, this message translates to:
  /// **'쇼핑'**
  String get category_shopping_name;

  /// No description provided for @category_shopping_desc.
  ///
  /// In ko, this message translates to:
  /// **'나를 채우는 득템의 즐거움 🛍️'**
  String get category_shopping_desc;

  /// No description provided for @category_culture_name.
  ///
  /// In ko, this message translates to:
  /// **'문화/여가'**
  String get category_culture_name;

  /// No description provided for @category_culture_desc.
  ///
  /// In ko, this message translates to:
  /// **'영혼을 채우는 달콤한 휴식 🎬'**
  String get category_culture_desc;

  /// No description provided for @category_life_name.
  ///
  /// In ko, this message translates to:
  /// **'생활'**
  String get category_life_name;

  /// No description provided for @category_life_desc.
  ///
  /// In ko, this message translates to:
  /// **'쾌적한 일상을 위한 한 모금 🧼'**
  String get category_life_desc;

  /// No description provided for @category_etc_name.
  ///
  /// In ko, this message translates to:
  /// **'기타'**
  String get category_etc_name;

  /// No description provided for @category_etc_desc.
  ///
  /// In ko, this message translates to:
  /// **'어디에나 어울리는 다채로운 소비 💬'**
  String get category_etc_desc;

  /// No description provided for @savedJuiceBadgeLabel.
  ///
  /// In ko, this message translates to:
  /// **'지켜낸 주스 +{amount} mL'**
  String savedJuiceBadgeLabel(Object amount);

  /// No description provided for @savingHistoryTitle.
  ///
  /// In ko, this message translates to:
  /// **'절약 기록'**
  String get savingHistoryTitle;

  /// No description provided for @savingHistoryEmpty.
  ///
  /// In ko, this message translates to:
  /// **'아직 마감된 주기가 없어요.\n첫 주기를 채워보세요!'**
  String get savingHistoryEmpty;

  /// No description provided for @savingHistorySuccessLine.
  ///
  /// In ko, this message translates to:
  /// **'+{amount} mL 절약 성공!'**
  String savingHistorySuccessLine(Object amount);

  /// No description provided for @savingHistoryOverLine.
  ///
  /// In ko, this message translates to:
  /// **'초과 소비 {amount} mL'**
  String savingHistoryOverLine(Object amount);

  /// No description provided for @savingHistoryDetailLine.
  ///
  /// In ko, this message translates to:
  /// **'목표 {target} / 소비 {spent}'**
  String savingHistoryDetailLine(Object target, Object spent);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'ja', 'ko', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
    case 'ko': return AppLocalizationsKo();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
