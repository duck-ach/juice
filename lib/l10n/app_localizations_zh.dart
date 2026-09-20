import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Juice Budget';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get setBudgetTitle => '设置你的果汁预算';

  @override
  String get weeklyBudget => '本周剩余果汁';

  @override
  String get paymentCheckCard => '借记卡';

  @override
  String get paymentCreditCard => '信用卡';

  @override
  String get paymentCash => '现金・转账';

  @override
  String get commonCancel => '取消';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '删除';

  @override
  String get commonEdit => '编辑';

  @override
  String get commonAdd => '添加';

  @override
  String get commonNext => '下一步';

  @override
  String get goalSettingsTitle => '目标设置';

  @override
  String get activePeriodSectionTitle => '当前目标周期';

  @override
  String get activePeriodSectionDescription => '首页量表所依据的周期。请先在下方填写各周期的目标金额,切换时会立即生效。';

  @override
  String get weekStartDayTileTitle => '每周起始日';

  @override
  String get periodTargetSectionTitle => '各周期目标金额';

  @override
  String get periodTargetSectionDescription => '为每个周期分别保存目标金额,并选择你需要的周期。';

  @override
  String get periodTargetAmountSuffix => '目标金额';

  @override
  String get installmentSectionTitle => '分期反映方式';

  @override
  String get installmentSectionDescription => '选择分期付款要如何、何时反映在日历/果汁量表中。';

  @override
  String get recommendedSuffix => '推荐';

  @override
  String get savingsPlanSectionTitle => '中长期储蓄规划';

  @override
  String get savingsPlanSectionDescription => '输入每月收入、固定支出与储蓄目标,计算可用的果汁额度。';

  @override
  String get savingsPlanToggleTitle => '你有中长期储蓄目标吗?';

  @override
  String get autoBudgetSetMessage => '已自动设置每日/每周/每月目标 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 我的果汁计划摘要';

  @override
  String get replanButton => '重新规划';

  @override
  String get applyBudgetButton => '以此预算自动设置果汁';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years年$months个月';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years年';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months个月';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return '目标:$duration内存下 $amount 元';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return '固定支出(无法避免):每月 $amount 元';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return '建议果汁量:每日 $daily mL・每周 $weekly mL・每月 $monthly mL';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get savingsCardSectionTitle => '本周储蓄卡';

  @override
  String get savingsCardSectionDescription => '把达成预算的一周做成卡片并分享。';

  @override
  String get generatingCard => '卡片生成中...';

  @override
  String get shareCardButton => '分享卡片';

  @override
  String get setTargetAmountFirst => '请先设置目标金额';

  @override
  String get menuGoalSettingsTitle => '目标设置';

  @override
  String get menuGoalSettingsSubtitle => '长期储蓄目标、目标周期、各周期目标金额';

  @override
  String get menuThemeSettingsTitle => '主题设置';

  @override
  String get menuThemeSettingsSubtitle => '屏幕模式与果汁主题';

  @override
  String get menuWidgetSettingsTitle => '小组件设置';

  @override
  String get menuWidgetSettingsSubtitle => '隐藏主屏幕小组件上的金额';

  @override
  String get menuCardManagementTitle => '卡片管理';

  @override
  String get menuCardManagementSubtitle => '登记你拥有的卡片,并重新排序';

  @override
  String get menuNotificationSettingsTitle => '通知设置';

  @override
  String get menuNotificationSettingsSubtitle => '开关早晚提醒通知';

  @override
  String get menuBackupSettingsTitle => '数据备份与还原';

  @override
  String get menuBackupSettingsSubtitle => '导出 CSV、导出/导入备份文件';

  @override
  String get menuSecuritySettingsTitle => '安全性';

  @override
  String get menuSecuritySettingsSubtitle => 'PIN 码、生物识别验证';

  @override
  String get menuContactSupportTitle => '联系与反馈';

  @override
  String get menuContactSupportSubtitle => '通过邮件发送您的意见';

  @override
  String get feedbackTitle => '联系与反馈 🍊';

  @override
  String get feedbackTypeBug => '报告问题';

  @override
  String get feedbackTypeFeature => '功能建议';

  @override
  String get feedbackTypeOther => '其他';

  @override
  String get feedbackEmailHint => '您的邮箱(选填,便于回复)';

  @override
  String get feedbackContentHint => '请与我们分享您的意见。';

  @override
  String get feedbackAttachImage => '添加截图';

  @override
  String get feedbackSubmit => '发送';

  @override
  String get feedbackDeviceInfoNotice => '为了更快协助您,将一并发送设备/系统信息。';

  @override
  String get feedbackContentRequired => '请输入内容';

  @override
  String get feedbackMailUnavailable => '无法打开邮件应用，内容已复制。';

  @override
  String get privacyPolicyTitle => '隐私政策';

  @override
  String get menuPrivacyPolicySubtitle => '了解我们如何处理您的个人信息';

  @override
  String get privacyWelcomeTitle => '欢迎使用 Juice Budget!';

  @override
  String get privacyAgreeNotice => 'Juice Budget 是 100% 设备端本地记账应用,绝不会将您的任何财务或个人信息发送到外部服务器。';

  @override
  String get viewPrivacyPolicy => '查看完整隐私政策';

  @override
  String get agreeAndStart => '同意并开始使用';

  @override
  String get appNameShort => 'Juice';

  @override
  String get savingsCardSuccessMessage => '这一周的\n果汁保持新鲜!';

  @override
  String get savingsCardOverMessage => '这一周的果汁\n洒出了一些';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return '已花费 $budget 中的 $spent';
  }

  @override
  String get savingsCardSuccessStamp => '成功';

  @override
  String get savingsCardOverStamp => '再加油';

  @override
  String get pinSetupTitle => '设置密码';

  @override
  String get biometricUnlockReason => '进行验证以解锁';

  @override
  String get pinConfirmTitle => '确认密码';

  @override
  String get pinConfirmCurrentTitle => '确认当前密码';

  @override
  String get pinSetupNewTitle => '设置新密码';

  @override
  String get pinChangedMessage => '密码已修改';

  @override
  String get biometricLinkTitle => '关联生物识别验证';

  @override
  String get biometricLinkConfirm => '要关联生物识别验证吗?';

  @override
  String get biometricLinkAction => '关联';

  @override
  String get biometricLinkReason => '进行验证以关联生物识别';

  @override
  String get biometricUnavailableMessage => '无法使用生物识别验证';

  @override
  String get securityTitle => '安全性';

  @override
  String get securityDescription => '以 PIN 码或生物识别锁定应用。';

  @override
  String get appLockTitle => '应用锁定';

  @override
  String get appLockDescription => '以 4 位数 PIN 码保护应用访问权限。';

  @override
  String get changePasswordTitle => '修改密码';

  @override
  String get biometricUseTitle => '使用生物识别';

  @override
  String get biometricUseDescription => '以 Face ID/指纹更快解锁。';

  @override
  String get csvShareText => '果汁支出记录';

  @override
  String get backupShareText => '果汁数据备份';

  @override
  String backupFailedMessage(Object error) {
    return '备份失败:$error';
  }

  @override
  String get restoreDataTitle => '还原数据';

  @override
  String get restoreDataConfirm => '现有数据将被备份文件替换,是否继续?';

  @override
  String get restoreAction => '还原';

  @override
  String get restoreSuccessMessage => '还原完成';

  @override
  String get restoreFailedMessage => '还原失败,请确认这是有效的 Juice 备份文件';

  @override
  String get backupSettingsTitle => '数据备份与还原';

  @override
  String get exportExpensesTitle => '导出支出记录';

  @override
  String get exportExpensesDescription => '分享包含日期、分类、金额、固定支出标记与备注的 CSV 文件。';

  @override
  String get exportingCsv => '导出中...';

  @override
  String get exportCsvButton => '导出为 CSV';

  @override
  String get backupRestoreTitle => '数据备份・还原';

  @override
  String get backupRestoreDescription => '将支出、收入、分类与预算设置备份与还原为单一文件。';

  @override
  String get backupDataTitle => '备份数据';

  @override
  String get backupDataDescription => '通过分享功能保存至文件、邮件等。';

  @override
  String get restoreDataTileTitle => '还原数据';

  @override
  String get restoreDataTileDescription => '选择备份文件以覆盖现有数据。';

  @override
  String get categoryDefaultDescription => '我的专属果汁配方';

  @override
  String get categoryDeleteTitle => '删除分类';

  @override
  String categoryDeleteConfirm(Object name) {
    return '删除「$name」分类吗?\n已记录的支出将会保留。';
  }

  @override
  String get categoryInUseMessage => '部分记录使用此分类,请先将其移至其他分类后再删除。';

  @override
  String get categoryEditTitle => '编辑分类';

  @override
  String get categoryAddTitle => '添加分类';

  @override
  String get categoryNameLabel => '分类名称';

  @override
  String get categoryDescriptionLabel => '简短说明';

  @override
  String get colorLabel => '颜色';

  @override
  String get iconLabel => '图标';

  @override
  String get categoryManageTitle => '分类管理';

  @override
  String get expenseCategoryTab => '支出分类';

  @override
  String get incomeCategoryTab => '收入分类';

  @override
  String get defaultCategoryUndeletable => '默认分类无法删除';

  @override
  String get cardDeleteTitle => '删除卡片';

  @override
  String cardDeleteConfirm(Object name) {
    return '删除「$name」卡片吗?\n已记录的支出将会保留。';
  }

  @override
  String get cardEditTitle => '编辑卡片';

  @override
  String get cardAddTitle => '添加卡片';

  @override
  String get cardNameLabel => '卡片名称';

  @override
  String get cardTypeLabel => '卡片类型';

  @override
  String get cardManagementTitle => '卡片管理';

  @override
  String get defaultCardUndeletable => '默认卡片无法删除';

  @override
  String get cardTypeCorporate => '公司/业务用';

  @override
  String get cardTypeCorporateExcluded => '公司用(支出)・不计入果汁';

  @override
  String get corporateExpenseNotice => '🏢 公司/业务支出无需选择分类,将自动从个人支出中排除。';

  @override
  String get corporateBadgeLabel => '🏢 公司/业务用・不计入个人支出';

  @override
  String get corporateCardLabel => '公司/业务卡';

  @override
  String get corporateMemoRequired => '公司/业务支出请输入备注(用途)';

  @override
  String get juiceThemeLabel => '果汁主题';

  @override
  String get themeSettingsTitle => '主题设置';

  @override
  String get screenModeLabel => '屏幕模式';

  @override
  String get themeModeSystem => '系统';

  @override
  String get themeModeLight => '浅色';

  @override
  String get themeModeDark => '深色';

  @override
  String get juiceThemeDescription => '选择随剩余预算变化的果汁颜色,同时也会成为应用的主题色。';

  @override
  String get themeOrange => '橙子';

  @override
  String get themeStrawberry => '草莓';

  @override
  String get themeApple => '苹果';

  @override
  String get themeGrape => '葡萄';

  @override
  String get themeBlueberry => '蓝莓';

  @override
  String get themeMulberry => '桑葚';

  @override
  String get themeRandom => '随机(每次打开应用时)';

  @override
  String get widgetSettingsTitle => '小组件设置';

  @override
  String get homeScreenWidgetTitle => '主屏幕小组件';

  @override
  String get homeScreenWidgetDescription => '可以在主屏幕添加果汁量表小组件与快速记账小组件。';

  @override
  String get hideWidgetAmountTitle => '隐藏小组件金额';

  @override
  String get hideWidgetAmountDescription => '以 ***mL 及剩余百分比代替实际金额显示。';

  @override
  String get notificationSettingsTitle => '通知设置';

  @override
  String get notificationScheduleDescription => '我们会于每天早上 7 点与晚上 8 点发送提醒,鼓励你记账。';

  @override
  String get receiveNotificationsTitle => '接收果汁通知';

  @override
  String get receiveNotificationsDescription => '若你许久未打开应用,我们也会提醒你回来看看。';

  @override
  String get navHome => '首页';

  @override
  String get navCalendar => '日历';

  @override
  String get navAssets => '资产';

  @override
  String get navStats => '统计';

  @override
  String get navSettings => '设置';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 今日分期金额:$amount mL';
  }

  @override
  String get filterVariableOnlyLong => '仅显示变动支出';

  @override
  String get filterAllLong => '显示全部';

  @override
  String noGoalTitle(Object period) {
    return '尚未设置$period目标金额';
  }

  @override
  String noGoalDescription(Object period) {
    return '请在目标设置中填写$period目标金额。';
  }

  @override
  String get goToGoalSettings => '前往目标设置';

  @override
  String get noExpensesYet => '尚未记录任何支出';

  @override
  String remainingJuiceLabel(Object period) {
    return '$period剩余果汁';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '已使用 $percent%';
  }

  @override
  String get overBudgetMessage1 => '太可惜了!下周留点果汁吧 🍊';

  @override
  String get overBudgetMessage2 => '果汁罐空了!这周先喘口气吧 🥲';

  @override
  String get overBudgetMessage3 => '果汁洒出来了!下周再重新装满吧 🧃';

  @override
  String get overBudgetMessage4 => '只剩最后一滴!下周慢慢品尝吧 ✨';

  @override
  String get incomeFallbackName => '收入';

  @override
  String get unknownCategoryName => '未知';

  @override
  String get fixedExpenseLabel => '固定';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return '分期 $index/$months';
  }

  @override
  String get deletedMessage => '已删除';

  @override
  String get undoAction => '撤销';

  @override
  String get amountAndCategoryRequired => '请确认金额与分类';

  @override
  String get expenseLabel => '支出';

  @override
  String get incomeLabel => '收入';

  @override
  String editTypeTitle(Object type) {
    return '编辑$type';
  }

  @override
  String addTypeTitle(Object type) {
    return '添加$type';
  }

  @override
  String deleteTypeTitle(Object type) {
    return '删除$type';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return '要删除这条$type记录吗?';
  }

  @override
  String get cardSelectLabel => '选择卡片';

  @override
  String installmentEditNotice(Object index, Object months) {
    return '分期 $index/$months — 其他分期不会一并变更';
  }

  @override
  String get lumpSumLabel => '一次付清';

  @override
  String monthsPresetLabel(Object months) {
    return '$months期';
  }

  @override
  String get customInputLabel => '自定义';

  @override
  String get monthsCountHint => '期数(2-24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return '将以每月 $amount mL 反映,共 $months 期';
  }

  @override
  String get memoHint => '备注(选填)';

  @override
  String get excludeAsFixedTitle => '排除为固定支出';

  @override
  String get excludeAsFixedSubtitle => '房租、保险等 — 不计入果汁量表';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return '已收到「$category」收入 $amount mL!💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return '已记录「$category」支出 $amount mL!🍊';
  }

  @override
  String get calendarTitle => '日历';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return '本月:支出 $expense・收入 $income';
  }

  @override
  String get filterVariableOnlyShort => '仅变动';

  @override
  String get filterAllShort => '全部';

  @override
  String get noExpenseTodayMessage => '神清气爽的无支出日!🍊';

  @override
  String get assetsTitle => '资产';

  @override
  String get cumulativeNetWorthLabel => '累计净资产';

  @override
  String get cumulativeNetWorthDescription => '目前为止所有收入减去支出的总和。';

  @override
  String get scopeThisYear => '今年';

  @override
  String get scopeLast5Years => '近5年';

  @override
  String totalIncomeLabel(Object scope) {
    return '总收入($scope)';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return '总支出($scope)';
  }

  @override
  String get netChangeTrendTitle => '净额变化趋势';

  @override
  String get netChangeTrendDescription => '净额变化=收入减支出。绿色为盈余,红色为赤字。';

  @override
  String get statsTitle => '统计';

  @override
  String get filterFixedIncluded => '包含固定支出';

  @override
  String get totalExpenseTitle => '总支出';

  @override
  String get categorySpendingTitle => '分类消费';

  @override
  String get paymentMethodSpendingTitle => '支付方式消费';

  @override
  String get statsPeriodThisWeek => '本周';

  @override
  String get statsPeriodThisMonth => '本月';

  @override
  String get statsPeriodLast4Weeks => '近4周';

  @override
  String get statsPeriodMonthly => '按月';

  @override
  String get statsPeriodYearly => '按年';

  @override
  String get cardStatsViewSummary => '总览';

  @override
  String get cardStatsViewByCard => '按卡片明细';

  @override
  String get noExpensesInPeriod => '此期间尚无记录';

  @override
  String get categoryDetailThisMonthTotal => '本月合计';

  @override
  String get categoryDetailMonthlyTrendTitle => '月度趋势';

  @override
  String get categoryDetailExpenseListTitle => '详细明细';

  @override
  String get categoryDetailEmptyMessage => '尚无记录';

  @override
  String monthlyTotalLabel(Object month) {
    return '$month合计';
  }

  @override
  String get categoryDetailEmptyMonthMessage => '本月没有支出 🍊';

  @override
  String get installmentIncludedSuffix => '含分期';

  @override
  String get cardUnassigned => '未指定卡片';

  @override
  String get fillJuiceButton => '装满果汁';

  @override
  String get finishWizardButton => '以此配方开始使用果汁';

  @override
  String get incomeStepQuestion => '每月会有多少果汁\n(收入)入账呢?';

  @override
  String get incomeStepSubtitle => '请输入实际入账的税后金额。';

  @override
  String get wonSuffixSpaced => ' 元';

  @override
  String get goalStepQuestion => '想存多久、存多少呢?';

  @override
  String get yearsFieldLabel => '年';

  @override
  String get monthsFieldLabel => '月';

  @override
  String get goalAmountFieldLabel => '目标储蓄金额';

  @override
  String get wonUnit => '元';

  @override
  String get fixedExpenseStepQuestion => '每月有固定支出吗?';

  @override
  String get fixedExpenseStepSubtitle => '房租、保险、电话费等 — 不计入果汁罐的费用。';

  @override
  String get itemNameHint => '项目名称';

  @override
  String get addItemButton => '添加项目';

  @override
  String get resultStepQuestion => '你的专属果汁计划\n已经完成!';

  @override
  String get resultNegativeMessage => '固定支出与储蓄超过收入了 😥 请返回调整目标或期限。';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return '每月收入 $income 元 − 固定支出 $fixed 元 − 每月储蓄后,剩下:';
  }

  @override
  String get resultWeeklyPrefix => '本周:';

  @override
  String get resultWeeklySuffix => ' 可以享用的果汁!🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '$daily mL/日・$monthly mL/月';
  }

  @override
  String get periodDaily => '今天';

  @override
  String get periodWeekly => '本周';

  @override
  String get periodMonthly => '本月';

  @override
  String get periodSettingDaily => '每日';

  @override
  String get periodSettingWeekly => '每周';

  @override
  String get periodSettingMonthly => '每月';

  @override
  String get weekStartMonday => '周一开始(周一~周日)';

  @override
  String get weekStartSunday => '周日开始(周日~周六)';

  @override
  String get installmentModeMonthlyLabel => '次月一次入账';

  @override
  String get installmentModeDailyLabel => '每日平均入账';

  @override
  String get installmentModeMonthlyDescription => '如同真实信用卡账单,分期金额将于每月 1 日一次记录为支出。';

  @override
  String get installmentModeDailyDescription => '当月分期金额将按天数平均分摊,每天从果汁量表中少量扣除。';

  @override
  String get splashOrangeSubText => '清爽装满的本周预算';

  @override
  String get splashGreenAppleSubText => '细心消费的清新习惯';

  @override
  String get splashGrapeSubText => '甜蜜守护你的界限';

  @override
  String get splashStrawberrySubText => '充实美好的一天';

  @override
  String get confirmNewPinPrompt => '请再次输入新密码';

  @override
  String get enterCurrentPinPrompt => '请输入当前密码';

  @override
  String get enterNewPinPrompt => '请输入新密码';

  @override
  String get enterPinPrompt => '请输入密码';

  @override
  String get juiceLockTitle => '果汁已锁定';

  @override
  String get pinConfirmMismatchError => '密码不一致,请再试一次';

  @override
  String get pinMismatchError => '密码不正确';

  @override
  String get shareCardText => '我的果汁储蓄卡';

  @override
  String get unlockJuiceReason => '进行验证以解锁果汁';

  @override
  String get unlockWithBiometrics => '以生物识别解锁';

  @override
  String yearsPresetLabel(Object years) {
    return '$years年';
  }

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsCurrency => '基准货币设置';

  @override
  String get currencySelectTitle => '选择你的货币';

  @override
  String get commonDone => '完成';

  @override
  String get currencyNameKrw => '韩元 (₩)';

  @override
  String get currencyNameUsd => '美元 (\$)';

  @override
  String get currencyNameJpy => '日元 (¥)';

  @override
  String get currencyNameEur => '欧元 (€)';

  @override
  String get currencyNameVnd => '越南盾 (₫)';

  @override
  String get currencyNameTwd => '新台币 (NT\$)';

  @override
  String get currencyNameCny => '人民币 (¥)';

  @override
  String get currencyNameBrl => '巴西雷亚尔 (R\$)';

  @override
  String get foreignCurrencyPickerTitle => '选择付款货币';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted(今日汇率:$rate)';
  }

  @override
  String get exchangeRateLoadingMessage => '正在获取汇率...';

  @override
  String get exchangeRateFailedMessage => '无法获取汇率,请手动输入或使用最后已知汇率。';

  @override
  String get manualRateEntryToggle => '手动输入汇率';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => '重试';

  @override
  String get commonCopy => '复制';

  @override
  String linkOpenFailedMessage(Object target) {
    return '找不到可打开的应用:$target';
  }

  @override
  String get commonConfirm => '确认';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return '要将基准货币变更为 $toCode 吗?先前记录的所有金额将按当前汇率自动换算。';
  }

  @override
  String get currencyMigrationLoadingMessage => '正在将现有记录换算为新货币... 🍊';

  @override
  String get currencyMigrationFailedMessage => '无法获取汇率,因此现有金额维持不变';

  @override
  String get category_food_name => '餐饮';

  @override
  String get category_food_desc => '今天也充满元气的美味能量 🍱';

  @override
  String get category_cafe_name => '咖啡点心';

  @override
  String get category_cafe_desc => '甜蜜的一勺幸福 ☕️';

  @override
  String get category_transport_name => '交通';

  @override
  String get category_transport_desc => '顺畅抵达目的地 🚌';

  @override
  String get category_shopping_name => '购物';

  @override
  String get category_shopping_desc => '犒赏自己的喜悦 🛍️';

  @override
  String get category_culture_name => '休闲娱乐';

  @override
  String get category_culture_desc => '为心灵充电的甜美时光 🎬';

  @override
  String get category_life_name => '居家生活';

  @override
  String get category_life_desc => '日常舒适的清新一刻 🧼';

  @override
  String get category_etc_name => '其他';

  @override
  String get category_etc_desc => '多彩的日常花费 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return '已存下果汁 +$amount mL';
  }

  @override
  String get savingHistoryTitle => '储蓄记录';

  @override
  String get savingHistoryEmpty => '尚无已结束的周期。\n完成你的第一个周期吧!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '已存下 +$amount mL!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return '超支了 $amount mL';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return '目标 $target / 花费 $spent';
  }

  @override
  String get savingOptionTitle => '剩余果汁如何处理';

  @override
  String get savingOptionDescription => '选择周期结束时,未使用的预算要如何处理。';

  @override
  String get savingOptionRollover => '结转至下个周期';

  @override
  String get savingOptionSavings => '存入紧急备用金';

  @override
  String get savedJuiceStoreTooltip => '果汁储藏室';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return '已存下果汁:$amount mL($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return '包含上个周期结转的 +$amount mL';
  }

  @override
  String get savingsAssetCardTitle => '通过储蓄守护的资产';

  @override
  String get savingsAssetCardDescription => '以储蓄选项结束的周期的剩余果汁总和。';

  @override
  String get savingPraise_1 => '已经存了这么多!太厉害了!!离目标越来越近了 🍊';

  @override
  String get savingPraise_2 => '你守护了珍贵的果汁!你的储蓄习惯闪闪发光 ✨';

  @override
  String get savingPraise_3 => '存下的果汁正化为扎实的财富!今天也继续加油吧 🧃';

  @override
  String get savingPraise_4 => '储蓄是个美好的习惯!果汁越存越多,心也越来越安稳 🍯';

  @override
  String get savingPraise_5 => '坚定守护目标,你做得太棒了!下一杯果汁也一起保持新鲜吧 🍏';

  @override
  String get savingsLabel => '储蓄';

  @override
  String get savingsCategoryTab => '储蓄分类';

  @override
  String get category_savings_bank_name => '储蓄';

  @override
  String get category_savings_bank_desc => '一点一滴积累起来的家底 🏦';

  @override
  String get category_savings_invest_name => '投资/股票';

  @override
  String get category_savings_invest_desc => '为明天种下果实的种子 📈';

  @override
  String get category_savings_housing_name => '购房储蓄';

  @override
  String get category_savings_housing_desc => '拥有自己家的甜美梦想 🏠';

  @override
  String get category_savings_isa_name => 'ISA/节税账户';

  @override
  String get category_savings_isa_desc => '可靠的万能节税小袋 🛡️';

  @override
  String get category_savings_emergency_name => '紧急备用金';

  @override
  String get category_savings_emergency_desc => '随时都能依靠的缓冲垫 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return '已为「$category」记录储蓄 $amount mL!🌱';
  }

  @override
  String get statsTotalIncomeTitle => '总收入';

  @override
  String get statsTotalSavingsTitle => '总储蓄';

  @override
  String get incomeCategoryTitleStats => '分类收入';

  @override
  String get savingsCategoryTitleStats => '分类储蓄';

  @override
  String get savingsOverviewSectionTitle => '🌱 储蓄与投资';

  @override
  String get savingsThisMonthTotalLabel => '本月储蓄与投资总额';

  @override
  String get savingsOverviewEmptyMessage => '尚无储蓄或投资记录';

  @override
  String get scopeThisMonth => '本月';

  @override
  String get calendarAmountModeCompact => '精简';

  @override
  String get calendarAmountModeFull => '完整金额';

  @override
  String get savingsAllTimeTotalLabel => '累计储蓄与投资总额';

  @override
  String get currencyWarningNotice => '金额将以实时汇率重新换算,可能导致历史数据出现细微差异,请务必在必要时再变更!';

  @override
  String get onboardingStep1Title => '来设置一个轻松自在的消费预算吧';

  @override
  String get onboardingBudgetLabelDaily => '每日预算';

  @override
  String get onboardingBudgetLabelWeekly => '本周预算';

  @override
  String get onboardingBudgetLabelMonthly => '本月预算';

  @override
  String get onboardingStep1NextButton => '下一步:设置长期目标(1/2)';

  @override
  String get onboardingFooterHint => '之后随时都能在设置中变更!';

  @override
  String get onboardingStep2Title => '你有几年后想达成的储蓄目标吗?';

  @override
  String get onboardingStep2Subtitle => '设置目标后,我们会智能地计算你每月的储蓄与可用果汁。';

  @override
  String get onboardingDurationLabel => '目标期限';

  @override
  String get onboardingGoalAmountLabel => '目标金额';

  @override
  String get onboardingCompleteButton => '设置目标并开始使用';

  @override
  String get onboardingSkipButton => '暂时跳过';

  @override
  String get commonBack => '返回';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return '果汁(mL)就是你能花的钱!(1$symbol = 1 mL)';
  }

  @override
  String get customDuration => '自定义';

  @override
  String get yearUnit => '年';

  @override
  String get monthUnit => '月';

  @override
  String totalDurationLabel(Object months) {
    return '共 $months 个月';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return '每月存约 $amount,持续 $months 个月即可达成目标!🌱';
  }

  @override
  String get onboardingChooseGoalType => '想从哪个目标开始呢?';

  @override
  String get onboardingShortTermTitle => '轻松的短期预算';

  @override
  String get onboardingShortTermDesc => '设置今天、本周或本月要花多少果汁,轻松管理支出。';

  @override
  String get onboardingLongTermTitle => '扎实的中长期储蓄目标';

  @override
  String get onboardingLongTermDesc => '设置几年后想达成的总目标,并智能地储蓄达成。';

  @override
  String get startWithJuice => '装满果汁并开始';

  @override
  String get startWithLongPlan => '保存计划并开始';

  @override
  String get category_income_salary_name => '工资';

  @override
  String get category_income_salary_desc => '辛勤努力换来的甜美果实 💼';

  @override
  String get category_income_side_name => '副业收入';

  @override
  String get category_income_side_desc => '悄悄流入的一点蜂蜜奖励 🍯';

  @override
  String get category_income_allowance_name => '零花钱';

  @override
  String get category_income_allowance_desc => '令人惊喜的美好礼物 🎁';

  @override
  String get category_income_finance_name => '投资理财';

  @override
  String get category_income_finance_desc => '让钱生钱的成果 📈';

  @override
  String get category_income_etc_name => '其他收入';

  @override
  String get category_income_etc_desc => '其他多彩的收入 💧';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans(): super('zh_Hans');

  @override
  String get appTitle => 'Juice Budget';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get setBudgetTitle => '设置你的果汁预算';

  @override
  String get weeklyBudget => '本周剩余果汁';

  @override
  String get paymentCheckCard => '借记卡';

  @override
  String get paymentCreditCard => '信用卡';

  @override
  String get paymentCash => '现金・转账';

  @override
  String get commonCancel => '取消';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '删除';

  @override
  String get commonEdit => '编辑';

  @override
  String get commonAdd => '添加';

  @override
  String get commonNext => '下一步';

  @override
  String get goalSettingsTitle => '目标设置';

  @override
  String get activePeriodSectionTitle => '当前目标周期';

  @override
  String get activePeriodSectionDescription => '首页量表所依据的周期。请先在下方填写各周期的目标金额,切换时会立即生效。';

  @override
  String get weekStartDayTileTitle => '每周起始日';

  @override
  String get periodTargetSectionTitle => '各周期目标金额';

  @override
  String get periodTargetSectionDescription => '为每个周期分别保存目标金额,并选择你需要的周期。';

  @override
  String get periodTargetAmountSuffix => '目标金额';

  @override
  String get installmentSectionTitle => '分期反映方式';

  @override
  String get installmentSectionDescription => '选择分期付款要如何、何时反映在日历/果汁量表中。';

  @override
  String get recommendedSuffix => '推荐';

  @override
  String get savingsPlanSectionTitle => '中长期储蓄规划';

  @override
  String get savingsPlanSectionDescription => '输入每月收入、固定支出与储蓄目标,计算可用的果汁额度。';

  @override
  String get savingsPlanToggleTitle => '你有中长期储蓄目标吗?';

  @override
  String get autoBudgetSetMessage => '已自动设置每日/每周/每月目标 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 我的果汁计划摘要';

  @override
  String get replanButton => '重新规划';

  @override
  String get applyBudgetButton => '以此预算自动设置果汁';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years年$months个月';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years年';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months个月';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return '目标:$duration内存下 $amount 元';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return '固定支出(无法避免):每月 $amount 元';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return '建议果汁量:每日 $daily mL・每周 $weekly mL・每月 $monthly mL';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get savingsCardSectionTitle => '本周储蓄卡';

  @override
  String get savingsCardSectionDescription => '把达成预算的一周做成卡片并分享。';

  @override
  String get generatingCard => '卡片生成中...';

  @override
  String get shareCardButton => '分享卡片';

  @override
  String get setTargetAmountFirst => '请先设置目标金额';

  @override
  String get menuGoalSettingsTitle => '目标设置';

  @override
  String get menuGoalSettingsSubtitle => '长期储蓄目标、目标周期、各周期目标金额';

  @override
  String get menuThemeSettingsTitle => '主题设置';

  @override
  String get menuThemeSettingsSubtitle => '屏幕模式与果汁主题';

  @override
  String get menuWidgetSettingsTitle => '小组件设置';

  @override
  String get menuWidgetSettingsSubtitle => '隐藏主屏幕小组件上的金额';

  @override
  String get menuCardManagementTitle => '卡片管理';

  @override
  String get menuCardManagementSubtitle => '登记你拥有的卡片,并重新排序';

  @override
  String get menuNotificationSettingsTitle => '通知设置';

  @override
  String get menuNotificationSettingsSubtitle => '开关早晚提醒通知';

  @override
  String get menuBackupSettingsTitle => '数据备份与还原';

  @override
  String get menuBackupSettingsSubtitle => '导出 CSV、导出/导入备份文件';

  @override
  String get menuSecuritySettingsTitle => '安全性';

  @override
  String get menuSecuritySettingsSubtitle => 'PIN 码、生物识别验证';

  @override
  String get menuContactSupportTitle => '联系与反馈';

  @override
  String get menuContactSupportSubtitle => '通过邮件发送您的意见';

  @override
  String get feedbackTitle => '联系与反馈 🍊';

  @override
  String get feedbackTypeBug => '报告问题';

  @override
  String get feedbackTypeFeature => '功能建议';

  @override
  String get feedbackTypeOther => '其他';

  @override
  String get feedbackEmailHint => '您的邮箱(选填,便于回复)';

  @override
  String get feedbackContentHint => '请与我们分享您的意见。';

  @override
  String get feedbackAttachImage => '添加截图';

  @override
  String get feedbackSubmit => '发送';

  @override
  String get feedbackDeviceInfoNotice => '为了更快协助您,将一并发送设备/系统信息。';

  @override
  String get feedbackContentRequired => '请输入内容';

  @override
  String get feedbackMailUnavailable => '无法打开邮件应用，内容已复制。';

  @override
  String get privacyPolicyTitle => '隐私政策';

  @override
  String get menuPrivacyPolicySubtitle => '了解我们如何处理您的个人信息';

  @override
  String get privacyWelcomeTitle => '欢迎使用 Juice Budget!';

  @override
  String get privacyAgreeNotice => 'Juice Budget 是 100% 设备端本地记账应用,绝不会将您的任何财务或个人信息发送到外部服务器。';

  @override
  String get viewPrivacyPolicy => '查看完整隐私政策';

  @override
  String get agreeAndStart => '同意并开始使用';

  @override
  String get appNameShort => 'Juice';

  @override
  String get savingsCardSuccessMessage => '这一周的\n果汁保持新鲜!';

  @override
  String get savingsCardOverMessage => '这一周的果汁\n洒出了一些';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return '已花费 $budget 中的 $spent';
  }

  @override
  String get savingsCardSuccessStamp => '成功';

  @override
  String get savingsCardOverStamp => '再加油';

  @override
  String get pinSetupTitle => '设置密码';

  @override
  String get biometricUnlockReason => '进行验证以解锁';

  @override
  String get pinConfirmTitle => '确认密码';

  @override
  String get pinConfirmCurrentTitle => '确认当前密码';

  @override
  String get pinSetupNewTitle => '设置新密码';

  @override
  String get pinChangedMessage => '密码已修改';

  @override
  String get biometricLinkTitle => '关联生物识别验证';

  @override
  String get biometricLinkConfirm => '要关联生物识别验证吗?';

  @override
  String get biometricLinkAction => '关联';

  @override
  String get biometricLinkReason => '进行验证以关联生物识别';

  @override
  String get biometricUnavailableMessage => '无法使用生物识别验证';

  @override
  String get securityTitle => '安全性';

  @override
  String get securityDescription => '以 PIN 码或生物识别锁定应用。';

  @override
  String get appLockTitle => '应用锁定';

  @override
  String get appLockDescription => '以 4 位数 PIN 码保护应用访问权限。';

  @override
  String get changePasswordTitle => '修改密码';

  @override
  String get biometricUseTitle => '使用生物识别';

  @override
  String get biometricUseDescription => '以 Face ID/指纹更快解锁。';

  @override
  String get csvShareText => '果汁支出记录';

  @override
  String get backupShareText => '果汁数据备份';

  @override
  String backupFailedMessage(Object error) {
    return '备份失败:$error';
  }

  @override
  String get restoreDataTitle => '还原数据';

  @override
  String get restoreDataConfirm => '现有数据将被备份文件替换,是否继续?';

  @override
  String get restoreAction => '还原';

  @override
  String get restoreSuccessMessage => '还原完成';

  @override
  String get restoreFailedMessage => '还原失败,请确认这是有效的 Juice 备份文件';

  @override
  String get backupSettingsTitle => '数据备份与还原';

  @override
  String get exportExpensesTitle => '导出支出记录';

  @override
  String get exportExpensesDescription => '分享包含日期、分类、金额、固定支出标记与备注的 CSV 文件。';

  @override
  String get exportingCsv => '导出中...';

  @override
  String get exportCsvButton => '导出为 CSV';

  @override
  String get backupRestoreTitle => '数据备份・还原';

  @override
  String get backupRestoreDescription => '将支出、收入、分类与预算设置备份与还原为单一文件。';

  @override
  String get backupDataTitle => '备份数据';

  @override
  String get backupDataDescription => '通过分享功能保存至文件、邮件等。';

  @override
  String get restoreDataTileTitle => '还原数据';

  @override
  String get restoreDataTileDescription => '选择备份文件以覆盖现有数据。';

  @override
  String get categoryDefaultDescription => '我的专属果汁配方';

  @override
  String get categoryDeleteTitle => '删除分类';

  @override
  String categoryDeleteConfirm(Object name) {
    return '删除「$name」分类吗?\n已记录的支出将会保留。';
  }

  @override
  String get categoryInUseMessage => '部分记录使用此分类,请先将其移至其他分类后再删除。';

  @override
  String get categoryEditTitle => '编辑分类';

  @override
  String get categoryAddTitle => '添加分类';

  @override
  String get categoryNameLabel => '分类名称';

  @override
  String get categoryDescriptionLabel => '简短说明';

  @override
  String get colorLabel => '颜色';

  @override
  String get iconLabel => '图标';

  @override
  String get categoryManageTitle => '分类管理';

  @override
  String get expenseCategoryTab => '支出分类';

  @override
  String get incomeCategoryTab => '收入分类';

  @override
  String get defaultCategoryUndeletable => '默认分类无法删除';

  @override
  String get cardDeleteTitle => '删除卡片';

  @override
  String cardDeleteConfirm(Object name) {
    return '删除「$name」卡片吗?\n已记录的支出将会保留。';
  }

  @override
  String get cardEditTitle => '编辑卡片';

  @override
  String get cardAddTitle => '添加卡片';

  @override
  String get cardNameLabel => '卡片名称';

  @override
  String get cardTypeLabel => '卡片类型';

  @override
  String get cardManagementTitle => '卡片管理';

  @override
  String get defaultCardUndeletable => '默认卡片无法删除';

  @override
  String get cardTypeCorporate => '公司/业务用';

  @override
  String get cardTypeCorporateExcluded => '公司用(支出)・不计入果汁';

  @override
  String get corporateExpenseNotice => '🏢 公司/业务支出无需选择分类,将自动从个人支出中排除。';

  @override
  String get corporateBadgeLabel => '🏢 公司/业务用・不计入个人支出';

  @override
  String get corporateCardLabel => '公司/业务卡';

  @override
  String get corporateMemoRequired => '公司/业务支出请输入备注(用途)';

  @override
  String get juiceThemeLabel => '果汁主题';

  @override
  String get themeSettingsTitle => '主题设置';

  @override
  String get screenModeLabel => '屏幕模式';

  @override
  String get themeModeSystem => '系统';

  @override
  String get themeModeLight => '浅色';

  @override
  String get themeModeDark => '深色';

  @override
  String get juiceThemeDescription => '选择随剩余预算变化的果汁颜色,同时也会成为应用的主题色。';

  @override
  String get themeOrange => '橙子';

  @override
  String get themeStrawberry => '草莓';

  @override
  String get themeApple => '苹果';

  @override
  String get themeGrape => '葡萄';

  @override
  String get themeBlueberry => '蓝莓';

  @override
  String get themeMulberry => '桑葚';

  @override
  String get themeRandom => '随机(每次打开应用时)';

  @override
  String get widgetSettingsTitle => '小组件设置';

  @override
  String get homeScreenWidgetTitle => '主屏幕小组件';

  @override
  String get homeScreenWidgetDescription => '可以在主屏幕添加果汁量表小组件与快速记账小组件。';

  @override
  String get hideWidgetAmountTitle => '隐藏小组件金额';

  @override
  String get hideWidgetAmountDescription => '以 ***mL 及剩余百分比代替实际金额显示。';

  @override
  String get notificationSettingsTitle => '通知设置';

  @override
  String get notificationScheduleDescription => '我们会于每天早上 7 点与晚上 8 点发送提醒,鼓励你记账。';

  @override
  String get receiveNotificationsTitle => '接收果汁通知';

  @override
  String get receiveNotificationsDescription => '若你许久未打开应用,我们也会提醒你回来看看。';

  @override
  String get navHome => '首页';

  @override
  String get navCalendar => '日历';

  @override
  String get navAssets => '资产';

  @override
  String get navStats => '统计';

  @override
  String get navSettings => '设置';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 今日分期金额:$amount mL';
  }

  @override
  String get filterVariableOnlyLong => '仅显示变动支出';

  @override
  String get filterAllLong => '显示全部';

  @override
  String noGoalTitle(Object period) {
    return '尚未设置$period目标金额';
  }

  @override
  String noGoalDescription(Object period) {
    return '请在目标设置中填写$period目标金额。';
  }

  @override
  String get goToGoalSettings => '前往目标设置';

  @override
  String get noExpensesYet => '尚未记录任何支出';

  @override
  String remainingJuiceLabel(Object period) {
    return '$period剩余果汁';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '已使用 $percent%';
  }

  @override
  String get overBudgetMessage1 => '太可惜了!下周留点果汁吧 🍊';

  @override
  String get overBudgetMessage2 => '果汁罐空了!这周先喘口气吧 🥲';

  @override
  String get overBudgetMessage3 => '果汁洒出来了!下周再重新装满吧 🧃';

  @override
  String get overBudgetMessage4 => '只剩最后一滴!下周慢慢品尝吧 ✨';

  @override
  String get incomeFallbackName => '收入';

  @override
  String get unknownCategoryName => '未知';

  @override
  String get fixedExpenseLabel => '固定';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return '分期 $index/$months';
  }

  @override
  String get deletedMessage => '已删除';

  @override
  String get undoAction => '撤销';

  @override
  String get amountAndCategoryRequired => '请确认金额与分类';

  @override
  String get expenseLabel => '支出';

  @override
  String get incomeLabel => '收入';

  @override
  String editTypeTitle(Object type) {
    return '编辑$type';
  }

  @override
  String addTypeTitle(Object type) {
    return '添加$type';
  }

  @override
  String deleteTypeTitle(Object type) {
    return '删除$type';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return '要删除这条$type记录吗?';
  }

  @override
  String get cardSelectLabel => '选择卡片';

  @override
  String installmentEditNotice(Object index, Object months) {
    return '分期 $index/$months — 其他分期不会一并变更';
  }

  @override
  String get lumpSumLabel => '一次付清';

  @override
  String monthsPresetLabel(Object months) {
    return '$months期';
  }

  @override
  String get customInputLabel => '自定义';

  @override
  String get monthsCountHint => '期数(2-24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return '将以每月 $amount mL 反映,共 $months 期';
  }

  @override
  String get memoHint => '备注(选填)';

  @override
  String get excludeAsFixedTitle => '排除为固定支出';

  @override
  String get excludeAsFixedSubtitle => '房租、保险等 — 不计入果汁量表';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return '已收到「$category」收入 $amount mL!💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return '已记录「$category」支出 $amount mL!🍊';
  }

  @override
  String get calendarTitle => '日历';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return '本月:支出 $expense・收入 $income';
  }

  @override
  String get filterVariableOnlyShort => '仅变动';

  @override
  String get filterAllShort => '全部';

  @override
  String get noExpenseTodayMessage => '神清气爽的无支出日!🍊';

  @override
  String get assetsTitle => '资产';

  @override
  String get cumulativeNetWorthLabel => '累计净资产';

  @override
  String get cumulativeNetWorthDescription => '目前为止所有收入减去支出的总和。';

  @override
  String get scopeThisYear => '今年';

  @override
  String get scopeLast5Years => '近5年';

  @override
  String totalIncomeLabel(Object scope) {
    return '总收入($scope)';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return '总支出($scope)';
  }

  @override
  String get netChangeTrendTitle => '净额变化趋势';

  @override
  String get netChangeTrendDescription => '净额变化=收入减支出。绿色为盈余,红色为赤字。';

  @override
  String get statsTitle => '统计';

  @override
  String get filterFixedIncluded => '包含固定支出';

  @override
  String get totalExpenseTitle => '总支出';

  @override
  String get categorySpendingTitle => '分类消费';

  @override
  String get paymentMethodSpendingTitle => '支付方式消费';

  @override
  String get statsPeriodThisWeek => '本周';

  @override
  String get statsPeriodThisMonth => '本月';

  @override
  String get statsPeriodLast4Weeks => '近4周';

  @override
  String get statsPeriodMonthly => '按月';

  @override
  String get statsPeriodYearly => '按年';

  @override
  String get cardStatsViewSummary => '总览';

  @override
  String get cardStatsViewByCard => '按卡片明细';

  @override
  String get noExpensesInPeriod => '此期间尚无记录';

  @override
  String get categoryDetailThisMonthTotal => '本月合计';

  @override
  String get categoryDetailMonthlyTrendTitle => '月度趋势';

  @override
  String get categoryDetailExpenseListTitle => '详细明细';

  @override
  String get categoryDetailEmptyMessage => '尚无记录';

  @override
  String monthlyTotalLabel(Object month) {
    return '$month合计';
  }

  @override
  String get categoryDetailEmptyMonthMessage => '本月没有支出 🍊';

  @override
  String get installmentIncludedSuffix => '含分期';

  @override
  String get cardUnassigned => '未指定卡片';

  @override
  String get fillJuiceButton => '装满果汁';

  @override
  String get finishWizardButton => '以此配方开始使用果汁';

  @override
  String get incomeStepQuestion => '每月会有多少果汁\n(收入)入账呢?';

  @override
  String get incomeStepSubtitle => '请输入实际入账的税后金额。';

  @override
  String get wonSuffixSpaced => ' 元';

  @override
  String get goalStepQuestion => '想存多久、存多少呢?';

  @override
  String get yearsFieldLabel => '年';

  @override
  String get monthsFieldLabel => '月';

  @override
  String get goalAmountFieldLabel => '目标储蓄金额';

  @override
  String get wonUnit => '元';

  @override
  String get fixedExpenseStepQuestion => '每月有固定支出吗?';

  @override
  String get fixedExpenseStepSubtitle => '房租、保险、电话费等 — 不计入果汁罐的费用。';

  @override
  String get itemNameHint => '项目名称';

  @override
  String get addItemButton => '添加项目';

  @override
  String get resultStepQuestion => '你的专属果汁计划\n已经完成!';

  @override
  String get resultNegativeMessage => '固定支出与储蓄超过收入了 😥 请返回调整目标或期限。';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return '每月收入 $income 元 − 固定支出 $fixed 元 − 每月储蓄后,剩下:';
  }

  @override
  String get resultWeeklyPrefix => '本周:';

  @override
  String get resultWeeklySuffix => ' 可以享用的果汁!🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '$daily mL/日・$monthly mL/月';
  }

  @override
  String get periodDaily => '今天';

  @override
  String get periodWeekly => '本周';

  @override
  String get periodMonthly => '本月';

  @override
  String get periodSettingDaily => '每日';

  @override
  String get periodSettingWeekly => '每周';

  @override
  String get periodSettingMonthly => '每月';

  @override
  String get weekStartMonday => '周一开始(周一~周日)';

  @override
  String get weekStartSunday => '周日开始(周日~周六)';

  @override
  String get installmentModeMonthlyLabel => '次月一次入账';

  @override
  String get installmentModeDailyLabel => '每日平均入账';

  @override
  String get installmentModeMonthlyDescription => '如同真实信用卡账单,分期金额将于每月 1 日一次记录为支出。';

  @override
  String get installmentModeDailyDescription => '当月分期金额将按天数平均分摊,每天从果汁量表中少量扣除。';

  @override
  String get splashOrangeSubText => '清爽装满的本周预算';

  @override
  String get splashGreenAppleSubText => '细心消费的清新习惯';

  @override
  String get splashGrapeSubText => '甜蜜守护你的界限';

  @override
  String get splashStrawberrySubText => '充实美好的一天';

  @override
  String get confirmNewPinPrompt => '请再次输入新密码';

  @override
  String get enterCurrentPinPrompt => '请输入当前密码';

  @override
  String get enterNewPinPrompt => '请输入新密码';

  @override
  String get enterPinPrompt => '请输入密码';

  @override
  String get juiceLockTitle => '果汁已锁定';

  @override
  String get pinConfirmMismatchError => '密码不一致,请再试一次';

  @override
  String get pinMismatchError => '密码不正确';

  @override
  String get shareCardText => '我的果汁储蓄卡';

  @override
  String get unlockJuiceReason => '进行验证以解锁果汁';

  @override
  String get unlockWithBiometrics => '以生物识别解锁';

  @override
  String yearsPresetLabel(Object years) {
    return '$years年';
  }

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsCurrency => '基准货币设置';

  @override
  String get currencySelectTitle => '选择你的货币';

  @override
  String get commonDone => '完成';

  @override
  String get currencyNameKrw => '韩元 (₩)';

  @override
  String get currencyNameUsd => '美元 (\$)';

  @override
  String get currencyNameJpy => '日元 (¥)';

  @override
  String get currencyNameEur => '欧元 (€)';

  @override
  String get currencyNameVnd => '越南盾 (₫)';

  @override
  String get currencyNameTwd => '新台币 (NT\$)';

  @override
  String get currencyNameCny => '人民币 (¥)';

  @override
  String get currencyNameBrl => '巴西雷亚尔 (R\$)';

  @override
  String get foreignCurrencyPickerTitle => '选择付款货币';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted(今日汇率:$rate)';
  }

  @override
  String get exchangeRateLoadingMessage => '正在获取汇率...';

  @override
  String get exchangeRateFailedMessage => '无法获取汇率,请手动输入或使用最后已知汇率。';

  @override
  String get manualRateEntryToggle => '手动输入汇率';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => '重试';

  @override
  String get commonCopy => '复制';

  @override
  String linkOpenFailedMessage(Object target) {
    return '找不到可打开的应用:$target';
  }

  @override
  String get commonConfirm => '确认';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return '要将基准货币变更为 $toCode 吗?先前记录的所有金额将按当前汇率自动换算。';
  }

  @override
  String get currencyMigrationLoadingMessage => '正在将现有记录换算为新货币... 🍊';

  @override
  String get currencyMigrationFailedMessage => '无法获取汇率,因此现有金额维持不变';

  @override
  String get category_food_name => '餐饮';

  @override
  String get category_food_desc => '今天也充满元气的美味能量 🍱';

  @override
  String get category_cafe_name => '咖啡点心';

  @override
  String get category_cafe_desc => '甜蜜的一勺幸福 ☕️';

  @override
  String get category_transport_name => '交通';

  @override
  String get category_transport_desc => '顺畅抵达目的地 🚌';

  @override
  String get category_shopping_name => '购物';

  @override
  String get category_shopping_desc => '犒赏自己的喜悦 🛍️';

  @override
  String get category_culture_name => '休闲娱乐';

  @override
  String get category_culture_desc => '为心灵充电的甜美时光 🎬';

  @override
  String get category_life_name => '居家生活';

  @override
  String get category_life_desc => '日常舒适的清新一刻 🧼';

  @override
  String get category_etc_name => '其他';

  @override
  String get category_etc_desc => '多彩的日常花费 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return '已存下果汁 +$amount mL';
  }

  @override
  String get savingHistoryTitle => '储蓄记录';

  @override
  String get savingHistoryEmpty => '尚无已结束的周期。\n完成你的第一个周期吧!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '已存下 +$amount mL!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return '超支了 $amount mL';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return '目标 $target / 花费 $spent';
  }

  @override
  String get savingOptionTitle => '剩余果汁如何处理';

  @override
  String get savingOptionDescription => '选择周期结束时,未使用的预算要如何处理。';

  @override
  String get savingOptionRollover => '结转至下个周期';

  @override
  String get savingOptionSavings => '存入紧急备用金';

  @override
  String get savedJuiceStoreTooltip => '果汁储藏室';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return '已存下果汁:$amount mL($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return '包含上个周期结转的 +$amount mL';
  }

  @override
  String get savingsAssetCardTitle => '通过储蓄守护的资产';

  @override
  String get savingsAssetCardDescription => '以储蓄选项结束的周期的剩余果汁总和。';

  @override
  String get savingPraise_1 => '已经存了这么多!太厉害了!!离目标越来越近了 🍊';

  @override
  String get savingPraise_2 => '你守护了珍贵的果汁!你的储蓄习惯闪闪发光 ✨';

  @override
  String get savingPraise_3 => '存下的果汁正化为扎实的财富!今天也继续加油吧 🧃';

  @override
  String get savingPraise_4 => '储蓄是个美好的习惯!果汁越存越多,心也越来越安稳 🍯';

  @override
  String get savingPraise_5 => '坚定守护目标,你做得太棒了!下一杯果汁也一起保持新鲜吧 🍏';

  @override
  String get savingsLabel => '储蓄';

  @override
  String get savingsCategoryTab => '储蓄分类';

  @override
  String get category_savings_bank_name => '储蓄';

  @override
  String get category_savings_bank_desc => '一点一滴积累起来的家底 🏦';

  @override
  String get category_savings_invest_name => '投资/股票';

  @override
  String get category_savings_invest_desc => '为明天种下果实的种子 📈';

  @override
  String get category_savings_housing_name => '购房储蓄';

  @override
  String get category_savings_housing_desc => '拥有自己家的甜美梦想 🏠';

  @override
  String get category_savings_isa_name => 'ISA/节税账户';

  @override
  String get category_savings_isa_desc => '可靠的万能节税小袋 🛡️';

  @override
  String get category_savings_emergency_name => '紧急备用金';

  @override
  String get category_savings_emergency_desc => '随时都能依靠的缓冲垫 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return '已为「$category」记录储蓄 $amount mL!🌱';
  }

  @override
  String get statsTotalIncomeTitle => '总收入';

  @override
  String get statsTotalSavingsTitle => '总储蓄';

  @override
  String get incomeCategoryTitleStats => '分类收入';

  @override
  String get savingsCategoryTitleStats => '分类储蓄';

  @override
  String get savingsOverviewSectionTitle => '🌱 储蓄与投资';

  @override
  String get savingsThisMonthTotalLabel => '本月储蓄与投资总额';

  @override
  String get savingsOverviewEmptyMessage => '尚无储蓄或投资记录';

  @override
  String get scopeThisMonth => '本月';

  @override
  String get calendarAmountModeCompact => '精简';

  @override
  String get calendarAmountModeFull => '完整金额';

  @override
  String get savingsAllTimeTotalLabel => '累计储蓄与投资总额';

  @override
  String get currencyWarningNotice => '金额将以实时汇率重新换算,可能导致历史数据出现细微差异,请务必在必要时再变更!';

  @override
  String get onboardingStep1Title => '来设置一个轻松自在的消费预算吧';

  @override
  String get onboardingBudgetLabelDaily => '每日预算';

  @override
  String get onboardingBudgetLabelWeekly => '本周预算';

  @override
  String get onboardingBudgetLabelMonthly => '本月预算';

  @override
  String get onboardingStep1NextButton => '下一步:设置长期目标(1/2)';

  @override
  String get onboardingFooterHint => '之后随时都能在设置中变更!';

  @override
  String get onboardingStep2Title => '你有几年后想达成的储蓄目标吗?';

  @override
  String get onboardingStep2Subtitle => '设置目标后,我们会智能地计算你每月的储蓄与可用果汁。';

  @override
  String get onboardingDurationLabel => '目标期限';

  @override
  String get onboardingGoalAmountLabel => '目标金额';

  @override
  String get onboardingCompleteButton => '设置目标并开始使用';

  @override
  String get onboardingSkipButton => '暂时跳过';

  @override
  String get commonBack => '返回';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return '果汁(mL)就是你能花的钱!(1$symbol = 1 mL)';
  }

  @override
  String get customDuration => '自定义';

  @override
  String get yearUnit => '年';

  @override
  String get monthUnit => '月';

  @override
  String totalDurationLabel(Object months) {
    return '共 $months 个月';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return '每月存约 $amount,持续 $months 个月即可达成目标!🌱';
  }

  @override
  String get onboardingChooseGoalType => '想从哪个目标开始呢?';

  @override
  String get onboardingShortTermTitle => '轻松的短期预算';

  @override
  String get onboardingShortTermDesc => '设置今天、本周或本月要花多少果汁,轻松管理支出。';

  @override
  String get onboardingLongTermTitle => '扎实的中长期储蓄目标';

  @override
  String get onboardingLongTermDesc => '设置几年后想达成的总目标,并智能地储蓄达成。';

  @override
  String get startWithJuice => '装满果汁并开始';

  @override
  String get startWithLongPlan => '保存计划并开始';

  @override
  String get category_income_salary_name => '工资';

  @override
  String get category_income_salary_desc => '辛勤努力换来的甜美果实 💼';

  @override
  String get category_income_side_name => '副业收入';

  @override
  String get category_income_side_desc => '悄悄流入的一点蜂蜜奖励 🍯';

  @override
  String get category_income_allowance_name => '零花钱';

  @override
  String get category_income_allowance_desc => '令人惊喜的美好礼物 🎁';

  @override
  String get category_income_finance_name => '投资理财';

  @override
  String get category_income_finance_desc => '让钱生钱的成果 📈';

  @override
  String get category_income_etc_name => '其他收入';

  @override
  String get category_income_etc_desc => '其他多彩的收入 💧';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant(): super('zh_Hant');

  @override
  String get appTitle => 'Juice Budget';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get setBudgetTitle => '設定你的果汁預算';

  @override
  String get weeklyBudget => '本週剩餘果汁';

  @override
  String get paymentCheckCard => '金融卡';

  @override
  String get paymentCreditCard => '信用卡';

  @override
  String get paymentCash => '現金・轉帳';

  @override
  String get commonCancel => '取消';

  @override
  String get commonSave => '儲存';

  @override
  String get commonDelete => '刪除';

  @override
  String get commonEdit => '編輯';

  @override
  String get commonAdd => '新增';

  @override
  String get commonNext => '下一步';

  @override
  String get goalSettingsTitle => '目標設定';

  @override
  String get activePeriodSectionTitle => '目前目標週期';

  @override
  String get activePeriodSectionDescription => '首頁量表所依據的週期。請先在下方填寫各週期的目標金額,切換時會立即套用。';

  @override
  String get weekStartDayTileTitle => '每週起始日';

  @override
  String get periodTargetSectionTitle => '各週期目標金額';

  @override
  String get periodTargetSectionDescription => '為每個週期分別儲存目標金額,並選擇你需要的週期。';

  @override
  String get periodTargetAmountSuffix => '目標金額';

  @override
  String get installmentSectionTitle => '分期反映方式';

  @override
  String get installmentSectionDescription => '選擇分期付款要如何、何時反映在日曆/果汁量表中。';

  @override
  String get recommendedSuffix => '推薦';

  @override
  String get savingsPlanSectionTitle => '中長期儲蓄規劃';

  @override
  String get savingsPlanSectionDescription => '輸入每月收入、固定支出與儲蓄目標,計算可用的果汁額度。';

  @override
  String get savingsPlanToggleTitle => '你有中長期儲蓄目標嗎?';

  @override
  String get autoBudgetSetMessage => '已自動設定每日/每週/每月目標 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 我的果汁計畫摘要';

  @override
  String get replanButton => '重新規劃';

  @override
  String get applyBudgetButton => '以此預算自動設定果汁';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years年$months個月';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years年';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months個月';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return '目標:$duration內存下 $amount 元';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return '固定支出(無法避免):每月 $amount 元';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return '建議果汁量:每日 $daily mL・每週 $weekly mL・每月 $monthly mL';
  }

  @override
  String get settingsTitle => '設定';

  @override
  String get savingsCardSectionTitle => '本週儲蓄卡';

  @override
  String get savingsCardSectionDescription => '把達成預算的一週做成卡片並分享。';

  @override
  String get generatingCard => '卡片產生中...';

  @override
  String get shareCardButton => '分享卡片';

  @override
  String get setTargetAmountFirst => '請先設定目標金額';

  @override
  String get menuGoalSettingsTitle => '目標設定';

  @override
  String get menuGoalSettingsSubtitle => '長期儲蓄目標、目標週期、各週期目標金額';

  @override
  String get menuThemeSettingsTitle => '主題設定';

  @override
  String get menuThemeSettingsSubtitle => '畫面模式與果汁主題';

  @override
  String get menuWidgetSettingsTitle => '小工具設定';

  @override
  String get menuWidgetSettingsSubtitle => '隱藏主畫面小工具上的金額';

  @override
  String get menuCardManagementTitle => '卡片管理';

  @override
  String get menuCardManagementSubtitle => '登錄你擁有的卡片,並重新排序';

  @override
  String get menuNotificationSettingsTitle => '通知設定';

  @override
  String get menuNotificationSettingsSubtitle => '開關早晚提醒通知';

  @override
  String get menuBackupSettingsTitle => '資料備份與還原';

  @override
  String get menuBackupSettingsSubtitle => '匯出 CSV、匯出/匯入備份檔案';

  @override
  String get menuSecuritySettingsTitle => '安全性';

  @override
  String get menuSecuritySettingsSubtitle => 'PIN 碼、生物辨識驗證';

  @override
  String get menuContactSupportTitle => '聯絡與意見回饋';

  @override
  String get menuContactSupportSubtitle => '透過電子郵件傳送您的意見';

  @override
  String get feedbackTitle => '聯絡與意見回饋 🍊';

  @override
  String get feedbackTypeBug => '回報錯誤';

  @override
  String get feedbackTypeFeature => '功能建議';

  @override
  String get feedbackTypeOther => '其他';

  @override
  String get feedbackEmailHint => '您的電子郵件(選填,供我們回覆)';

  @override
  String get feedbackContentHint => '請與我們分享您的意見。';

  @override
  String get feedbackAttachImage => '附加截圖';

  @override
  String get feedbackSubmit => '送出';

  @override
  String get feedbackDeviceInfoNotice => '為了更快協助您,將一併傳送裝置/系統資訊。';

  @override
  String get feedbackContentRequired => '請輸入內容';

  @override
  String get feedbackMailUnavailable => '無法開啟郵件應用程式，內容已複製。';

  @override
  String get privacyPolicyTitle => '隱私權政策';

  @override
  String get menuPrivacyPolicySubtitle => '了解我們如何處理您的個人資料';

  @override
  String get privacyWelcomeTitle => '歡迎使用 Juice Budget!';

  @override
  String get privacyAgreeNotice => 'Juice Budget 是 100% 裝置端本地記帳應用程式,絕不會將您的任何財務或個人資料傳送到外部伺服器。';

  @override
  String get viewPrivacyPolicy => '查看完整隱私權政策';

  @override
  String get agreeAndStart => '同意並開始使用';

  @override
  String get appNameShort => 'Juice';

  @override
  String get savingsCardSuccessMessage => '這一週的\n果汁維持新鮮!';

  @override
  String get savingsCardOverMessage => '這一週的果汁\n灑出了一些';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return '已花費 $budget 中的 $spent';
  }

  @override
  String get savingsCardSuccessStamp => '成功';

  @override
  String get savingsCardOverStamp => '再加油';

  @override
  String get pinSetupTitle => '設定密碼';

  @override
  String get biometricUnlockReason => '進行驗證以解鎖';

  @override
  String get pinConfirmTitle => '確認密碼';

  @override
  String get pinConfirmCurrentTitle => '確認目前密碼';

  @override
  String get pinSetupNewTitle => '設定新密碼';

  @override
  String get pinChangedMessage => '密碼已變更';

  @override
  String get biometricLinkTitle => '連結生物辨識驗證';

  @override
  String get biometricLinkConfirm => '要連結生物辨識驗證嗎?';

  @override
  String get biometricLinkAction => '連結';

  @override
  String get biometricLinkReason => '進行驗證以連結生物辨識';

  @override
  String get biometricUnavailableMessage => '無法使用生物辨識驗證';

  @override
  String get securityTitle => '安全性';

  @override
  String get securityDescription => '以 PIN 碼或生物辨識鎖定應用程式。';

  @override
  String get appLockTitle => '應用程式鎖定';

  @override
  String get appLockDescription => '以 4 位數 PIN 碼保護應用程式存取。';

  @override
  String get changePasswordTitle => '變更密碼';

  @override
  String get biometricUseTitle => '使用生物辨識';

  @override
  String get biometricUseDescription => '以 Face ID/指紋更快解鎖。';

  @override
  String get csvShareText => '果汁支出紀錄';

  @override
  String get backupShareText => '果汁資料備份';

  @override
  String backupFailedMessage(Object error) {
    return '備份失敗:$error';
  }

  @override
  String get restoreDataTitle => '還原資料';

  @override
  String get restoreDataConfirm => '現有資料將被備份檔案取代,是否繼續?';

  @override
  String get restoreAction => '還原';

  @override
  String get restoreSuccessMessage => '還原完成';

  @override
  String get restoreFailedMessage => '還原失敗,請確認這是有效的 Juice 備份檔案';

  @override
  String get backupSettingsTitle => '資料備份與還原';

  @override
  String get exportExpensesTitle => '匯出支出紀錄';

  @override
  String get exportExpensesDescription => '分享包含日期、分類、金額、固定支出標記與備註的 CSV 檔案。';

  @override
  String get exportingCsv => '匯出中...';

  @override
  String get exportCsvButton => '匯出為 CSV';

  @override
  String get backupRestoreTitle => '資料備份・還原';

  @override
  String get backupRestoreDescription => '將支出、收入、分類與預算設定備份與還原為單一檔案。';

  @override
  String get backupDataTitle => '備份資料';

  @override
  String get backupDataDescription => '透過分享功能儲存至檔案、電子郵件等。';

  @override
  String get restoreDataTileTitle => '還原資料';

  @override
  String get restoreDataTileDescription => '選擇備份檔案以覆寫現有資料。';

  @override
  String get categoryDefaultDescription => '我的專屬果汁配方';

  @override
  String get categoryDeleteTitle => '刪除分類';

  @override
  String categoryDeleteConfirm(Object name) {
    return '刪除「$name」分類嗎?\n已記錄的支出將會保留。';
  }

  @override
  String get categoryInUseMessage => '部分紀錄使用此分類,請先將其移至其他分類後再刪除。';

  @override
  String get categoryEditTitle => '編輯分類';

  @override
  String get categoryAddTitle => '新增分類';

  @override
  String get categoryNameLabel => '分類名稱';

  @override
  String get categoryDescriptionLabel => '簡短說明';

  @override
  String get colorLabel => '顏色';

  @override
  String get iconLabel => '圖示';

  @override
  String get categoryManageTitle => '分類管理';

  @override
  String get expenseCategoryTab => '支出分類';

  @override
  String get incomeCategoryTab => '收入分類';

  @override
  String get defaultCategoryUndeletable => '預設分類無法刪除';

  @override
  String get cardDeleteTitle => '刪除卡片';

  @override
  String cardDeleteConfirm(Object name) {
    return '刪除「$name」卡片嗎?\n已記錄的支出將會保留。';
  }

  @override
  String get cardEditTitle => '編輯卡片';

  @override
  String get cardAddTitle => '新增卡片';

  @override
  String get cardNameLabel => '卡片名稱';

  @override
  String get cardTypeLabel => '卡片類型';

  @override
  String get cardManagementTitle => '卡片管理';

  @override
  String get defaultCardUndeletable => '預設卡片無法刪除';

  @override
  String get cardTypeCorporate => '公司/業務用';

  @override
  String get cardTypeCorporateExcluded => '公司用(支出)・不計入果汁';

  @override
  String get corporateExpenseNotice => '🏢 公司/業務支出不需選擇分類,將自動從個人支出中排除。';

  @override
  String get corporateBadgeLabel => '🏢 公司/業務用・不計入個人支出';

  @override
  String get corporateCardLabel => '公司/業務卡';

  @override
  String get corporateMemoRequired => '公司/業務支出請輸入備註(用途)';

  @override
  String get juiceThemeLabel => '果汁主題';

  @override
  String get themeSettingsTitle => '主題設定';

  @override
  String get screenModeLabel => '畫面模式';

  @override
  String get themeModeSystem => '系統';

  @override
  String get themeModeLight => '淺色';

  @override
  String get themeModeDark => '深色';

  @override
  String get juiceThemeDescription => '選擇隨剩餘預算變化的果汁顏色,同時也會成為應用程式的主題色。';

  @override
  String get themeOrange => '柳橙';

  @override
  String get themeStrawberry => '草莓';

  @override
  String get themeApple => '蘋果';

  @override
  String get themeGrape => '葡萄';

  @override
  String get themeBlueberry => '藍莓';

  @override
  String get themeMulberry => '桑葚';

  @override
  String get themeRandom => '隨機(每次開啟應用程式時)';

  @override
  String get widgetSettingsTitle => '小工具設定';

  @override
  String get homeScreenWidgetTitle => '主畫面小工具';

  @override
  String get homeScreenWidgetDescription => '可以在主畫面新增果汁量表小工具與快速記帳小工具。';

  @override
  String get hideWidgetAmountTitle => '隱藏小工具金額';

  @override
  String get hideWidgetAmountDescription => '以 ***mL 及剩餘百分比取代實際金額顯示。';

  @override
  String get notificationSettingsTitle => '通知設定';

  @override
  String get notificationScheduleDescription => '我們會於每天早上 7 點與晚上 8 點傳送提醒,鼓勵你記帳。';

  @override
  String get receiveNotificationsTitle => '接收果汁通知';

  @override
  String get receiveNotificationsDescription => '若你許久未開啟應用程式,我們也會提醒你回來看看。';

  @override
  String get navHome => '首頁';

  @override
  String get navCalendar => '日曆';

  @override
  String get navAssets => '資產';

  @override
  String get navStats => '統計';

  @override
  String get navSettings => '設定';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 今日分期金額:$amount mL';
  }

  @override
  String get filterVariableOnlyLong => '僅顯示變動支出';

  @override
  String get filterAllLong => '顯示全部';

  @override
  String noGoalTitle(Object period) {
    return '尚未設定$period目標金額';
  }

  @override
  String noGoalDescription(Object period) {
    return '請在目標設定中填寫$period目標金額。';
  }

  @override
  String get goToGoalSettings => '前往目標設定';

  @override
  String get noExpensesYet => '尚未記錄任何支出';

  @override
  String remainingJuiceLabel(Object period) {
    return '$period剩餘果汁';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '已使用 $percent%';
  }

  @override
  String get overBudgetMessage1 => '太可惜了!下週留點果汁吧 🍊';

  @override
  String get overBudgetMessage2 => '果汁罐空了!這週先喘口氣吧 🥲';

  @override
  String get overBudgetMessage3 => '果汁灑出來了!下週再重新裝滿吧 🧃';

  @override
  String get overBudgetMessage4 => '只剩最後一滴!下週慢慢品嚐吧 ✨';

  @override
  String get incomeFallbackName => '收入';

  @override
  String get unknownCategoryName => '未知';

  @override
  String get fixedExpenseLabel => '固定';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return '分期 $index/$months';
  }

  @override
  String get deletedMessage => '已刪除';

  @override
  String get undoAction => '復原';

  @override
  String get amountAndCategoryRequired => '請確認金額與分類';

  @override
  String get expenseLabel => '支出';

  @override
  String get incomeLabel => '收入';

  @override
  String editTypeTitle(Object type) {
    return '編輯$type';
  }

  @override
  String addTypeTitle(Object type) {
    return '新增$type';
  }

  @override
  String deleteTypeTitle(Object type) {
    return '刪除$type';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return '要刪除此筆$type紀錄嗎?';
  }

  @override
  String get cardSelectLabel => '選擇卡片';

  @override
  String installmentEditNotice(Object index, Object months) {
    return '分期 $index/$months — 其他分期不會一併變更';
  }

  @override
  String get lumpSumLabel => '一次付清';

  @override
  String monthsPresetLabel(Object months) {
    return '$months期';
  }

  @override
  String get customInputLabel => '自訂';

  @override
  String get monthsCountHint => '期數(2-24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return '將以每月 $amount mL 反映,共 $months 期';
  }

  @override
  String get memoHint => '備註(選填)';

  @override
  String get excludeAsFixedTitle => '排除為固定支出';

  @override
  String get excludeAsFixedSubtitle => '房租、保險等 — 不計入果汁量表';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return '已收到「$category」收入 $amount mL!💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return '已記錄「$category」支出 $amount mL!🍊';
  }

  @override
  String get calendarTitle => '日曆';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return '本月:支出 $expense・收入 $income';
  }

  @override
  String get filterVariableOnlyShort => '僅變動';

  @override
  String get filterAllShort => '全部';

  @override
  String get noExpenseTodayMessage => '神清氣爽的無支出日!🍊';

  @override
  String get assetsTitle => '資產';

  @override
  String get cumulativeNetWorthLabel => '累積淨資產';

  @override
  String get cumulativeNetWorthDescription => '目前為止所有收入減去支出的總和。';

  @override
  String get scopeThisYear => '今年';

  @override
  String get scopeLast5Years => '近5年';

  @override
  String totalIncomeLabel(Object scope) {
    return '總收入($scope)';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return '總支出($scope)';
  }

  @override
  String get netChangeTrendTitle => '淨額變化趨勢';

  @override
  String get netChangeTrendDescription => '淨額變化=收入減支出。綠色為盈餘,紅色為赤字。';

  @override
  String get statsTitle => '統計';

  @override
  String get filterFixedIncluded => '包含固定支出';

  @override
  String get totalExpenseTitle => '總支出';

  @override
  String get categorySpendingTitle => '分類別消費';

  @override
  String get paymentMethodSpendingTitle => '付款方式別消費';

  @override
  String get statsPeriodThisWeek => '本週';

  @override
  String get statsPeriodThisMonth => '本月';

  @override
  String get statsPeriodLast4Weeks => '近4週';

  @override
  String get statsPeriodMonthly => '月別';

  @override
  String get statsPeriodYearly => '年別';

  @override
  String get cardStatsViewSummary => '總覽';

  @override
  String get cardStatsViewByCard => '各卡片明細';

  @override
  String get noExpensesInPeriod => '此期間尚無紀錄';

  @override
  String get categoryDetailThisMonthTotal => '本月合計';

  @override
  String get categoryDetailMonthlyTrendTitle => '月別趨勢';

  @override
  String get categoryDetailExpenseListTitle => '詳細明細';

  @override
  String get categoryDetailEmptyMessage => '尚無紀錄';

  @override
  String monthlyTotalLabel(Object month) {
    return '$month合計';
  }

  @override
  String get categoryDetailEmptyMonthMessage => '本月沒有支出 🍊';

  @override
  String get installmentIncludedSuffix => '含分期';

  @override
  String get cardUnassigned => '未指定卡片';

  @override
  String get fillJuiceButton => '裝滿果汁';

  @override
  String get finishWizardButton => '以此配方開始使用果汁';

  @override
  String get incomeStepQuestion => '每月會有多少果汁\n(收入)進帳呢?';

  @override
  String get incomeStepSubtitle => '請輸入實際入帳的稅後金額。';

  @override
  String get wonSuffixSpaced => ' 元';

  @override
  String get goalStepQuestion => '想存多久、存多少呢?';

  @override
  String get yearsFieldLabel => '年';

  @override
  String get monthsFieldLabel => '月';

  @override
  String get goalAmountFieldLabel => '目標儲蓄金額';

  @override
  String get wonUnit => '元';

  @override
  String get fixedExpenseStepQuestion => '每月有固定支出嗎?';

  @override
  String get fixedExpenseStepSubtitle => '房租、保險、電話費等 — 不計入果汁罐的費用。';

  @override
  String get itemNameHint => '項目名稱';

  @override
  String get addItemButton => '新增項目';

  @override
  String get resultStepQuestion => '你的專屬果汁計畫\n已經完成!';

  @override
  String get resultNegativeMessage => '固定支出與儲蓄超過收入了 😥 請返回調整目標或期間。';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return '每月收入 $income 元 − 固定支出 $fixed 元 − 每月儲蓄後,剩下:';
  }

  @override
  String get resultWeeklyPrefix => '本週:';

  @override
  String get resultWeeklySuffix => ' 可以享用的果汁!🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '$daily mL/日・$monthly mL/月';
  }

  @override
  String get periodDaily => '今天';

  @override
  String get periodWeekly => '本週';

  @override
  String get periodMonthly => '本月';

  @override
  String get periodSettingDaily => '每日';

  @override
  String get periodSettingWeekly => '每週';

  @override
  String get periodSettingMonthly => '每月';

  @override
  String get weekStartMonday => '週一開始(一~日)';

  @override
  String get weekStartSunday => '週日開始(日~六)';

  @override
  String get installmentModeMonthlyLabel => '次月一次入帳';

  @override
  String get installmentModeDailyLabel => '每日平均入帳';

  @override
  String get installmentModeMonthlyDescription => '如同真實信用卡帳單,分期金額將於每月 1 日一次記錄為支出。';

  @override
  String get installmentModeDailyDescription => '當月分期金額將依天數平均分攤,每天從果汁量表中少量扣除。';

  @override
  String get splashOrangeSubText => '清爽裝滿的本週預算';

  @override
  String get splashGreenAppleSubText => '細心消費的清新習慣';

  @override
  String get splashGrapeSubText => '甜蜜守護你的界線';

  @override
  String get splashStrawberrySubText => '充實美好的一天';

  @override
  String get confirmNewPinPrompt => '請再次輸入新密碼';

  @override
  String get enterCurrentPinPrompt => '請輸入目前的密碼';

  @override
  String get enterNewPinPrompt => '請輸入新密碼';

  @override
  String get enterPinPrompt => '請輸入密碼';

  @override
  String get juiceLockTitle => '果汁已鎖定';

  @override
  String get pinConfirmMismatchError => '密碼不一致,請再試一次';

  @override
  String get pinMismatchError => '密碼不正確';

  @override
  String get shareCardText => '我的果汁儲蓄卡';

  @override
  String get unlockJuiceReason => '進行驗證以解鎖果汁';

  @override
  String get unlockWithBiometrics => '以生物辨識解鎖';

  @override
  String yearsPresetLabel(Object years) {
    return '$years年';
  }

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsCurrency => '基準貨幣設定';

  @override
  String get currencySelectTitle => '選擇你的貨幣';

  @override
  String get commonDone => '完成';

  @override
  String get currencyNameKrw => '韓元 (₩)';

  @override
  String get currencyNameUsd => '美元 (\$)';

  @override
  String get currencyNameJpy => '日圓 (¥)';

  @override
  String get currencyNameEur => '歐元 (€)';

  @override
  String get currencyNameVnd => '越南盾 (₫)';

  @override
  String get currencyNameTwd => '新台幣 (NT\$)';

  @override
  String get currencyNameCny => '人民幣 (¥)';

  @override
  String get currencyNameBrl => '巴西雷亞爾 (R\$)';

  @override
  String get foreignCurrencyPickerTitle => '選擇付款貨幣';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted(今日匯率:$rate)';
  }

  @override
  String get exchangeRateLoadingMessage => '正在取得匯率...';

  @override
  String get exchangeRateFailedMessage => '無法取得匯率,請手動輸入或使用最後已知匯率。';

  @override
  String get manualRateEntryToggle => '手動輸入匯率';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => '重試';

  @override
  String get commonCopy => '複製';

  @override
  String linkOpenFailedMessage(Object target) {
    return '找不到可開啟的應用程式:$target';
  }

  @override
  String get commonConfirm => '確認';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return '要將基準貨幣變更為 $toCode 嗎?先前記錄的所有金額將依目前匯率自動換算。';
  }

  @override
  String get currencyMigrationLoadingMessage => '正在將現有紀錄換算為新貨幣... 🍊';

  @override
  String get currencyMigrationFailedMessage => '無法取得匯率,因此現有金額維持不變';

  @override
  String get category_food_name => '餐飲';

  @override
  String get category_food_desc => '今天也充滿元氣的美味能量 🍱';

  @override
  String get category_cafe_name => '咖啡甜點';

  @override
  String get category_cafe_desc => '甜蜜的一匙幸福 ☕️';

  @override
  String get category_transport_name => '交通';

  @override
  String get category_transport_desc => '順暢抵達目的地 🚌';

  @override
  String get category_shopping_name => '購物';

  @override
  String get category_shopping_desc => '犒賞自己的喜悅 🛍️';

  @override
  String get category_culture_name => '休閒娛樂';

  @override
  String get category_culture_desc => '為心靈充電的甜美時光 🎬';

  @override
  String get category_life_name => '居家生活';

  @override
  String get category_life_desc => '日常舒適的清新一刻 🧼';

  @override
  String get category_etc_name => '其他';

  @override
  String get category_etc_desc => '多彩的日常花費 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return '已存下果汁 +$amount mL';
  }

  @override
  String get savingHistoryTitle => '儲蓄紀錄';

  @override
  String get savingHistoryEmpty => '尚無已結束的週期。\n完成你的第一個週期吧!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '已存下 +$amount mL!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return '超支了 $amount mL';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return '目標 $target / 花費 $spent';
  }

  @override
  String get savingOptionTitle => '剩餘果汁如何處理';

  @override
  String get savingOptionDescription => '選擇週期結束時,未使用的預算要如何處理。';

  @override
  String get savingOptionRollover => '結轉至下個週期';

  @override
  String get savingOptionSavings => '存入緊急預備金';

  @override
  String get savedJuiceStoreTooltip => '果汁儲藏室';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return '已存下果汁:$amount mL($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return '包含上個週期結轉的 +$amount mL';
  }

  @override
  String get savingsAssetCardTitle => '透過儲蓄守護的資產';

  @override
  String get savingsAssetCardDescription => '以儲蓄選項結束之週期的剩餘果汁總和。';

  @override
  String get savingPraise_1 => '已經存了這麼多!太厲害了!!離目標越來越近囉 🍊';

  @override
  String get savingPraise_2 => '你守護了珍貴的果汁!你的儲蓄習慣閃閃發光 ✨';

  @override
  String get savingPraise_3 => '存下的果汁正化為紮實的財富!今天也繼續加油吧 🧃';

  @override
  String get savingPraise_4 => '儲蓄是個美好的習慣!果汁越存越多,心也越來越安穩 🍯';

  @override
  String get savingPraise_5 => '堅定守護目標,你做得太棒了!下一杯果汁也一起保持新鮮吧 🍏';

  @override
  String get savingsLabel => '儲蓄';

  @override
  String get savingsCategoryTab => '儲蓄分類';

  @override
  String get category_savings_bank_name => '儲蓄';

  @override
  String get category_savings_bank_desc => '一點一滴累積起來的老本 🏦';

  @override
  String get category_savings_invest_name => '投資/股票';

  @override
  String get category_savings_invest_desc => '為明天種下果實的種子 📈';

  @override
  String get category_savings_housing_name => '購屋儲蓄';

  @override
  String get category_savings_housing_desc => '擁有自己家的甜美夢想 🏠';

  @override
  String get category_savings_isa_name => 'ISA/節稅帳戶';

  @override
  String get category_savings_isa_desc => '可靠的萬用節稅小袋 🛡️';

  @override
  String get category_savings_emergency_name => '緊急預備金';

  @override
  String get category_savings_emergency_desc => '隨時都能依靠的緩衝墊 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return '已為「$category」記錄儲蓄 $amount mL!🌱';
  }

  @override
  String get statsTotalIncomeTitle => '總收入';

  @override
  String get statsTotalSavingsTitle => '總儲蓄';

  @override
  String get incomeCategoryTitleStats => '分類別收入';

  @override
  String get savingsCategoryTitleStats => '分類別儲蓄';

  @override
  String get savingsOverviewSectionTitle => '🌱 儲蓄與投資';

  @override
  String get savingsThisMonthTotalLabel => '本月儲蓄與投資總額';

  @override
  String get savingsOverviewEmptyMessage => '尚無儲蓄或投資紀錄';

  @override
  String get scopeThisMonth => '本月';

  @override
  String get calendarAmountModeCompact => '精簡';

  @override
  String get calendarAmountModeFull => '完整金額';

  @override
  String get savingsAllTimeTotalLabel => '累積儲蓄與投資總額';

  @override
  String get currencyWarningNotice => '金額將以即時匯率重新換算,可能導致過去資料出現些微差異,請務必於必要時再變更!';

  @override
  String get onboardingStep1Title => '來設定一個輕鬆自在的花費預算吧';

  @override
  String get onboardingBudgetLabelDaily => '每日預算';

  @override
  String get onboardingBudgetLabelWeekly => '本週預算';

  @override
  String get onboardingBudgetLabelMonthly => '本月預算';

  @override
  String get onboardingStep1NextButton => '下一步:設定長期目標(1/2)';

  @override
  String get onboardingFooterHint => '之後隨時都能在設定中變更!';

  @override
  String get onboardingStep2Title => '你有幾年後想達成的儲蓄目標嗎?';

  @override
  String get onboardingStep2Subtitle => '設定目標後,我們會聰明地計算你每月的儲蓄與可用果汁。';

  @override
  String get onboardingDurationLabel => '目標期間';

  @override
  String get onboardingGoalAmountLabel => '目標金額';

  @override
  String get onboardingCompleteButton => '設定目標並開始使用';

  @override
  String get onboardingSkipButton => '暫時略過';

  @override
  String get commonBack => '返回';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return '果汁(mL)就是你能花的錢!(1$symbol = 1 mL)';
  }

  @override
  String get customDuration => '自訂';

  @override
  String get yearUnit => '年';

  @override
  String get monthUnit => '月';

  @override
  String totalDurationLabel(Object months) {
    return '共 $months 個月';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return '每月存約 $amount,持續 $months 個月即可達成目標!🌱';
  }

  @override
  String get onboardingChooseGoalType => '想從哪個目標開始呢?';

  @override
  String get onboardingShortTermTitle => '輕鬆的短期預算';

  @override
  String get onboardingShortTermDesc => '設定今天、本週或本月要花多少果汁,輕鬆管理支出。';

  @override
  String get onboardingLongTermTitle => '紮實的中長期儲蓄目標';

  @override
  String get onboardingLongTermDesc => '設定幾年後想達成的整體目標,並聰明地儲蓄達成。';

  @override
  String get startWithJuice => '裝滿果汁並開始';

  @override
  String get startWithLongPlan => '儲存計畫並開始';

  @override
  String get category_income_salary_name => '薪資';

  @override
  String get category_income_salary_desc => '辛勤努力換來的甜美果實 💼';

  @override
  String get category_income_side_name => '副業收入';

  @override
  String get category_income_side_desc => '悄悄流入的一點蜂蜜獎勵 🍯';

  @override
  String get category_income_allowance_name => '零用錢';

  @override
  String get category_income_allowance_desc => '令人驚喜的美好禮物 🎁';

  @override
  String get category_income_finance_name => '投資收益';

  @override
  String get category_income_finance_desc => '讓錢生錢的成果 📈';

  @override
  String get category_income_etc_name => '其他收入';

  @override
  String get category_income_etc_desc => '其他多彩的收入 💧';
}
