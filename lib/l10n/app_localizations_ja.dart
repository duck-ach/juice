import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Juice家計簿';

  @override
  String get selectLanguage => '言語を選択してください';

  @override
  String get setBudgetTitle => '目標のジュースを満たしましょうか?';

  @override
  String get weeklyBudget => '今週残っているジュース';

  @override
  String get paymentCheckCard => 'デビットカード';

  @override
  String get paymentCreditCard => 'クレジットカード';

  @override
  String get paymentCash => '現金・振込';

  @override
  String get paymentSplitBill => '割り勘';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '削除';

  @override
  String get commonEdit => '編集';

  @override
  String get commonAdd => '追加';

  @override
  String get commonNext => '次へ';

  @override
  String get goalSettingsTitle => '目標設定';

  @override
  String get activePeriodSectionTitle => '有効な目標周期';

  @override
  String get activePeriodSectionDescription => 'ホーム画面のゲージの基準になる周期です。下で各周期の目標金額を入力しておくと、切り替え時すぐに反映されます。';

  @override
  String get weekStartDayTileTitle => '週の開始曜日';

  @override
  String get periodTargetSectionTitle => '周期別目標金額';

  @override
  String get periodTargetSectionDescription => '周期ごとに目標金額を別々に保存して、必要な時に選んで使えます。';

  @override
  String get periodTargetAmountSuffix => '目標金額';

  @override
  String get installmentSectionTitle => 'クレジットカード分割の反映方法';

  @override
  String get installmentSectionDescription => '分割払いで登録した支出をカレンダー/ジュースゲージにいつ、どのように反映するか選んでください。';

  @override
  String get recommendedSuffix => 'おすすめ';

  @override
  String get savingsPlanSectionTitle => '中長期貯蓄目標プランナー';

  @override
  String get savingsPlanSectionDescription => '月収入と固定費、貯蓄目標を入力すると、変動費に使えるジュース量を計算します。';

  @override
  String get savingsPlanToggleTitle => '中長期の貯蓄目標はありますか?';

  @override
  String get autoBudgetSetMessage => '日/週/月の目標金額が自動設定されました🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 私のジュースプラン要約';

  @override
  String get replanButton => 'プランを組み直す';

  @override
  String get applyBudgetButton => 'この予算でジュースを自動設定';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years年$monthsヶ月';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years年';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$monthsヶ月';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return '目標: $durationで$amountウォン貯める';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return '固定費(何もしなくても出るお金): 月$amountウォン';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return 'おすすめジュース: 1日${daily}mL・今週${weekly}mL・今月${monthly}mL';
  }

  @override
  String get settingsTitle => '設定';

  @override
  String get savingsCardSectionTitle => '今週の節約カード';

  @override
  String get savingsCardSectionDescription => '予算防衛に成功した1週間をカードにして共有しましょう。';

  @override
  String get generatingCard => 'カード生成中...';

  @override
  String get shareCardButton => 'カードを共有';

  @override
  String get setTargetAmountFirst => '先に目標金額を設定してください';

  @override
  String get menuGoalSettingsTitle => '目標設定';

  @override
  String get menuGoalSettingsSubtitle => '長期貯蓄目標、目標周期、周期別目標金額';

  @override
  String get menuThemeSettingsTitle => 'テーマ設定';

  @override
  String get menuThemeSettingsSubtitle => '画面モード及びジューステーマ';

  @override
  String get menuWidgetSettingsTitle => 'ウィジェット設定';

  @override
  String get menuWidgetSettingsSubtitle => 'ホーム画面ウィジェットの金額を隠す';

  @override
  String get menuCardManagementTitle => 'マイカード管理';

  @override
  String get menuCardManagementSubtitle => '保有カード登録、順序変更';

  @override
  String get menuNotificationSettingsTitle => '通知設定';

  @override
  String get menuNotificationSettingsSubtitle => '朝/夕リマインダー通知のオン/オフ';

  @override
  String get menuBackupSettingsTitle => 'データバックアップ及び復元';

  @override
  String get menuBackupSettingsSubtitle => 'CSVエクスポート、バックアップファイルの入出力';

  @override
  String get menuSecuritySettingsTitle => 'セキュリティ';

  @override
  String get menuSecuritySettingsSubtitle => 'PIN番号、生体認証';

  @override
  String get appNameShort => 'ジュース';

  @override
  String get savingsCardSuccessMessage => '今週のジュースを\n新鮮に守り抜きました!';

  @override
  String get savingsCardOverMessage => '今週のジュースが\n少しあふれました';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return '$budget中$spent消費';
  }

  @override
  String get savingsCardSuccessStamp => '成功';

  @override
  String get savingsCardOverStamp => '奮闘';

  @override
  String get pinSetupTitle => 'パスワード設定';

  @override
  String get biometricUnlockReason => 'ロック解除のため認証してください';

  @override
  String get pinConfirmTitle => 'パスワード確認';

  @override
  String get pinConfirmCurrentTitle => '現在のパスワード確認';

  @override
  String get pinSetupNewTitle => '新しいパスワード設定';

  @override
  String get pinChangedMessage => 'パスワードが変更されました';

  @override
  String get biometricLinkTitle => '生体認証連携';

  @override
  String get biometricLinkConfirm => '生体認証を連携しますか?';

  @override
  String get biometricLinkAction => '連携';

  @override
  String get biometricLinkReason => '生体認証を連携するには認証してください';

  @override
  String get biometricUnavailableMessage => '生体認証を使用できません';

  @override
  String get securityTitle => 'セキュリティ';

  @override
  String get securityDescription => 'PIN番号と生体認証でアプリをロックできます。';

  @override
  String get appLockTitle => 'アプリロック';

  @override
  String get appLockDescription => '4桁のPINでアプリのアクセスを保護します。';

  @override
  String get changePasswordTitle => 'パスワード変更';

  @override
  String get biometricUseTitle => '生体認証を使用';

  @override
  String get biometricUseDescription => 'Face ID/指紋でより早くロック解除。';

  @override
  String get csvShareText => 'ジュース支出履歴';

  @override
  String get backupShareText => 'ジュースデータバックアップ';

  @override
  String backupFailedMessage(Object error) {
    return 'バックアップに失敗しました: $error';
  }

  @override
  String get restoreDataTitle => 'データ復元';

  @override
  String get restoreDataConfirm => '既存のデータがバックアップファイルの内容に置き換わります。続けますか?';

  @override
  String get restoreAction => '復元';

  @override
  String get restoreSuccessMessage => '復元が完了しました';

  @override
  String get restoreFailedMessage => '復元に失敗しました。正しいジュースバックアップファイルか確認してください';

  @override
  String get backupSettingsTitle => 'データバックアップ及び復元';

  @override
  String get exportExpensesTitle => '支出履歴のエクスポート';

  @override
  String get exportExpensesDescription => '日付、カテゴリ、金額、固定費有無、メモが入ったCSVファイルを共有します。';

  @override
  String get exportingCsv => 'エクスポート中...';

  @override
  String get exportCsvButton => 'CSVでエクスポート';

  @override
  String get backupRestoreTitle => 'データバックアップ・復元';

  @override
  String get backupRestoreDescription => '支出・収入履歴、カテゴリ、予算設定を1つのファイルでバックアップ・復元できます。';

  @override
  String get backupDataTitle => 'データバックアップ';

  @override
  String get backupDataDescription => '共有シートを通してファイルアプリやメールなどに保存します。';

  @override
  String get restoreDataTileTitle => 'データ復元';

  @override
  String get restoreDataTileDescription => 'バックアップファイルを選んで既存データを上書きします。';

  @override
  String get categoryDefaultDescription => '私だけの特別なジュースレシピ';

  @override
  String get categoryDeleteTitle => 'カテゴリ削除';

  @override
  String categoryDeleteConfirm(Object name) {
    return '\'$name\'カテゴリを削除しますか?\n既に記録された支出履歴は保持されます。';
  }

  @override
  String get categoryInUseMessage => 'このカテゴリを使用中の記録があります。先に別のカテゴリに移してから削除してください';

  @override
  String get categoryEditTitle => 'カテゴリ編集';

  @override
  String get categoryAddTitle => 'カテゴリ追加';

  @override
  String get categoryNameLabel => 'カテゴリ名';

  @override
  String get categoryDescriptionLabel => '一言説明';

  @override
  String get colorLabel => '色';

  @override
  String get iconLabel => 'アイコン';

  @override
  String get categoryManageTitle => 'カテゴリ管理';

  @override
  String get expenseCategoryTab => '支出カテゴリ';

  @override
  String get incomeCategoryTab => '収入カテゴリ';

  @override
  String get defaultCategoryUndeletable => 'デフォルトカテゴリは削除できません';

  @override
  String get cardDeleteTitle => 'カード削除';

  @override
  String cardDeleteConfirm(Object name) {
    return '\'$name\'カードを削除しますか?\n既に記録された支出履歴は保持されます。';
  }

  @override
  String get cardEditTitle => 'カード編集';

  @override
  String get cardAddTitle => 'カード追加';

  @override
  String get cardNameLabel => 'カード名';

  @override
  String get cardTypeLabel => 'カード種類';

  @override
  String get cardManagementTitle => 'マイカード管理';

  @override
  String get defaultCardUndeletable => 'デフォルトカードは削除できません';

  @override
  String get cardTypeCorporate => '法人/業務用';

  @override
  String get cardTypeCorporateExcluded => '法人(経費)・ジュース除外';

  @override
  String get juiceThemeLabel => 'ジューステーマ';

  @override
  String get themeSettingsTitle => 'テーマ設定';

  @override
  String get screenModeLabel => '画面モード';

  @override
  String get themeModeSystem => 'システム';

  @override
  String get themeModeLight => 'ライト';

  @override
  String get themeModeDark => 'ダーク';

  @override
  String get juiceThemeDescription => '残量に応じて色が変わるホーム画面のジュース色を選んでください。アプリ全体のアクセントカラーにも反映されます。';

  @override
  String get themeOrange => 'オレンジ';

  @override
  String get themeStrawberry => 'いちご';

  @override
  String get themeApple => 'りんご';

  @override
  String get themeGrape => 'ぶどう';

  @override
  String get themeBlueberry => 'ブルーベリー';

  @override
  String get themeMulberry => '桑の実';

  @override
  String get themeRandom => 'ランダム(アプリ起動ごと)';

  @override
  String get widgetSettingsTitle => 'ウィジェット設定';

  @override
  String get homeScreenWidgetTitle => 'ホーム画面ウィジェット';

  @override
  String get homeScreenWidgetDescription => 'ホーム画面にジュースゲージウィジェットとクイック入力ウィジェットを追加できます。';

  @override
  String get hideWidgetAmountTitle => 'ウィジェットで金額を隠す';

  @override
  String get hideWidgetAmountDescription => '金額の代わりに***mLと残量%のみ表示します。';

  @override
  String get notificationSettingsTitle => '通知設定';

  @override
  String get notificationScheduleDescription => '毎朝7時、夜8時に記録を促す通知を送ります。';

  @override
  String get receiveNotificationsTitle => 'ジュース通知を受け取る';

  @override
  String get receiveNotificationsDescription => '長く接続しないと再訪を促す通知も一緒に送ります。';

  @override
  String get navHome => 'ホーム';

  @override
  String get navCalendar => 'カレンダー';

  @override
  String get navAssets => '資産';

  @override
  String get navStats => '統計';

  @override
  String get navSettings => '設定';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 今日の分割払い額: $amount mL';
  }

  @override
  String get filterVariableOnlyLong => '変動費のみ表示';

  @override
  String get filterAllLong => '全内訳表示';

  @override
  String noGoalTitle(Object period) {
    return '$periodの目標金額がまだありません';
  }

  @override
  String noGoalDescription(Object period) {
    return '目標設定で$periodの目標金額を入力してください。';
  }

  @override
  String get goToGoalSettings => '目標設定へ移動';

  @override
  String get noExpensesYet => 'まだ記録された支出がありません';

  @override
  String remainingJuiceLabel(Object period) {
    return '$period残っているジュース';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '消費率$percent%';
  }

  @override
  String get overBudgetMessage1 => '残念!来週こそジュースを残しましょう🍊';

  @override
  String get overBudgetMessage2 => 'ジュース入れが空っぽです!今週は少し休みましょう🥲';

  @override
  String get overBudgetMessage3 => 'あふれたジュースは仕方ない!来週また満タンにしましょう🧃';

  @override
  String get overBudgetMessage4 => '最後の一滴まで!来週は少しゆっくり飲みましょう✨';

  @override
  String get incomeFallbackName => '収入';

  @override
  String get unknownCategoryName => '不明';

  @override
  String get fixedExpenseLabel => '固定費';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return '分割$index/$months';
  }

  @override
  String get deletedMessage => '削除されました';

  @override
  String get undoAction => '元に戻す';

  @override
  String get amountAndCategoryRequired => '金額とカテゴリを確認してください';

  @override
  String get expenseLabel => '支出';

  @override
  String get incomeLabel => '収入';

  @override
  String editTypeTitle(Object type) {
    return '$typeの編集';
  }

  @override
  String addTypeTitle(Object type) {
    return '$typeの追加';
  }

  @override
  String deleteTypeTitle(Object type) {
    return '$typeの削除';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return 'この$type履歴を削除しますか?';
  }

  @override
  String get splitBillAutoFillHelper => '下で総額と人数を入力すると自動的に入力されます';

  @override
  String get cardSelectLabel => 'カード選択';

  @override
  String installmentEditNotice(Object index, Object months) {
    return '分割$index/$months回目 — 他の回の金額は一緒に変わりません';
  }

  @override
  String get lumpSumLabel => '一括払い';

  @override
  String monthsPresetLabel(Object months) {
    return '$monthsヶ月';
  }

  @override
  String get customInputLabel => '直接入力';

  @override
  String get monthsCountHint => 'ヶ月数(2〜24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return '毎月${amount}mLずつ$months回に分けて反映されます';
  }

  @override
  String get totalPaymentAmountLabel => '総決済金額';

  @override
  String get splitPeopleCountLabel => '一緒にいた人数';

  @override
  String peopleCountSuffix(Object count) {
    return '$count人';
  }

  @override
  String splitBillHint(Object amount, Object total, Object count) {
    return '私が払うジュース: ${amount}mL (総${total}mL ÷ $count人)';
  }

  @override
  String splitBillMemoTag(Object total, Object count) {
    return '(総${total}mL / $count人で割り勘)';
  }

  @override
  String get memoHint => 'メモ(任意)';

  @override
  String get excludeAsFixedTitle => '固定費として除外';

  @override
  String get excludeAsFixedSubtitle => '家賃、保険料など — ジュースゲージに反映されません';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return '\'$category\'収入${amount}mLが入りました!💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return '\'$category\'支出${amount}mLを記録しました!🍊';
  }

  @override
  String get calendarTitle => 'カレンダー';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return '今月の総支出$expense・総収入$income';
  }

  @override
  String get filterVariableOnlyShort => '変動費のみ';

  @override
  String get filterAllShort => '全内訳';

  @override
  String get noExpenseTodayMessage => '支出のない爽やかな日です!🍊';

  @override
  String get assetsTitle => '資産';

  @override
  String get cumulativeNetWorthLabel => '累積純資産';

  @override
  String get cumulativeNetWorthDescription => 'これまで記録された全収入から支出を引いた値です。';

  @override
  String get scopeThisYear => '今年';

  @override
  String get scopeLast5Years => '過去5年間';

  @override
  String totalIncomeLabel(Object scope) {
    return '$scope総収入';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return '$scope総支出';
  }

  @override
  String get netChangeTrendTitle => '純増減推移';

  @override
  String get netChangeTrendDescription => '収入から支出を引いた純増減です。緑は黒字、赤は赤字です。';

  @override
  String get statsTitle => '統計';

  @override
  String get filterFixedIncluded => '固定費含む';

  @override
  String get totalExpenseTitle => '総支出';

  @override
  String get categorySpendingTitle => 'カテゴリ別消費';

  @override
  String get paymentMethodSpendingTitle => '決済手段別消費';

  @override
  String get statsPeriodThisWeek => '今週';

  @override
  String get statsPeriodThisMonth => '今月';

  @override
  String get statsPeriodLast4Weeks => '直近4週間';

  @override
  String get statsPeriodMonthly => '月別';

  @override
  String get statsPeriodYearly => '年別';

  @override
  String get cardStatsViewSummary => '大分類要約';

  @override
  String get cardStatsViewByCard => 'カード別詳細';

  @override
  String get noExpensesInPeriod => 'この期間に記録がありません';

  @override
  String get installmentIncludedSuffix => '分割払い含む';

  @override
  String get cardUnassigned => 'カード未指定';

  @override
  String get fillJuiceButton => 'ジュースを満たす';

  @override
  String get finishWizardButton => 'このレシピでジュースを始める';

  @override
  String get incomeStepQuestion => '毎月入ってくるジュース(月収入)は\nいくらですか?';

  @override
  String get incomeStepSubtitle => '税引き後、実際に口座に入る金額を入力してください。';

  @override
  String get wonSuffixSpaced => ' ウォン';

  @override
  String get goalStepQuestion => 'どのくらいの期間、いくら\n貯めたいですか?';

  @override
  String get yearsFieldLabel => '年';

  @override
  String get monthsFieldLabel => 'ヶ月';

  @override
  String get goalAmountFieldLabel => '目標貯蓄金額';

  @override
  String get wonUnit => 'ウォン';

  @override
  String get fixedExpenseStepQuestion => '毎月固定で\n出ていくお金はありますか?';

  @override
  String get fixedExpenseStepSubtitle => '家賃、保険料、通信費などジュース入れに入れない費用です。';

  @override
  String get itemNameHint => '項目名';

  @override
  String get addItemButton => '項目追加';

  @override
  String get resultStepQuestion => '自分だけのジュースプランが\n完成しました!';

  @override
  String get resultNegativeMessage => '固定費と貯蓄額が収入より多いです😥前のステップに戻って目標や期間を調整してみてください。';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return '月収入$incomeウォン - 固定費$fixedウォン - 月貯蓄額を引くと、';
  }

  @override
  String get resultWeeklyPrefix => '今週 ';

  @override
  String get resultWeeklySuffix => 'のジュースが飲めます!🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '1日${daily}mL・1ヶ月${monthly}mL';
  }

  @override
  String get periodDaily => '今日';

  @override
  String get periodWeekly => '今週';

  @override
  String get periodMonthly => '今月';

  @override
  String get periodSettingDaily => '毎日';

  @override
  String get periodSettingWeekly => '毎週';

  @override
  String get periodSettingMonthly => '毎月';

  @override
  String get weekStartMonday => '月曜始まり(月〜日)';

  @override
  String get weekStartSunday => '日曜始まり(日〜土)';

  @override
  String get installmentModeMonthlyLabel => '翌月1日一括請求';

  @override
  String get installmentModeDailyLabel => '毎日均等分割請求';

  @override
  String get installmentModeMonthlyDescription => '実際のカード代金のように、分割払い金額が毎月1日に一括で支出として計上されます。';

  @override
  String get installmentModeDailyDescription => 'その月の分割払い金額を日数で割って、毎日少しずつジュースゲージから減っていきます。';

  @override
  String get splashOrangeSubText => '爽やかに満たす今週の予算';

  @override
  String get splashGreenAppleSubText => 'みずみずしく節約する消費習慣';

  @override
  String get splashGrapeSubText => '甘く守り抜く自分だけの限度';

  @override
  String get splashStrawberrySubText => '気持ちよく満たされる一日';

  @override
  String get confirmNewPinPrompt => '新しいパスワードを再入力してください';

  @override
  String get enterCurrentPinPrompt => '現在のパスワードを入力してください';

  @override
  String get enterNewPinPrompt => '新しいパスワードを入力してください';

  @override
  String get enterPinPrompt => 'パスワードを入力してください';

  @override
  String get juiceLockTitle => 'ジュースがロックされています';

  @override
  String get pinConfirmMismatchError => 'パスワードが一致しません。もう一度入力してください';

  @override
  String get pinMismatchError => 'パスワードが一致しません';

  @override
  String get shareCardText => '私のジュース節約カード';

  @override
  String get unlockJuiceReason => 'ジュースのロックを解除するには認証してください';

  @override
  String get unlockWithBiometrics => '生体認証でロック解除';

  @override
  String yearsPresetLabel(Object years) {
    return '$years年';
  }

  @override
  String get settingsLanguage => '言語設定';

  @override
  String get settingsCurrency => '基準通貨の設定';

  @override
  String get currencySelectTitle => '通貨単位を選んでください';

  @override
  String get commonDone => '完了';

  @override
  String get currencyNameKrw => '韓国ウォン (₩)';

  @override
  String get currencyNameUsd => '米ドル (\$)';

  @override
  String get currencyNameJpy => '日本円 (¥)';

  @override
  String get currencyNameEur => 'ユーロ (€)';

  @override
  String get currencyNameVnd => 'ベトナムドン (₫)';

  @override
  String get foreignCurrencyPickerTitle => '決済通貨を選択';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted(本日のレート: $rate)';
  }

  @override
  String get exchangeRateLoadingMessage => 'レート取得中...';

  @override
  String get exchangeRateFailedMessage => 'レートを取得できませんでした。手動入力するか、直前のレートを使ってください';

  @override
  String get manualRateEntryToggle => 'レートを手動入力';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => '再試行';

  @override
  String get commonConfirm => '確認';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return '基準通貨を$toCodeに変更しますか?これまで記録したすべての金額が現在のレートで自動的に換算されます。';
  }

  @override
  String get currencyMigrationLoadingMessage => '既存の家計簿データを新しい通貨に合わせて換算しています... 🍊';

  @override
  String get currencyMigrationFailedMessage => 'レートを取得できず、既存の金額はそのまま維持されます';

  @override
  String get category_food_name => '食費';

  @override
  String get category_food_desc => '今日を潤す美味しいエネルギー 🍱';

  @override
  String get category_cafe_name => 'カフェ・間食';

  @override
  String get category_cafe_desc => '気分が上がるデザートのひとさじ ☕️';

  @override
  String get category_transport_name => '交通費';

  @override
  String get category_transport_desc => '目的地までの快適な移動 🚌';

  @override
  String get category_shopping_name => 'ショッピング';

  @override
  String get category_shopping_desc => '自分を満たすお買い物の楽しみ 🛍️';

  @override
  String get category_culture_name => '趣味・娯楽';

  @override
  String get category_culture_desc => '心を潤す甘い休息 🎬';

  @override
  String get category_life_name => '日用品・生活';

  @override
  String get category_life_desc => '心地よい毎日のためのひと工夫 🧼';

  @override
  String get category_etc_name => 'その他';

  @override
  String get category_etc_desc => '暮らしを彩るさまざまな消費 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return '守ったジュース +$amount mL';
  }

  @override
  String get savingHistoryTitle => '節約記録';

  @override
  String get savingHistoryEmpty => 'まだ締め切られた周期がありません。\n最初の周期を達成してみましょう!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '+$amount mL 節約成功!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return '$amount mL 使いすぎ';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return '目標$target / 消費$spent';
  }

  @override
  String get savingOptionTitle => '余ったジュースの処理方法';

  @override
  String get savingOptionDescription => '周期が終わったとき、余った目標量をどう使うか選んでください。';

  @override
  String get savingOptionRollover => '次の周期へ繰り越す';

  @override
  String get savingOptionSavings => '非常用資金として積み立てる';

  @override
  String get savedJuiceStoreTooltip => '守ったジュース倉庫';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return '守ったジュース: $amount mL ($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return '前周期からの繰り越し+$amount mL含む';
  }

  @override
  String get savingsAssetCardTitle => '節約で守った資産';

  @override
  String get savingsAssetCardDescription => '貯蓄オプションで締め切られた周期の余ったジュースの累計です。';

  @override
  String get savingPraise_1 => 'もうこんなに貯蓄できました！素晴らしい！目標に一歩近づいています 🍊';

  @override
  String get savingPraise_2 => '大切なジュースを新鮮に守り抜きました！あなたの節約習慣が輝いています ✨';

  @override
  String get savingPraise_3 => '少しずつ集まったジュースが心強い資産になっています！今日もファイト 🧃';

  @override
  String get savingPraise_4 => '節約も素敵な習慣！ジュースの残高が増えるほど心にも余裕が生まれます 🍯';

  @override
  String get savingPraise_5 => 'ぶれずに目標を守り抜いたあなた！次のジュースも爽快に守りましょう 🍏';

  @override
  String get savingsLabel => '貯蓄';

  @override
  String get savingsCategoryTab => '貯蓄カテゴリ';

  @override
  String get category_savings_bank_name => '貯蓄';

  @override
  String get category_savings_bank_desc => 'コツコツ積み上がるまとまったお金 🏦';

  @override
  String get category_savings_invest_name => '投資/株式';

  @override
  String get category_savings_invest_desc => '明日のために植える果実の種 📈';

  @override
  String get category_savings_housing_name => '住宅請約貯蓄';

  @override
  String get category_savings_housing_desc => '甘いマイホームの夢 🏠';

  @override
  String get category_savings_isa_name => 'ISA/節税口座';

  @override
  String get category_savings_isa_desc => '頼もしい万能節税ポケット 🛡️';

  @override
  String get category_savings_emergency_name => '非常金';

  @override
  String get category_savings_emergency_desc => 'いつでも頼れるクッション 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return '\'$category\' 貯蓄 $amount mLを記録しました！🌱';
  }

  @override
  String get statsTotalIncomeTitle => '総収入';

  @override
  String get statsTotalSavingsTitle => '総貯蓄';

  @override
  String get incomeCategoryTitleStats => 'カテゴリ別収入';

  @override
  String get savingsCategoryTitleStats => 'カテゴリ別貯蓄';

  @override
  String get savingsOverviewSectionTitle => '🌱 貯蓄・投資の状況';

  @override
  String get savingsThisMonthTotalLabel => '今月の総貯蓄・投資額';

  @override
  String get savingsOverviewEmptyMessage => 'まだ記録された貯蓄・投資がありません';

  @override
  String get scopeThisMonth => '今月';

  @override
  String get calendarAmountModeCompact => '省略形';

  @override
  String get calendarAmountModeFull => '全額表示';

  @override
  String get savingsAllTimeTotalLabel => '累計 貯蓄・投資額';

  @override
  String get currencyWarningNotice => 'リアルタイムの為替レートで再計算されるため、過去のデータにわずかな差異が生じる場合があります。必要な場合のみ変更してください。';

  @override
  String get onboardingStep1Title => '無理なく使える生活費予算を決めましょう';

  @override
  String get onboardingBudgetLabelDaily => '1日の予算';

  @override
  String get onboardingBudgetLabelWeekly => '今週の予算';

  @override
  String get onboardingBudgetLabelMonthly => '今月の予算';

  @override
  String get onboardingStep1NextButton => '次へ: 長期目標を決める (1/2)';

  @override
  String get onboardingFooterHint => '設定からいつでも自由に変更できます!';

  @override
  String get onboardingStep2Title => '数年後のための貯蓄目標はありますか?';

  @override
  String get onboardingStep2Subtitle => '目標を決めると、毎月貯めるべき金額と使えるジュースを賢く計算します。';

  @override
  String get onboardingDurationLabel => '目標期間';

  @override
  String get onboardingGoalAmountLabel => '目標金額';

  @override
  String get onboardingCompleteButton => '目標を設定して始める';

  @override
  String get onboardingSkipButton => '今はスキップする';

  @override
  String get commonBack => '戻る';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return 'ジュース(mL)はあなたが使えるお金です!(1$symbol = 1 mL)';
  }

  @override
  String get customDuration => '直接設定';

  @override
  String get yearUnit => '年';

  @override
  String get monthUnit => 'ヶ月';

  @override
  String totalDurationLabel(Object months) {
    return '計 $monthsヶ月間';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return '$monthsヶ月間、毎月約$amountずつ貯めれば達成できます! 🌱';
  }

  @override
  String get onboardingChooseGoalType => 'どちらの目標から始めますか?';

  @override
  String get onboardingShortTermTitle => '気軽な短期生活費予算';

  @override
  String get onboardingShortTermDesc => '今日、今週、今月に飲むジュースの量を決めて気軽に支出を管理します。';

  @override
  String get onboardingLongTermTitle => '頼もしい中長期貯蓄目標';

  @override
  String get onboardingLongTermDesc => '数年後に達成したいまとまった目標金額を決めて賢く貯めていきます。';

  @override
  String get startWithJuice => 'ジュースを満たして始める';

  @override
  String get startWithLongPlan => 'プランを保存して始める';

  @override
  String get category_income_salary_name => '給料';

  @override
  String get category_income_salary_desc => '汗と涙の甘い結晶 💼';

  @override
  String get category_income_side_name => '副収入/アルバイト';

  @override
  String get category_income_side_desc => 'じんわり貯まるボーナス蜜 🍯';

  @override
  String get category_income_allowance_name => 'お小遣い';

  @override
  String get category_income_allowance_desc => 'うれしいサプライズギフト 🎁';

  @override
  String get category_income_finance_name => '金融所得(利子/配当)';

  @override
  String get category_income_finance_desc => 'お金がお金を稼いできた果実 📈';

  @override
  String get category_income_etc_name => 'その他収入';

  @override
  String get category_income_etc_desc => 'その他の彩り豊かな収入 💧';
}
