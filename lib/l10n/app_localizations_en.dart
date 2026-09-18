import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Juice Budget';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get setBudgetTitle => 'Set your juice budget';

  @override
  String get weeklyBudget => 'Remaining Juice This Week';

  @override
  String get paymentCheckCard => 'Debit Card';

  @override
  String get paymentCreditCard => 'Credit Card';

  @override
  String get paymentCash => 'Cash · Transfer';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonNext => 'Next';

  @override
  String get goalSettingsTitle => 'Goal Settings';

  @override
  String get activePeriodSectionTitle => 'Active Goal Period';

  @override
  String get activePeriodSectionDescription => 'The period your home gauge is based on. Fill in each period\'s target below so switching applies it instantly.';

  @override
  String get weekStartDayTileTitle => 'Week Start Day';

  @override
  String get periodTargetSectionTitle => 'Target Amount by Period';

  @override
  String get periodTargetSectionDescription => 'Save a separate target amount for each period and pick the one you need.';

  @override
  String get periodTargetAmountSuffix => 'Target Amount';

  @override
  String get installmentSectionTitle => 'Installment Reflection Method';

  @override
  String get installmentSectionDescription => 'Choose when and how installment expenses are reflected in the calendar/juice gauge.';

  @override
  String get recommendedSuffix => 'Recommended';

  @override
  String get savingsPlanSectionTitle => 'Mid/Long-term Savings Planner';

  @override
  String get savingsPlanSectionDescription => 'Enter your monthly income, fixed expenses, and savings goal to calculate how much juice you can spend.';

  @override
  String get savingsPlanToggleTitle => 'Do you have a mid/long-term savings goal?';

  @override
  String get autoBudgetSetMessage => 'Daily/weekly/monthly targets set automatically 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 My Juice Plan Summary';

  @override
  String get replanButton => 'Redo Plan';

  @override
  String get applyBudgetButton => 'Auto-set Juice with This Budget';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '${years}y ${months}m';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years years';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months months';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return 'Goal: Save $amount won over $duration';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return 'Fixed costs (unavoidable): $amount won/month';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return 'Recommended juice: $daily mL/day · $weekly mL/week · $monthly mL/month';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get savingsCardSectionTitle => 'This Week\'s Savings Card';

  @override
  String get savingsCardSectionDescription => 'Turn a budget-win week into a card and share it.';

  @override
  String get generatingCard => 'Generating card...';

  @override
  String get shareCardButton => 'Share Card';

  @override
  String get setTargetAmountFirst => 'Please set a target amount first';

  @override
  String get menuGoalSettingsTitle => 'Goal Settings';

  @override
  String get menuGoalSettingsSubtitle => 'Long-term savings goal, goal period, target per period';

  @override
  String get menuThemeSettingsTitle => 'Theme Settings';

  @override
  String get menuThemeSettingsSubtitle => 'Screen mode and juice theme';

  @override
  String get menuWidgetSettingsTitle => 'Widget Settings';

  @override
  String get menuWidgetSettingsSubtitle => 'Hide amount on home widget';

  @override
  String get menuCardManagementTitle => 'My Card Management';

  @override
  String get menuCardManagementSubtitle => 'Register cards you own, reorder them';

  @override
  String get menuNotificationSettingsTitle => 'Notification Settings';

  @override
  String get menuNotificationSettingsSubtitle => 'Turn morning/evening reminders on/off';

  @override
  String get menuBackupSettingsTitle => 'Data Backup & Restore';

  @override
  String get menuBackupSettingsSubtitle => 'Export CSV, export/import backup file';

  @override
  String get menuSecuritySettingsTitle => 'Security';

  @override
  String get menuSecuritySettingsSubtitle => 'PIN code, biometric auth';

  @override
  String get appNameShort => 'Juice';

  @override
  String get savingsCardSuccessMessage => 'You kept this week\'s\njuice fresh!';

  @override
  String get savingsCardOverMessage => 'This week\'s juice\nspilled a little';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return 'Spent $spent of $budget';
  }

  @override
  String get savingsCardSuccessStamp => 'SUCCESS';

  @override
  String get savingsCardOverStamp => 'TRY HARDER';

  @override
  String get pinSetupTitle => 'Set Password';

  @override
  String get biometricUnlockReason => 'Authenticate to unlock';

  @override
  String get pinConfirmTitle => 'Confirm Password';

  @override
  String get pinConfirmCurrentTitle => 'Confirm Current Password';

  @override
  String get pinSetupNewTitle => 'Set New Password';

  @override
  String get pinChangedMessage => 'Password changed';

  @override
  String get biometricLinkTitle => 'Link Biometric Auth';

  @override
  String get biometricLinkConfirm => 'Would you like to link biometric authentication?';

  @override
  String get biometricLinkAction => 'Link';

  @override
  String get biometricLinkReason => 'Authenticate to link biometrics';

  @override
  String get biometricUnavailableMessage => 'Biometric authentication is unavailable';

  @override
  String get securityTitle => 'Security';

  @override
  String get securityDescription => 'Lock the app with a PIN or biometrics.';

  @override
  String get appLockTitle => 'App Lock';

  @override
  String get appLockDescription => 'Protect app access with a 4-digit PIN.';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get biometricUseTitle => 'Use Biometrics';

  @override
  String get biometricUseDescription => 'Unlock faster with Face ID/fingerprint.';

  @override
  String get csvShareText => 'Juice Expense History';

  @override
  String get backupShareText => 'Juice Data Backup';

  @override
  String backupFailedMessage(Object error) {
    return 'Backup failed: $error';
  }

  @override
  String get restoreDataTitle => 'Restore Data';

  @override
  String get restoreDataConfirm => 'Existing data will be replaced by the backup file. Continue?';

  @override
  String get restoreAction => 'Restore';

  @override
  String get restoreSuccessMessage => 'Restore complete';

  @override
  String get restoreFailedMessage => 'Restore failed. Please check that this is a valid Juice backup file';

  @override
  String get backupSettingsTitle => 'Data Backup & Restore';

  @override
  String get exportExpensesTitle => 'Export Expense History';

  @override
  String get exportExpensesDescription => 'Share a CSV with date, category, amount, fixed-expense flag, and memo.';

  @override
  String get exportingCsv => 'Exporting...';

  @override
  String get exportCsvButton => 'Export as CSV';

  @override
  String get backupRestoreTitle => 'Data Backup · Restore';

  @override
  String get backupRestoreDescription => 'Back up and restore expenses, income, categories, and budget settings in one file.';

  @override
  String get backupDataTitle => 'Back Up Data';

  @override
  String get backupDataDescription => 'Save via share sheet to Files, email, etc.';

  @override
  String get restoreDataTileTitle => 'Restore Data';

  @override
  String get restoreDataTileDescription => 'Pick a backup file to overwrite existing data.';

  @override
  String get categoryDefaultDescription => 'My special juice recipe';

  @override
  String get categoryDeleteTitle => 'Delete Category';

  @override
  String categoryDeleteConfirm(Object name) {
    return 'Delete the \'$name\' category?\nAlready recorded expenses are kept.';
  }

  @override
  String get categoryInUseMessage => 'Some records use this category. Move them to another category before deleting.';

  @override
  String get categoryEditTitle => 'Edit Category';

  @override
  String get categoryAddTitle => 'Add Category';

  @override
  String get categoryNameLabel => 'Category Name';

  @override
  String get categoryDescriptionLabel => 'Short Description';

  @override
  String get colorLabel => 'Color';

  @override
  String get iconLabel => 'Icon';

  @override
  String get categoryManageTitle => 'Category Management';

  @override
  String get expenseCategoryTab => 'Expense Categories';

  @override
  String get incomeCategoryTab => 'Income Categories';

  @override
  String get defaultCategoryUndeletable => 'Default categories can\'t be deleted';

  @override
  String get cardDeleteTitle => 'Delete Card';

  @override
  String cardDeleteConfirm(Object name) {
    return 'Delete the \'$name\' card?\nAlready recorded expenses are kept.';
  }

  @override
  String get cardEditTitle => 'Edit Card';

  @override
  String get cardAddTitle => 'Add Card';

  @override
  String get cardNameLabel => 'Card Name';

  @override
  String get cardTypeLabel => 'Card Type';

  @override
  String get cardManagementTitle => 'My Card Management';

  @override
  String get defaultCardUndeletable => 'Default cards can\'t be deleted';

  @override
  String get cardTypeCorporate => 'Corporate/Business';

  @override
  String get cardTypeCorporateExcluded => 'Corporate (expense) · Excluded from juice';

  @override
  String get corporateExpenseNotice => '🏢 Corporate/business expenses skip category selection and are automatically excluded from your personal spending.';

  @override
  String get corporateBadgeLabel => '🏢 Corporate/Business · Excluded from personal';

  @override
  String get corporateCardLabel => 'Corporate/Business Card';

  @override
  String get corporateMemoRequired => 'Please enter a memo (purpose) for corporate/business expenses';

  @override
  String get juiceThemeLabel => 'Juice Theme';

  @override
  String get themeSettingsTitle => 'Theme Settings';

  @override
  String get screenModeLabel => 'Screen Mode';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get juiceThemeDescription => 'Pick the juice color that changes with your remaining budget. It also becomes the app\'s accent color.';

  @override
  String get themeOrange => 'Orange';

  @override
  String get themeStrawberry => 'Strawberry';

  @override
  String get themeApple => 'Apple';

  @override
  String get themeGrape => 'Grape';

  @override
  String get themeBlueberry => 'Blueberry';

  @override
  String get themeMulberry => 'Mulberry';

  @override
  String get themeRandom => 'Random (each time you open the app)';

  @override
  String get widgetSettingsTitle => 'Widget Settings';

  @override
  String get homeScreenWidgetTitle => 'Home Screen Widget';

  @override
  String get homeScreenWidgetDescription => 'You can add a juice gauge widget and quick-entry widget to your home screen.';

  @override
  String get hideWidgetAmountTitle => 'Hide Amount on Widget';

  @override
  String get hideWidgetAmountDescription => 'Shows ***mL and remaining % instead of the amount.';

  @override
  String get notificationSettingsTitle => 'Notification Settings';

  @override
  String get notificationScheduleDescription => 'We\'ll send reminders every day at 7 AM and 8 PM to encourage logging.';

  @override
  String get receiveNotificationsTitle => 'Receive Juice Notifications';

  @override
  String get receiveNotificationsDescription => 'We\'ll also nudge you to come back if you haven\'t opened the app in a while.';

  @override
  String get navHome => 'Home';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navAssets => 'Assets';

  @override
  String get navStats => 'Stats';

  @override
  String get navSettings => 'Settings';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 Today\'s installment portion: $amount mL';
  }

  @override
  String get filterVariableOnlyLong => 'Show Variable Only';

  @override
  String get filterAllLong => 'Show All';

  @override
  String noGoalTitle(Object period) {
    return 'No target amount set for $period yet';
  }

  @override
  String noGoalDescription(Object period) {
    return 'Please fill in the $period target in Goal Settings.';
  }

  @override
  String get goToGoalSettings => 'Go to Goal Settings';

  @override
  String get noExpensesYet => 'No expenses recorded yet';

  @override
  String remainingJuiceLabel(Object period) {
    return 'Remaining Juice $period';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '$percent% used';
  }

  @override
  String get overBudgetMessage1 => 'Too bad! Let\'s leave some juice next week 🍊';

  @override
  String get overBudgetMessage2 => 'The juice jug is empty! Take a breather this week 🥲';

  @override
  String get overBudgetMessage3 => 'Spilled juice happens! Fill it back up next week 🧃';

  @override
  String get overBudgetMessage4 => 'Down to the last drop! Sip a little slower next week ✨';

  @override
  String get incomeFallbackName => 'Income';

  @override
  String get unknownCategoryName => 'Unknown';

  @override
  String get fixedExpenseLabel => 'Fixed';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return 'Installment $index/$months';
  }

  @override
  String get deletedMessage => 'Deleted';

  @override
  String get undoAction => 'Undo';

  @override
  String get amountAndCategoryRequired => 'Please check the amount and category';

  @override
  String get expenseLabel => 'Expense';

  @override
  String get incomeLabel => 'Income';

  @override
  String editTypeTitle(Object type) {
    return 'Edit $type';
  }

  @override
  String addTypeTitle(Object type) {
    return 'Add $type';
  }

  @override
  String deleteTypeTitle(Object type) {
    return 'Delete $type';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return 'Delete this $type record?';
  }

  @override
  String get cardSelectLabel => 'Select Card';

  @override
  String installmentEditNotice(Object index, Object months) {
    return 'Installment $index/$months — other installments won\'t change together';
  }

  @override
  String get lumpSumLabel => 'Lump Sum';

  @override
  String monthsPresetLabel(Object months) {
    return '$months mo';
  }

  @override
  String get customInputLabel => 'Custom';

  @override
  String get monthsCountHint => 'Number of months (2-24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return 'Reflected as $amount mL each month for $months installments';
  }

  @override
  String get memoHint => 'Memo (optional)';

  @override
  String get excludeAsFixedTitle => 'Exclude as Fixed Expense';

  @override
  String get excludeAsFixedSubtitle => 'Rent, insurance, etc. — not reflected in the juice gauge';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return '\'$category\' income of $amount mL received! 💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return 'Recorded $amount mL for \'$category\'! 🍊';
  }

  @override
  String get calendarTitle => 'Calendar';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return 'This month: $expense spent · $income earned';
  }

  @override
  String get filterVariableOnlyShort => 'Variable Only';

  @override
  String get filterAllShort => 'All';

  @override
  String get noExpenseTodayMessage => 'A refreshing expense-free day! 🍊';

  @override
  String get assetsTitle => 'Assets';

  @override
  String get cumulativeNetWorthLabel => 'Cumulative Net Worth';

  @override
  String get cumulativeNetWorthDescription => 'All recorded income minus expenses so far.';

  @override
  String get scopeThisYear => 'this year';

  @override
  String get scopeLast5Years => 'last 5 years';

  @override
  String totalIncomeLabel(Object scope) {
    return 'Total Income ($scope)';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return 'Total Expense ($scope)';
  }

  @override
  String get netChangeTrendTitle => 'Net Change Trend';

  @override
  String get netChangeTrendDescription => 'Net change = income minus expenses. Green is surplus, red is deficit.';

  @override
  String get statsTitle => 'Stats';

  @override
  String get filterFixedIncluded => 'Include Fixed';

  @override
  String get totalExpenseTitle => 'Total Expense';

  @override
  String get categorySpendingTitle => 'Spending by Category';

  @override
  String get paymentMethodSpendingTitle => 'Spending by Payment Method';

  @override
  String get statsPeriodThisWeek => 'This Week';

  @override
  String get statsPeriodThisMonth => 'This Month';

  @override
  String get statsPeriodLast4Weeks => 'Last 4 Weeks';

  @override
  String get statsPeriodMonthly => 'Monthly';

  @override
  String get statsPeriodYearly => 'Yearly';

  @override
  String get cardStatsViewSummary => 'Summary';

  @override
  String get cardStatsViewByCard => 'By Card';

  @override
  String get noExpensesInPeriod => 'No records in this period';

  @override
  String get categoryDetailThisMonthTotal => 'This Month\'s Total';

  @override
  String get categoryDetailMonthlyTrendTitle => 'Monthly Trend';

  @override
  String get categoryDetailExpenseListTitle => 'Transaction Details';

  @override
  String get categoryDetailEmptyMessage => 'No records yet';

  @override
  String get installmentIncludedSuffix => 'incl. installments';

  @override
  String get cardUnassigned => 'No Card Assigned';

  @override
  String get fillJuiceButton => 'Fill Juice';

  @override
  String get finishWizardButton => 'Start Juice with This Recipe';

  @override
  String get incomeStepQuestion => 'How much juice (income)\ncomes in each month?';

  @override
  String get incomeStepSubtitle => 'Enter the actual after-tax amount that hits your account.';

  @override
  String get wonSuffixSpaced => ' won';

  @override
  String get goalStepQuestion => 'How long, and how much\ndo you want to save?';

  @override
  String get yearsFieldLabel => 'years';

  @override
  String get monthsFieldLabel => 'months';

  @override
  String get goalAmountFieldLabel => 'Target Savings Amount';

  @override
  String get wonUnit => 'won';

  @override
  String get fixedExpenseStepQuestion => 'Do you have any fixed\nmonthly expenses?';

  @override
  String get fixedExpenseStepSubtitle => 'Rent, insurance, phone bill, etc. — costs not counted in the juice jug.';

  @override
  String get itemNameHint => 'Item Name';

  @override
  String get addItemButton => 'Add Item';

  @override
  String get resultStepQuestion => 'Your own juice plan\nis complete!';

  @override
  String get resultNegativeMessage => 'Fixed expenses and savings exceed income 😥 Go back and adjust your goal or duration.';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return 'Monthly income $income won - fixed costs $fixed won - monthly savings, leaves:';
  }

  @override
  String get resultWeeklyPrefix => 'This week: ';

  @override
  String get resultWeeklySuffix => ' of juice to enjoy! 🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '$daily mL/day · $monthly mL/month';
  }

  @override
  String get periodDaily => 'Today';

  @override
  String get periodWeekly => 'This Week';

  @override
  String get periodMonthly => 'This Month';

  @override
  String get periodSettingDaily => 'Daily';

  @override
  String get periodSettingWeekly => 'Weekly';

  @override
  String get periodSettingMonthly => 'Monthly';

  @override
  String get weekStartMonday => 'Starts Monday (Mon–Sun)';

  @override
  String get weekStartSunday => 'Starts Sunday (Sun–Sat)';

  @override
  String get installmentModeMonthlyLabel => 'Billed in Full Next Month';

  @override
  String get installmentModeDailyLabel => 'Billed Evenly Every Day';

  @override
  String get installmentModeMonthlyDescription => 'Like a real card statement, the installment amount is recorded as an expense once on the 1st of each month.';

  @override
  String get installmentModeDailyDescription => 'That month\'s installment amount is divided by the number of days and drains a little from the juice gauge each day.';

  @override
  String get splashOrangeSubText => 'This week\'s budget, refreshingly filled';

  @override
  String get splashGreenAppleSubText => 'A fresh habit of mindful spending';

  @override
  String get splashGrapeSubText => 'Sweetly protecting your own limit';

  @override
  String get splashStrawberrySubText => 'A day that fills up nicely';

  @override
  String get confirmNewPinPrompt => 'Please re-enter your new password';

  @override
  String get enterCurrentPinPrompt => 'Please enter your current password';

  @override
  String get enterNewPinPrompt => 'Please enter a new password';

  @override
  String get enterPinPrompt => 'Please enter your password';

  @override
  String get juiceLockTitle => 'Juice is Locked';

  @override
  String get pinConfirmMismatchError => 'Passwords don\'t match. Please try again';

  @override
  String get pinMismatchError => 'Password doesn\'t match';

  @override
  String get shareCardText => 'My Juice Savings Card';

  @override
  String get unlockJuiceReason => 'Authenticate to unlock your juice';

  @override
  String get unlockWithBiometrics => 'Unlock with Biometrics';

  @override
  String yearsPresetLabel(Object years) {
    return '$years yr';
  }

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsCurrency => 'Base Currency Setting';

  @override
  String get currencySelectTitle => 'Select your currency';

  @override
  String get commonDone => 'Done';

  @override
  String get currencyNameKrw => 'South Korean Won (₩)';

  @override
  String get currencyNameUsd => 'US Dollar (\$)';

  @override
  String get currencyNameJpy => 'Japanese Yen (¥)';

  @override
  String get currencyNameEur => 'Euro (€)';

  @override
  String get currencyNameVnd => 'Vietnamese Dong (₫)';

  @override
  String get foreignCurrencyPickerTitle => 'Select payment currency';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted (today\'s rate: $rate)';
  }

  @override
  String get exchangeRateLoadingMessage => 'Fetching exchange rate...';

  @override
  String get exchangeRateFailedMessage => 'Couldn\'t fetch the exchange rate. Enter it manually or use the last known rate.';

  @override
  String get manualRateEntryToggle => 'Enter rate manually';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return 'Change your base currency to $toCode? All previously recorded amounts will be automatically converted using the current exchange rate.';
  }

  @override
  String get currencyMigrationLoadingMessage => 'Converting your existing records to the new currency... 🍊';

  @override
  String get currencyMigrationFailedMessage => 'Couldn\'t fetch the exchange rate, so existing amounts were left unchanged';

  @override
  String get category_food_name => 'Food & Dining';

  @override
  String get category_food_desc => 'Delicious energy for today 🍱';

  @override
  String get category_cafe_name => 'Cafe & Snacks';

  @override
  String get category_cafe_desc => 'A sweet spoon of delight ☕️';

  @override
  String get category_transport_name => 'Transportation';

  @override
  String get category_transport_desc => 'Smooth ride to destination 🚌';

  @override
  String get category_shopping_name => 'Shopping';

  @override
  String get category_shopping_desc => 'Joy of treating myself 🛍️';

  @override
  String get category_culture_name => 'Culture & Leisure';

  @override
  String get category_culture_desc => 'Sweet recharge for the soul 🎬';

  @override
  String get category_life_name => 'Living & Home';

  @override
  String get category_life_desc => 'Fresh sips for daily comfort 🧼';

  @override
  String get category_etc_name => 'Other';

  @override
  String get category_etc_desc => 'Colorful daily expenses 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return 'Juice saved +$amount mL';
  }

  @override
  String get savingHistoryTitle => 'Savings History';

  @override
  String get savingHistoryEmpty => 'No periods closed yet.\nFinish your first period!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '+$amount mL saved!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return 'Overspent $amount mL';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return 'Target $target / Spent $spent';
  }

  @override
  String get savingOptionTitle => 'How to handle leftover juice';

  @override
  String get savingOptionDescription => 'Choose what happens to your unused budget when a period ends.';

  @override
  String get savingOptionRollover => 'Roll over to next period';

  @override
  String get savingOptionSavings => 'Save as emergency fund';

  @override
  String get savedJuiceStoreTooltip => 'Juice Vault';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return 'Juice saved: $amount mL ($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return 'Includes +$amount mL rolled over from last period';
  }

  @override
  String get savingsAssetCardTitle => 'Assets protected by saving';

  @override
  String get savingsAssetCardDescription => 'Total leftover juice from periods closed with the savings option.';

  @override
  String get savingPraise_1 => 'You\'ve saved this much already! Amazing!! You\'re getting closer to your goal 🍊';

  @override
  String get savingPraise_2 => 'You\'ve kept your precious juice fresh! Your saving habits are shining ✨';

  @override
  String get savingPraise_3 => 'The saved juice is turning into solid wealth! Keep up the great work today 🧃';

  @override
  String get savingPraise_4 => 'Saving is a wonderful habit! As your juice grows, so does your peace of mind 🍯';

  @override
  String get savingPraise_5 => 'Awesome job defending your goal without wavering! Let\'s keep the next juice fresh too 🍏';

  @override
  String get savingsLabel => 'Savings';

  @override
  String get savingsCategoryTab => 'Savings categories';

  @override
  String get category_savings_bank_name => 'Savings';

  @override
  String get category_savings_bank_desc => 'Building up a nest egg, bit by bit 🏦';

  @override
  String get category_savings_invest_name => 'Investing/Stocks';

  @override
  String get category_savings_invest_desc => 'Planting fruit seeds for tomorrow 📈';

  @override
  String get category_savings_housing_name => 'Housing subscription savings';

  @override
  String get category_savings_housing_desc => 'The sweet dream of owning a home 🏠';

  @override
  String get category_savings_isa_name => 'ISA/Tax-saving account';

  @override
  String get category_savings_isa_desc => 'A reliable all-purpose tax-saving pouch 🛡️';

  @override
  String get category_savings_emergency_name => 'Emergency fund';

  @override
  String get category_savings_emergency_desc => 'A cushion you can lean on anytime 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return 'Recorded $amount mL in savings for \'$category\'! 🌱';
  }

  @override
  String get statsTotalIncomeTitle => 'Total income';

  @override
  String get statsTotalSavingsTitle => 'Total savings';

  @override
  String get incomeCategoryTitleStats => 'Income by category';

  @override
  String get savingsCategoryTitleStats => 'Savings by category';

  @override
  String get savingsOverviewSectionTitle => '🌱 Savings & Investments';

  @override
  String get savingsThisMonthTotalLabel => 'Total saved & invested this month';

  @override
  String get savingsOverviewEmptyMessage => 'No savings or investments recorded yet';

  @override
  String get scopeThisMonth => 'this month';

  @override
  String get calendarAmountModeCompact => 'Compact';

  @override
  String get calendarAmountModeFull => 'Full amount';

  @override
  String get savingsAllTimeTotalLabel => 'Total saved & invested (all time)';

  @override
  String get currencyWarningNotice => 'Amounts are recalculated using real-time rates, which may cause minor discrepancies in past data. Please change only when necessary!';

  @override
  String get onboardingStep1Title => 'Let\'s set a comfortable spending budget';

  @override
  String get onboardingBudgetLabelDaily => 'Daily budget';

  @override
  String get onboardingBudgetLabelWeekly => 'This week\'s budget';

  @override
  String get onboardingBudgetLabelMonthly => 'This month\'s budget';

  @override
  String get onboardingStep1NextButton => 'Next: Set a long-term goal (1/2)';

  @override
  String get onboardingFooterHint => 'You can always change this later in Settings!';

  @override
  String get onboardingStep2Title => 'Do you have a savings goal for a few years from now?';

  @override
  String get onboardingStep2Subtitle => 'Set a goal and we\'ll smartly calculate your monthly savings and available juice.';

  @override
  String get onboardingDurationLabel => 'Goal duration';

  @override
  String get onboardingGoalAmountLabel => 'Goal amount';

  @override
  String get onboardingCompleteButton => 'Set goal and get started';

  @override
  String get onboardingSkipButton => 'Skip for now';

  @override
  String get commonBack => 'Back';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return 'Juice (mL) is money you can spend! (1$symbol = 1 mL)';
  }

  @override
  String get customDuration => 'Custom';

  @override
  String get yearUnit => 'yr';

  @override
  String get monthUnit => 'mo';

  @override
  String totalDurationLabel(Object months) {
    return 'Total $months months';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return 'Save about $amount a month for $months months and you\'ll reach your goal! 🌱';
  }

  @override
  String get onboardingChooseGoalType => 'Which goal would you like to start with?';

  @override
  String get onboardingShortTermTitle => 'A light short-term budget';

  @override
  String get onboardingShortTermDesc => 'Set how much juice you\'ll sip today, this week, or this month and manage spending lightly.';

  @override
  String get onboardingLongTermTitle => 'A solid mid- to long-term savings goal';

  @override
  String get onboardingLongTermDesc => 'Set the lump-sum goal you want to reach years from now and save toward it smartly.';

  @override
  String get startWithJuice => 'Fill up the juice and start';

  @override
  String get startWithLongPlan => 'Save the plan and start';

  @override
  String get category_income_salary_name => 'Salary';

  @override
  String get category_income_salary_desc => 'The sweet fruit of your hard work 💼';

  @override
  String get category_income_side_name => 'Side Income';

  @override
  String get category_income_side_desc => 'A little bonus honey trickling in 🍯';

  @override
  String get category_income_allowance_name => 'Allowance';

  @override
  String get category_income_allowance_desc => 'A delightful surprise gift 🎁';

  @override
  String get category_income_finance_name => 'Investment Income';

  @override
  String get category_income_finance_desc => 'Money that grew more money 📈';

  @override
  String get category_income_etc_name => 'Other Income';

  @override
  String get category_income_etc_desc => 'Other colorful income 💧';
}
