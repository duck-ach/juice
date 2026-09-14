import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Juice Budget';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get setBudgetTitle => 'Dein Juice-Budget festlegen';

  @override
  String get weeklyBudget => 'Verbleibender Juice diese Woche';

  @override
  String get paymentCheckCard => 'Debitkarte';

  @override
  String get paymentCreditCard => 'Kreditkarte';

  @override
  String get paymentCash => 'Bar · Überweisung';

  @override
  String get paymentSplitBill => 'Rechnung teilen';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get commonAdd => 'Hinzufügen';

  @override
  String get commonNext => 'Weiter';

  @override
  String get goalSettingsTitle => 'Zieleinstellungen';

  @override
  String get activePeriodSectionTitle => 'Aktiver Zielzeitraum';

  @override
  String get activePeriodSectionDescription => 'Der Zeitraum, auf dem die Startbildschirm-Anzeige basiert. Fülle unten die Zielbeträge für jeden Zeitraum aus, damit sie beim Wechsel sofort übernommen werden.';

  @override
  String get weekStartDayTileTitle => 'Wochenbeginn';

  @override
  String get periodTargetSectionTitle => 'Zielbetrag pro Zeitraum';

  @override
  String get periodTargetSectionDescription => 'Speichere für jeden Zeitraum einen eigenen Zielbetrag und wähle ihn bei Bedarf aus.';

  @override
  String get periodTargetAmountSuffix => 'Zielbetrag';

  @override
  String get installmentSectionTitle => 'Ratenzahlungs-Berücksichtigung';

  @override
  String get installmentSectionDescription => 'Wähle, wann und wie Ratenzahlungen im Kalender/Juice-Anzeige berücksichtigt werden.';

  @override
  String get recommendedSuffix => 'Empfohlen';

  @override
  String get savingsPlanSectionTitle => 'Mittel-/langfristiger Sparplaner';

  @override
  String get savingsPlanSectionDescription => 'Gib dein monatliches Einkommen, Fixkosten und Sparziel ein, um zu berechnen, wie viel Juice du ausgeben kannst.';

  @override
  String get savingsPlanToggleTitle => 'Hast du ein mittel-/langfristiges Sparziel?';

  @override
  String get autoBudgetSetMessage => 'Tages-/Wochen-/Monatsziel automatisch festgelegt 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 Meine Juice-Plan-Übersicht';

  @override
  String get replanButton => 'Plan neu erstellen';

  @override
  String get applyBudgetButton => 'Juice mit diesem Budget automatisch einstellen';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years J. $months M.';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years Jahre';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months Monate';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return 'Ziel: $amount Won in $duration sparen';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return 'Fixkosten (unvermeidlich): $amount Won/Monat';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return 'Empfohlener Juice: $daily mL/Tag · $weekly mL/Woche · $monthly mL/Monat';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get savingsCardSectionTitle => 'Spar-Karte dieser Woche';

  @override
  String get savingsCardSectionDescription => 'Teile eine erfolgreiche Budget-Woche als Karte.';

  @override
  String get generatingCard => 'Karte wird erstellt …';

  @override
  String get shareCardButton => 'Karte teilen';

  @override
  String get setTargetAmountFirst => 'Bitte zuerst einen Zielbetrag festlegen';

  @override
  String get menuGoalSettingsTitle => 'Zieleinstellungen';

  @override
  String get menuGoalSettingsSubtitle => 'Langfristiges Sparziel, Zielzeitraum, Zielbetrag pro Zeitraum';

  @override
  String get menuThemeSettingsTitle => 'Design-Einstellungen';

  @override
  String get menuThemeSettingsSubtitle => 'Bildschirmmodus und Juice-Design';

  @override
  String get menuWidgetSettingsTitle => 'Widget-Einstellungen';

  @override
  String get menuWidgetSettingsSubtitle => 'Betrag im Homescreen-Widget ausblenden';

  @override
  String get menuCardManagementTitle => 'Kartenverwaltung';

  @override
  String get menuCardManagementSubtitle => 'Karten registrieren, Reihenfolge ändern';

  @override
  String get menuNotificationSettingsTitle => 'Benachrichtigungseinstellungen';

  @override
  String get menuNotificationSettingsSubtitle => 'Morgen-/Abenderinnerungen ein-/ausschalten';

  @override
  String get menuBackupSettingsTitle => 'Datensicherung & Wiederherstellung';

  @override
  String get menuBackupSettingsSubtitle => 'CSV-Export, Backup-Datei exportieren/importieren';

  @override
  String get menuSecuritySettingsTitle => 'Sicherheit';

  @override
  String get menuSecuritySettingsSubtitle => 'PIN-Code, biometrische Authentifizierung';

  @override
  String get appNameShort => 'Juice';

  @override
  String get savingsCardSuccessMessage => 'Du hast den Juice\ndiese Woche frisch gehalten!';

  @override
  String get savingsCardOverMessage => 'Der Juice ist diese\nWoche etwas übergelaufen';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return '$spent von $budget ausgegeben';
  }

  @override
  String get savingsCardSuccessStamp => 'ERFOLG';

  @override
  String get savingsCardOverStamp => 'WEITER SO';

  @override
  String get pinSetupTitle => 'Passwort festlegen';

  @override
  String get biometricUnlockReason => 'Authentifiziere dich, um zu entsperren';

  @override
  String get pinConfirmTitle => 'Passwort bestätigen';

  @override
  String get pinConfirmCurrentTitle => 'Aktuelles Passwort bestätigen';

  @override
  String get pinSetupNewTitle => 'Neues Passwort festlegen';

  @override
  String get pinChangedMessage => 'Passwort geändert';

  @override
  String get biometricLinkTitle => 'Biometrie verknüpfen';

  @override
  String get biometricLinkConfirm => 'Möchtest du die biometrische Authentifizierung verknüpfen?';

  @override
  String get biometricLinkAction => 'Verknüpfen';

  @override
  String get biometricLinkReason => 'Authentifiziere dich, um die Biometrie zu verknüpfen';

  @override
  String get biometricUnavailableMessage => 'Biometrische Authentifizierung nicht verfügbar';

  @override
  String get securityTitle => 'Sicherheit';

  @override
  String get securityDescription => 'Sperre die App mit PIN oder Biometrie.';

  @override
  String get appLockTitle => 'App-Sperre';

  @override
  String get appLockDescription => 'Schütze den App-Zugriff mit einer 4-stelligen PIN.';

  @override
  String get changePasswordTitle => 'Passwort ändern';

  @override
  String get biometricUseTitle => 'Biometrie verwenden';

  @override
  String get biometricUseDescription => 'Schneller entsperren mit Face ID/Fingerabdruck.';

  @override
  String get csvShareText => 'Juice-Ausgabenverlauf';

  @override
  String get backupShareText => 'Juice-Datensicherung';

  @override
  String backupFailedMessage(Object error) {
    return 'Sicherung fehlgeschlagen: $error';
  }

  @override
  String get restoreDataTitle => 'Daten wiederherstellen';

  @override
  String get restoreDataConfirm => 'Vorhandene Daten werden durch die Sicherungsdatei ersetzt. Fortfahren?';

  @override
  String get restoreAction => 'Wiederherstellen';

  @override
  String get restoreSuccessMessage => 'Wiederherstellung abgeschlossen';

  @override
  String get restoreFailedMessage => 'Wiederherstellung fehlgeschlagen. Bitte prüfe, ob es eine gültige Juice-Sicherungsdatei ist';

  @override
  String get backupSettingsTitle => 'Datensicherung & Wiederherstellung';

  @override
  String get exportExpensesTitle => 'Ausgabenverlauf exportieren';

  @override
  String get exportExpensesDescription => 'Teile eine CSV-Datei mit Datum, Kategorie, Betrag, Fixkosten-Status und Notiz.';

  @override
  String get exportingCsv => 'Wird exportiert …';

  @override
  String get exportCsvButton => 'Als CSV exportieren';

  @override
  String get backupRestoreTitle => 'Datensicherung · Wiederherstellung';

  @override
  String get backupRestoreDescription => 'Sichere und stelle Ausgaben, Einnahmen, Kategorien und Budgeteinstellungen in einer Datei wieder her.';

  @override
  String get backupDataTitle => 'Daten sichern';

  @override
  String get backupDataDescription => 'Speichere über das Teilen-Menü in Dateien, E-Mail usw.';

  @override
  String get restoreDataTileTitle => 'Daten wiederherstellen';

  @override
  String get restoreDataTileDescription => 'Wähle eine Sicherungsdatei, um vorhandene Daten zu überschreiben.';

  @override
  String get categoryDefaultDescription => 'Mein besonderes Juice-Rezept';

  @override
  String get categoryDeleteTitle => 'Kategorie löschen';

  @override
  String categoryDeleteConfirm(Object name) {
    return '\'$name\' Kategorie löschen?\nBereits erfasste Ausgaben bleiben erhalten.';
  }

  @override
  String get categoryInUseMessage => 'Einige Einnahmen verwenden diese Kategorie. Verschiebe sie zuerst, bevor du löschst.';

  @override
  String get categoryEditTitle => 'Kategorie bearbeiten';

  @override
  String get categoryAddTitle => 'Kategorie hinzufügen';

  @override
  String get categoryNameLabel => 'Kategoriename';

  @override
  String get categoryDescriptionLabel => 'Kurzbeschreibung';

  @override
  String get colorLabel => 'Farbe';

  @override
  String get iconLabel => 'Symbol';

  @override
  String get categoryManageTitle => 'Kategorienverwaltung';

  @override
  String get expenseCategoryTab => 'Ausgabenkategorien';

  @override
  String get incomeCategoryTab => 'Einnahmenkategorien';

  @override
  String get defaultCategoryUndeletable => 'Standardkategorien können nicht gelöscht werden';

  @override
  String get cardDeleteTitle => 'Karte löschen';

  @override
  String cardDeleteConfirm(Object name) {
    return '\'$name\' Karte löschen?\nBereits erfasste Ausgaben bleiben erhalten.';
  }

  @override
  String get cardEditTitle => 'Karte bearbeiten';

  @override
  String get cardAddTitle => 'Karte hinzufügen';

  @override
  String get cardNameLabel => 'Kartenname';

  @override
  String get cardTypeLabel => 'Kartentyp';

  @override
  String get cardManagementTitle => 'Kartenverwaltung';

  @override
  String get defaultCardUndeletable => 'Standardkarten können nicht gelöscht werden';

  @override
  String get cardTypeCorporate => 'Firmen-/Geschäftskarte';

  @override
  String get cardTypeCorporateExcluded => 'Firma (Spesen) · vom Juice ausgeschlossen';

  @override
  String get juiceThemeLabel => 'Juice-Design';

  @override
  String get themeSettingsTitle => 'Design-Einstellungen';

  @override
  String get screenModeLabel => 'Bildschirmmodus';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Hell';

  @override
  String get themeModeDark => 'Dunkel';

  @override
  String get juiceThemeDescription => 'Wähle die Juice-Farbe, die sich je nach Restbetrag ändert. Sie wird auch zur Akzentfarbe der App.';

  @override
  String get themeOrange => 'Orange';

  @override
  String get themeStrawberry => 'Erdbeere';

  @override
  String get themeApple => 'Apfel';

  @override
  String get themeGrape => 'Traube';

  @override
  String get themeBlueberry => 'Blaubeere';

  @override
  String get themeMulberry => 'Maulbeere';

  @override
  String get themeRandom => 'Zufällig (bei jedem App-Start)';

  @override
  String get widgetSettingsTitle => 'Widget-Einstellungen';

  @override
  String get homeScreenWidgetTitle => 'Homescreen-Widget';

  @override
  String get homeScreenWidgetDescription => 'Du kannst ein Juice-Anzeige-Widget und ein Schnelleingabe-Widget zum Startbildschirm hinzufügen.';

  @override
  String get hideWidgetAmountTitle => 'Betrag im Widget ausblenden';

  @override
  String get hideWidgetAmountDescription => 'Zeigt statt des Betrags nur ***mL und den Rest-% an.';

  @override
  String get notificationSettingsTitle => 'Benachrichtigungseinstellungen';

  @override
  String get notificationScheduleDescription => 'Wir senden dir täglich um 7 Uhr und 20 Uhr Erinnerungen zum Eintragen.';

  @override
  String get receiveNotificationsTitle => 'Juice-Benachrichtigungen erhalten';

  @override
  String get receiveNotificationsDescription => 'Wir erinnern dich auch, wenn du die App länger nicht geöffnet hast.';

  @override
  String get navHome => 'Start';

  @override
  String get navCalendar => 'Kalender';

  @override
  String get navAssets => 'Vermögen';

  @override
  String get navStats => 'Statistik';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 Heutiger Ratenanteil: $amount mL';
  }

  @override
  String get filterVariableOnlyLong => 'Nur variable anzeigen';

  @override
  String get filterAllLong => 'Alle anzeigen';

  @override
  String noGoalTitle(Object period) {
    return 'Noch kein Zielbetrag für $period';
  }

  @override
  String noGoalDescription(Object period) {
    return 'Bitte gib in den Zieleinstellungen den Zielbetrag für $period ein.';
  }

  @override
  String get goToGoalSettings => 'Zu den Zieleinstellungen';

  @override
  String get noExpensesYet => 'Noch keine Ausgaben erfasst';

  @override
  String remainingJuiceLabel(Object period) {
    return 'Verbleibender Juice $period';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '$percent% verbraucht';
  }

  @override
  String get overBudgetMessage1 => 'Schade! Nächste Woche klappt\'s mit dem Juice-Sparen 🍊';

  @override
  String get overBudgetMessage2 => 'Der Juice-Krug ist leer! Mach diese Woche eine Pause 🥲';

  @override
  String get overBudgetMessage3 => 'Übergelaufener Juice passiert! Nächste Woche wieder auffüllen 🧃';

  @override
  String get overBudgetMessage4 => 'Bis zum letzten Tropfen! Nächste Woche etwas langsamer genießen ✨';

  @override
  String get incomeFallbackName => 'Einnahme';

  @override
  String get unknownCategoryName => 'Unbekannt';

  @override
  String get fixedExpenseLabel => 'Fixkosten';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return 'Rate $index/$months';
  }

  @override
  String get deletedMessage => 'Gelöscht';

  @override
  String get undoAction => 'Rückgängig';

  @override
  String get amountAndCategoryRequired => 'Bitte Betrag und Kategorie überprüfen';

  @override
  String get expenseLabel => 'Ausgabe';

  @override
  String get incomeLabel => 'Einnahme';

  @override
  String editTypeTitle(Object type) {
    return '$type bearbeiten';
  }

  @override
  String addTypeTitle(Object type) {
    return '$type hinzufügen';
  }

  @override
  String deleteTypeTitle(Object type) {
    return '$type löschen';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return 'Diesen $type-Eintrag löschen?';
  }

  @override
  String get splitBillAutoFillHelper => 'Gib unten Gesamtbetrag und Personenzahl ein, um automatisch auszufüllen';

  @override
  String get cardSelectLabel => 'Karte auswählen';

  @override
  String installmentEditNotice(Object index, Object months) {
    return 'Rate $index/$months — andere Raten ändern sich nicht mit';
  }

  @override
  String get lumpSumLabel => 'Einmalzahlung';

  @override
  String monthsPresetLabel(Object months) {
    return '$months Mon.';
  }

  @override
  String get customInputLabel => 'Eigene Eingabe';

  @override
  String get monthsCountHint => 'Anzahl Monate (2–24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return 'Wird monatlich mit $amount mL über $months Raten berücksichtigt';
  }

  @override
  String get totalPaymentAmountLabel => 'Gesamtzahlungsbetrag';

  @override
  String get splitPeopleCountLabel => 'Anzahl Personen';

  @override
  String peopleCountSuffix(Object count) {
    return '$count Personen';
  }

  @override
  String splitBillHint(Object amount, Object total, Object count) {
    return 'Mein Anteil: $amount mL (gesamt $total mL ÷ $count Personen)';
  }

  @override
  String splitBillMemoTag(Object total, Object count) {
    return '(Gesamt ${total}mL / geteilt durch $count)';
  }

  @override
  String get memoHint => 'Notiz (optional)';

  @override
  String get excludeAsFixedTitle => 'Als Fixkosten ausschließen';

  @override
  String get excludeAsFixedSubtitle => 'Miete, Versicherung usw. — wird nicht in der Juice-Anzeige berücksichtigt';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return '\'$category\' Einnahme von $amount mL erhalten! 💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return '$amount mL für \'$category\' erfasst! 🍊';
  }

  @override
  String get calendarTitle => 'Kalender';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return 'Diesen Monat: $expense ausgegeben · $income eingenommen';
  }

  @override
  String get filterVariableOnlyShort => 'Nur variabel';

  @override
  String get filterAllShort => 'Alle';

  @override
  String get noExpenseTodayMessage => 'Ein erfrischender ausgabenfreier Tag! 🍊';

  @override
  String get assetsTitle => 'Vermögen';

  @override
  String get cumulativeNetWorthLabel => 'Kumuliertes Nettovermögen';

  @override
  String get cumulativeNetWorthDescription => 'Alle bisher erfassten Einnahmen minus Ausgaben.';

  @override
  String get scopeThisYear => 'dieses Jahr';

  @override
  String get scopeLast5Years => 'letzte 5 Jahre';

  @override
  String totalIncomeLabel(Object scope) {
    return 'Gesamteinnahmen ($scope)';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return 'Gesamtausgaben ($scope)';
  }

  @override
  String get netChangeTrendTitle => 'Nettoveränderungstrend';

  @override
  String get netChangeTrendDescription => 'Nettoveränderung = Einnahmen minus Ausgaben. Grün ist Überschuss, Rot ist Defizit.';

  @override
  String get statsTitle => 'Statistik';

  @override
  String get filterFixedIncluded => 'Fixkosten einbeziehen';

  @override
  String get totalExpenseTitle => 'Gesamtausgaben';

  @override
  String get categorySpendingTitle => 'Ausgaben nach Kategorie';

  @override
  String get paymentMethodSpendingTitle => 'Ausgaben nach Zahlungsmethode';

  @override
  String get statsPeriodThisWeek => 'Diese Woche';

  @override
  String get statsPeriodThisMonth => 'Diesen Monat';

  @override
  String get statsPeriodLast4Weeks => 'Letzte 4 Wochen';

  @override
  String get statsPeriodMonthly => 'Monatlich';

  @override
  String get statsPeriodYearly => 'Jährlich';

  @override
  String get cardStatsViewSummary => 'Übersicht';

  @override
  String get cardStatsViewByCard => 'Nach Karte';

  @override
  String get noExpensesInPeriod => 'Keine Ausgaben in diesem Zeitraum';

  @override
  String get installmentIncludedSuffix => 'inkl. Raten';

  @override
  String get cardUnassigned => 'Keine Karte zugewiesen';

  @override
  String get fillJuiceButton => 'Juice auffüllen';

  @override
  String get finishWizardButton => 'Mit diesem Rezept starten';

  @override
  String get incomeStepQuestion => 'Wie viel Juice (Einkommen)\nkommt monatlich rein?';

  @override
  String get incomeStepSubtitle => 'Gib den tatsächlichen Betrag nach Steuern ein.';

  @override
  String get wonSuffixSpaced => ' Won';

  @override
  String get goalStepQuestion => 'Wie lange und wie viel\nmöchtest du sparen?';

  @override
  String get yearsFieldLabel => 'Jahre';

  @override
  String get monthsFieldLabel => 'Monate';

  @override
  String get goalAmountFieldLabel => 'Ziel-Sparbetrag';

  @override
  String get wonUnit => 'Won';

  @override
  String get fixedExpenseStepQuestion => 'Hast du monatliche\nFixkosten?';

  @override
  String get fixedExpenseStepSubtitle => 'Miete, Versicherung, Handyrechnung usw. — nicht im Juice-Krug enthalten.';

  @override
  String get itemNameHint => 'Postenname';

  @override
  String get addItemButton => 'Posten hinzufügen';

  @override
  String get resultStepQuestion => 'Dein eigener Juice-Plan\nist fertig!';

  @override
  String get resultNegativeMessage => 'Fixkosten und Sparbetrag übersteigen das Einkommen 😥 Gehe zurück und passe Ziel oder Dauer an.';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return 'Monatseinkommen $income Won - Fixkosten $fixed Won - monatliche Ersparnis ergibt:';
  }

  @override
  String get resultWeeklyPrefix => 'Diese Woche: ';

  @override
  String get resultWeeklySuffix => ' Juice zum Genießen! 🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '$daily mL/Tag · $monthly mL/Monat';
  }

  @override
  String get periodDaily => 'Heute';

  @override
  String get periodWeekly => 'Diese Woche';

  @override
  String get periodMonthly => 'Diesen Monat';

  @override
  String get periodSettingDaily => 'Täglich';

  @override
  String get periodSettingWeekly => 'Wöchentlich';

  @override
  String get periodSettingMonthly => 'Monatlich';

  @override
  String get weekStartMonday => 'Beginnt Montag (Mo–So)';

  @override
  String get weekStartSunday => 'Beginnt Sonntag (So–Sa)';

  @override
  String get installmentModeMonthlyLabel => 'Vollständige Abrechnung nächsten Monat';

  @override
  String get installmentModeDailyLabel => 'Täglich gleichmäßig abgerechnet';

  @override
  String get installmentModeMonthlyDescription => 'Wie bei einer echten Kartenabrechnung wird der Ratenbetrag einmal am 1. jeden Monats als Ausgabe erfasst.';

  @override
  String get installmentModeDailyDescription => 'Der Ratenbetrag dieses Monats wird durch die Anzahl der Tage geteilt und täglich etwas von der Juice-Anzeige abgezogen.';

  @override
  String get splashOrangeSubText => 'Dieses Wochenbudget, erfrischend gefüllt';

  @override
  String get splashGreenAppleSubText => 'Eine frische Gewohnheit des bewussten Ausgebens';

  @override
  String get splashGrapeSubText => 'Süß bewahrter eigener Grenzwert';

  @override
  String get splashStrawberrySubText => 'Ein angenehm erfüllter Tag';

  @override
  String get confirmNewPinPrompt => 'Bitte gib das neue Passwort erneut ein';

  @override
  String get enterCurrentPinPrompt => 'Bitte gib dein aktuelles Passwort ein';

  @override
  String get enterNewPinPrompt => 'Bitte gib ein neues Passwort ein';

  @override
  String get enterPinPrompt => 'Bitte gib dein Passwort ein';

  @override
  String get juiceLockTitle => 'Juice ist gesperrt';

  @override
  String get pinConfirmMismatchError => 'Passwörter stimmen nicht überein. Bitte erneut versuchen';

  @override
  String get pinMismatchError => 'Passwort stimmt nicht überein';

  @override
  String get shareCardText => 'Meine Juice-Sparkarte';

  @override
  String get unlockJuiceReason => 'Authentifiziere dich, um deinen Juice zu entsperren';

  @override
  String get unlockWithBiometrics => 'Mit Biometrie entsperren';

  @override
  String yearsPresetLabel(Object years) {
    return '$years J.';
  }

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsCurrency => 'Währung';

  @override
  String get currencySelectTitle => 'Wähle deine Währung';

  @override
  String get commonDone => 'Fertig';

  @override
  String get currencyNameKrw => 'Südkoreanischer Won (₩)';

  @override
  String get currencyNameUsd => 'US-Dollar (\$)';

  @override
  String get currencyNameJpy => 'Japanischer Yen (¥)';

  @override
  String get currencyNameEur => 'Euro (€)';

  @override
  String get currencyNameVnd => 'Vietnamesischer Dong (₫)';

  @override
  String get foreignCurrencyPickerTitle => 'Zahlungswährung wählen';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted (Tageskurs: $rate)';
  }

  @override
  String get exchangeRateLoadingMessage => 'Wechselkurs wird abgerufen…';

  @override
  String get exchangeRateFailedMessage => 'Wechselkurs konnte nicht abgerufen werden. Gib ihn manuell ein oder nutze den letzten bekannten Kurs.';

  @override
  String get manualRateEntryToggle => 'Wechselkurs manuell eingeben';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String get commonConfirm => 'Bestätigen';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return 'Basiswährung zu $toCode ändern? Alle bisher erfassten Beträge werden automatisch zum aktuellen Wechselkurs umgerechnet.';
  }

  @override
  String get currencyMigrationLoadingMessage => 'Bestehende Daten werden auf die neue Währung umgerechnet … 🍊';

  @override
  String get currencyMigrationFailedMessage => 'Wechselkurs konnte nicht abgerufen werden, bestehende Beträge bleiben unverändert';

  @override
  String get category_food_name => 'Essen & Trinken';

  @override
  String get category_food_desc => 'Leckere Energie für heute 🍱';

  @override
  String get category_cafe_name => 'Café & Snacks';

  @override
  String get category_cafe_desc => 'Ein süßer Löffel Freude ☕️';

  @override
  String get category_transport_name => 'Transport';

  @override
  String get category_transport_desc => 'Sanfte Fahrt zum Ziel 🚌';

  @override
  String get category_shopping_name => 'Einkaufen';

  @override
  String get category_shopping_desc => 'Freude am Sich-selbst-Verwöhnen 🛍️';

  @override
  String get category_culture_name => 'Kultur & Freizeit';

  @override
  String get category_culture_desc => 'Süße Erholung für die Seele 🎬';

  @override
  String get category_life_name => 'Wohnen & Alltag';

  @override
  String get category_life_desc => 'Frische für den Alltagskomfort 🧼';

  @override
  String get category_etc_name => 'Sonstiges';

  @override
  String get category_etc_desc => 'Bunte Alltagsausgaben 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return 'Geretteter Juice +$amount mL';
  }

  @override
  String get savingHistoryTitle => 'Sparverlauf';

  @override
  String get savingHistoryEmpty => 'Noch kein Zeitraum abgeschlossen.\nSchließe deinen ersten Zeitraum ab!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '+$amount mL gespart!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return '$amount mL überzogen';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return 'Ziel $target / Ausgegeben $spent';
  }
}
