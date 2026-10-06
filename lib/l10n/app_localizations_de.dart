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
  String get defaultCheckCardName => 'Debitkarte (Standard)';

  @override
  String get defaultCreditCardName => 'Kreditkarte (Standard)';

  @override
  String get paymentCash => 'Bar · Überweisung';

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
    return 'Ziel: $amount in $duration sparen';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return 'Fixkosten (unvermeidlich): $amount/Monat';
  }

  @override
  String get savingsPlanMonthlyRequiredLabel => 'Monatlich zu sparender Betrag';

  @override
  String savingsPlanMonthlyRequiredAmount(Object amount) {
    return '$amount';
  }

  @override
  String get savingsPlanAchievementRateLabel => 'Zielerreichung';

  @override
  String get savingsPlanRecommendedSectionLabel => 'Empfohlenes Ausgabenbudget';

  @override
  String get savingsPlanDailyGridLabel => 'Täglich';

  @override
  String get savingsPlanWeeklyGridLabel => 'Diese Woche';

  @override
  String get savingsPlanMonthlyGridLabel => 'Diesen Monat';

  @override
  String get savingsPlanViewInAssetsButton => 'Details im Tab „Vermögen“ ansehen';

  @override
  String savingsPlanActualTraceLine(Object actual, Object goal, Object percent) {
    return 'Tatsächlich gespart: $actual / Ziel $goal ($percent%)';
  }

  @override
  String get manageFixedIncomesButton => 'Festes Einkommen verwalten';

  @override
  String savingsPlanFixedIncomeTotalLine(Object total) {
    return 'Gesamtes festes Einkommen: $total';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return 'Empfohlener Juice: $daily mL/Tag · $weekly mL/Woche · $monthly mL/Monat';
  }

  @override
  String savingsPlanPaceFasterLine(Object months) {
    return 'Bei deinem aktuellen Tempo erreichst du dein Ziel $months Monate früher! 🚀';
  }

  @override
  String savingsPlanPaceSlowerLine(Object months) {
    return 'Bei deinem aktuellen Tempo könntest du $months Monate hinter dem Plan liegen. Du schaffst das 💪';
  }

  @override
  String get savingsPlanPaceOnTrackLine => 'Dein aktuelles Tempo passt genau zum Plan! Mach weiter so 🍊';

  @override
  String get recalibrateButton => 'Einkommensänderung · Neu kalibrieren';

  @override
  String get recalibrateSheetTitle => 'Plan neu kalibrieren';

  @override
  String get recalibrateSheetSubtitle => 'Gib dein neues Monatseinkommen ein und wähle eine von zwei Möglichkeiten, es sofort anzuwenden.';

  @override
  String get recalibrateIncomeFieldLabel => 'Neues Monatseinkommen';

  @override
  String get recalibrateShortenOption => 'Zielzeitraum verkürzen';

  @override
  String recalibrateShortenPreview(Object before, Object after) {
    return 'Dein Budget bleibt gleich, der Zielzeitraum verkürzt sich von $before auf $after Monate.';
  }

  @override
  String get recalibrateShortenUnavailable => 'Mit diesem Einkommen lässt sich der Zeitraum bei gleichem Budget nicht verkürzen.';

  @override
  String get recalibrateBoostOption => 'Juice (Budget) erhöhen';

  @override
  String recalibrateBoostPreview(Object before, Object after) {
    return 'Der Zielzeitraum bleibt gleich, dein tägliches Juice steigt von $before mL auf $after mL.';
  }

  @override
  String get recalibrateBudgetSliderLabel => 'Lebenshaltungsbudget (Juice) für diesen Monat';

  @override
  String get recalibrateWeeklyBudgetLabel => 'Wöchentliches Ziel';

  @override
  String recalibratePreviewLine(Object before, Object after) {
    return 'Bei diesem Budget ändert sich dein Zielzeitraum von $before auf $after Monate';
  }

  @override
  String get recalibrateNoSavingsWarning => 'Bei diesem Budget sparst du diesen Monat nichts. Schiebe den Regler nach links.';

  @override
  String get recalibrateStatGoal => 'Zielbetrag';

  @override
  String get recalibrateStatSaved => 'Bereits gespart';

  @override
  String get recalibrateStatRemaining => 'Verbleibend';

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
  String shareCardFailedMessage(Object error) {
    return 'Karte konnte nicht geteilt werden: $error';
  }

  @override
  String get setTargetAmountFirst => 'Bitte zuerst einen Zielbetrag festlegen';

  @override
  String get menuGoalSettingsTitle => 'Zieleinstellungen';

  @override
  String get menuGoalSettingsSubtitle => 'Langfristiges Sparziel, Zielzeitraum, Zielbetrag pro Zeitraum';

  @override
  String get menuFixedExpenseManagementTitle => 'Feste Ausgaben verwalten';

  @override
  String get menuFixedExpenseManagementSubtitle => 'Feste Ausgabenposten verwalten und Kalender-Autoausfüllung einstellen';

  @override
  String get fixedExpenseManageInfoBanner => 'Verknüpft mit den festen Ausgaben deines mittel-/langfristigen Sparplans – wenn sich diese erhöhen oder verringern, kann sich dein verfügbares Tages-/Wochen-/Monatsbudget ändern.';

  @override
  String get fixedExpensePaymentDayLabel => 'Zahltag';

  @override
  String fixedExpenseDayOptionLabel(Object day) {
    return 'Tag $day';
  }

  @override
  String get fixedExpenseLastDayOptionLabel => 'Tag 31 (Monatsletzter)';

  @override
  String get calendarAutoFillTitle => 'Fixkosten automatisch eintragen';

  @override
  String get calendarAutoFillSubtitle => 'Trägt deine hinterlegten Fixkosten jeden Monat automatisch in den Kalender ein';

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
  String get menuContactSupportTitle => 'Kontakt & Feedback';

  @override
  String get menuContactSupportSubtitle => 'Schick uns deine Meinung per E-Mail';

  @override
  String get feedbackTitle => 'Kontakt & Feedback 🍊';

  @override
  String get feedbackTypeBug => 'Fehler melden';

  @override
  String get feedbackTypeFeature => 'Funktionswunsch';

  @override
  String get feedbackTypeOther => 'Sonstiges';

  @override
  String get feedbackEmailHint => 'Deine E-Mail (optional, für eine Antwort)';

  @override
  String get feedbackContentHint => 'Teile uns deine Gedanken mit.';

  @override
  String get feedbackAttachImage => 'Screenshot anhängen';

  @override
  String get feedbackSubmit => 'Senden';

  @override
  String get feedbackDeviceInfoNotice => 'Geräte-/OS-Informationen werden mitgeschickt, damit wir schneller helfen können.';

  @override
  String get feedbackComposeReplyEmail => 'Antwort-E-Mail';

  @override
  String get feedbackComposeNotEntered => '(nicht angegeben)';

  @override
  String get feedbackComposeContent => 'Inhalt';

  @override
  String get feedbackComposeDeviceInfo => 'Geräteinformationen';

  @override
  String get feedbackContentRequired => 'Bitte gib deine Nachricht ein';

  @override
  String get feedbackMailUnavailable => 'Die Mail-App konnte nicht geöffnet werden, daher wurde der Inhalt kopiert.';

  @override
  String get privacyPolicyTitle => 'Datenschutzerklärung';

  @override
  String get menuPrivacyPolicySubtitle => 'So gehen wir mit deinen Daten um';

  @override
  String get privacyWelcomeTitle => 'Willkommen bei Juice Budget!';

  @override
  String get privacyAgreeNotice => 'Juice Budget ist ein zu 100 % lokales Haushaltsbuch auf deinem Gerät — deine Finanz- oder persönlichen Daten werden niemals an einen externen Server gesendet.';

  @override
  String get viewPrivacyPolicy => 'Vollständige Datenschutzerklärung ansehen';

  @override
  String get agreeAndStart => 'Zustimmen & Loslegen';

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
  String get csvHeaderDate => 'Datum';

  @override
  String get csvHeaderCategory => 'Kategorie';

  @override
  String get csvHeaderAmount => 'Betrag';

  @override
  String get csvHeaderIsFixed => 'Fixkosten';

  @override
  String get csvHeaderMemo => 'Notiz';

  @override
  String get csvUnknownCategory => 'Unbekannt';

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
  String get categoryInUseMessage => 'Einige Einträge verwenden diese Kategorie. Verschiebe sie zuerst, bevor du löschst.';

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
  String get defaultCardLastOneUndeletable => 'Dies ist deine einzige Karte dieser Art und kann daher nicht gelöscht werden. Füge zuerst eine weitere hinzu.';

  @override
  String get cardTypeCorporate => 'Firmen-/Geschäftskarte';

  @override
  String get cardTypeCorporateExcluded => 'Firma (Spesen) · vom Juice ausgeschlossen';

  @override
  String get corporateExpenseNotice => '🏢 Geschäftliche Ausgaben werden ohne Kategorieauswahl erfasst und automatisch von deinen persönlichen Ausgaben ausgeschlossen.';

  @override
  String get corporateBadgeLabel => '🏢 Geschäftlich · Ausgeschlossen von privat';

  @override
  String get corporateCardLabel => 'Geschäftskarte';

  @override
  String get corporateMemoRequired => 'Bitte gib für geschäftliche Ausgaben eine Notiz (Zweck) ein';

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
  String get navSettings => 'Optionen';

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
  String get cardSelectLabel => 'Karte auswählen';

  @override
  String installmentMemoSuffix(Object index, Object months) {
    return '(Rate $index/$months)';
  }

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
  String get noExpensesInPeriod => 'Keine Einträge in diesem Zeitraum';

  @override
  String get categoryDetailThisMonthTotal => 'Gesamt diesen Monat';

  @override
  String get categoryDetailMonthlyTrendTitle => 'Monatlicher Verlauf';

  @override
  String get categoryDetailExpenseListTitle => 'Detailübersicht';

  @override
  String get categoryDetailEmptyMessage => 'Noch keine Einträge';

  @override
  String monthlyTotalLabel(Object month) {
    return 'Gesamt $month';
  }

  @override
  String get categoryDetailEmptyMonthMessage => 'Keine Ausgaben in diesem Monat 🍊';

  @override
  String get installmentIncludedSuffix => 'inkl. Raten';

  @override
  String get cardUnassigned => 'Keine Karte zugewiesen';

  @override
  String get fillJuiceButton => 'Juice auffüllen';

  @override
  String get finishWizardButton => 'Mit diesem Rezept starten';

  @override
  String get incomeTypeFixed => 'Festes Einkommen';

  @override
  String get incomeTypeVariable => 'Variables Einkommen';

  @override
  String get incomeTypeAllowance => 'Taschengeld / Startkapital';

  @override
  String get freqMonthly => 'Monatlich';

  @override
  String get freqBiweekly => 'Alle 2 Wochen';

  @override
  String get freqWeekly => 'Wöchentlich';

  @override
  String get questionIncomeFixed => 'Wie viel Juice (Einkommen) kommt monatlich rein? 💰';

  @override
  String get questionIncomeFixedSub => 'Gib den Betrag ein, der tatsächlich auf deinem Konto landet.';

  @override
  String get questionIncomeVariable => 'Wie hoch ist das minimale sichere Einkommen, auch in schwachen Monaten? 💼';

  @override
  String get questionIncomeVariableSub => 'Schätze konservativ, damit der Plan auch in einem schwachen Monat hält.';

  @override
  String get questionWeeklyExpenseVariable => 'Wie viel planst du pro Woche für Lebenshaltungskosten (variable Ausgaben) auszugeben?';

  @override
  String get questionIncomeAllowance => 'Wie viel Taschengeld bekommst du oder hast du schon gespart? 🌱';

  @override
  String get subAllowanceRegular => '🗓️ Regelmäßiges Taschengeld';

  @override
  String get subAllowanceIrregular => '🎲 Unregelmäßiges Taschengeld/Nebenjob';

  @override
  String get questionIrregularMinSave => 'Wie viel kannst du dir sicher sein, jeden Monat mindestens zu sparen? 🪙';

  @override
  String praiseVariablePlan(Object amount) {
    return '🍊 Auf Basis deiner Nebensaison-Mindesteinnahmen kannst du sicher mindestens $amount pro Jahr zurücklegen!\nIn Monaten mit mehr Einkommen kannst du mit Bonus-Juice dein Sparen beschleunigen 🚀';
  }

  @override
  String praiseAllowancePlan(Object amount) {
    return 'Kleine Tropfen ergeben ein Meer! In einem Jahr hast du $amount wunderbaren Juice angespart ✨';
  }

  @override
  String get guideExtendGoalPeriod => 'Sollen wir den Zielzeitraum etwas verlängern, damit du bequem innerhalb deines Taschengelds sparen kannst? 🍊';

  @override
  String freqConversionCaption(Object monthly, Object weekly) {
    return '≈ $monthly/Monat · ca. $weekly/Woche verfügbar 🍊';
  }

  @override
  String get goalStepQuestion => 'Wie lange und wie viel\nmöchtest du sparen?';

  @override
  String get yearsFieldLabel => 'Jahre';

  @override
  String get monthsFieldLabel => 'Monate';

  @override
  String get goalAmountFieldLabel => 'Ziel-Sparbetrag';

  @override
  String get fixedExpenseStepQuestion => 'Hast du monatliche\nFixkosten?';

  @override
  String get fixedExpenseDefaultRent => 'Miete';

  @override
  String get fixedExpenseDefaultCommunication => 'Telefonrechnung';

  @override
  String get fixedExpenseDefaultInsurance => 'Versicherung';

  @override
  String get fixedExpenseDefaultSubscription => 'Abonnements';

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
    return 'Monatseinkommen $income - Fixkosten $fixed - monatliche Ersparnis ergibt:';
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
  String get settingsLanguage => 'Spracheinstellungen';

  @override
  String get settingsCurrency => 'Basiswährung festlegen';

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
  String get currencyNameTwd => 'Neuer Taiwan-Dollar (NT\$)';

  @override
  String get currencyNameCny => 'Chinesischer Yuan (¥)';

  @override
  String get currencyNameBrl => 'Brasilianischer Real (R\$)';

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
  String get commonCopy => 'Kopieren';

  @override
  String linkOpenFailedMessage(Object target) {
    return 'Keine App zum Öffnen gefunden: $target';
  }

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
  String get category_food_name => 'Lebensmittel';

  @override
  String get category_food_desc => 'Köstliche Energie für den Tag 🍱';

  @override
  String get category_cafe_name => 'Café & Snacks';

  @override
  String get category_cafe_desc => 'Eine süße Pause für die Seele ☕️';

  @override
  String get category_transport_name => 'Transport';

  @override
  String get category_transport_desc => 'Bequem ans Ziel kommen 🚌';

  @override
  String get category_shopping_name => 'Shopping';

  @override
  String get category_shopping_desc => 'Kleine Freuden des Alltags 🛍️';

  @override
  String get category_culture_name => 'Freizeit & Kultur';

  @override
  String get category_culture_desc => 'Süße Erholung für den Geist 🎬';

  @override
  String get category_life_name => 'Wohnen & Haushalt';

  @override
  String get category_life_desc => 'Für ein gemütliches Zuhause 🧼';

  @override
  String get category_etc_name => 'Sonstiges';

  @override
  String get category_etc_desc => 'Bunte Ausgaben des Lebens 💬';

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

  @override
  String get savingOptionTitle => 'Umgang mit übrig gebliebenem Juice';

  @override
  String get savingOptionDescription => 'Wähle, was mit deinem ungenutzten Budget am Ende eines Zeitraums passiert.';

  @override
  String get savingOptionRollover => 'Auf nächsten Zeitraum übertragen';

  @override
  String get savingOptionSavings => 'Als Notgroschen ansparen';

  @override
  String get savedJuiceStoreTooltip => 'Juice-Tresor';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return 'Geretteter Juice: $amount mL ($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return 'Enthält +$amount mL aus dem letzten Zeitraum übertragen';
  }

  @override
  String get savingsAssetCardTitle => 'Durch Sparen geschützte Vermögenswerte';

  @override
  String get savingsAssetCardDescription => 'Gesamter übriger Juice aus mit der Sparoption abgeschlossenen Zeiträumen.';

  @override
  String get savingPraise_1 => 'Du hast schon so viel gespart! Großartig!! Du kommst deinem Ziel immer näher 🍊';

  @override
  String get savingPraise_2 => 'Du hast deinen Saft frisch gehalten! Deine Spargewohnheiten glänzen ✨';

  @override
  String get savingPraise_3 => 'Dein gesparter Saft wird zu echtem Vermögen! Weiter so 🧃';

  @override
  String get savingPraise_4 => 'Sparen ist eine tolle Gewohnheit! Je voller dein Saftglas, desto entspannter dein Tag 🍯';

  @override
  String get savingPraise_5 => 'Klasse Leistung! Du hast dein Ziel verteidigt. Lass uns auch das nächste Glas frisch halten 🍏';

  @override
  String get savingsLabel => 'Sparen';

  @override
  String get savingsCategoryTab => 'Sparkategorien';

  @override
  String get category_savings_bank_name => 'Sparen';

  @override
  String get category_savings_bank_desc => 'Ein Notgroschen, der stetig wächst 🏦';

  @override
  String get category_savings_invest_name => 'Investition';

  @override
  String get category_savings_invest_desc => 'Fruchtsamen, gepflanzt für morgen 📈';

  @override
  String get category_savings_housing_name => 'Bausparvertrag';

  @override
  String get category_savings_housing_desc => 'Der süße Traum vom eigenen Zuhause 🏠';

  @override
  String get category_savings_isa_name => 'Altersvorsorge/Depot';

  @override
  String get category_savings_isa_desc => 'Eine verlässliche Allzweck-Steuersparhülle 🛡️';

  @override
  String get category_savings_emergency_name => 'Notgroschen';

  @override
  String get category_savings_emergency_desc => 'Ein Puffer, auf den du dich jederzeit verlassen kannst 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return '\'$category\' Ersparnis von $amount mL erfasst! 🌱';
  }

  @override
  String get statsTotalIncomeTitle => 'Gesamteinnahmen';

  @override
  String get statsTotalSavingsTitle => 'Gesamtersparnisse';

  @override
  String get incomeCategoryTitleStats => 'Einnahmen nach Kategorie';

  @override
  String get savingsCategoryTitleStats => 'Ersparnisse nach Kategorie';

  @override
  String get savingsOverviewSectionTitle => '🌱 Sparen & Investieren';

  @override
  String get savingsThisMonthTotalLabel => 'Insgesamt gespart & investiert diesen Monat';

  @override
  String get savingsOverviewEmptyMessage => 'Noch keine Ersparnisse oder Investitionen erfasst';

  @override
  String get scopeThisMonth => 'diesen Monat';

  @override
  String get calendarSettingsTitle => 'Kalendereinstellungen';

  @override
  String get calendarStartDayLabel => 'Kalenderstart-Tag';

  @override
  String get calendarStartMon => 'Beginn Montag';

  @override
  String get calendarStartSun => 'Beginn Sonntag';

  @override
  String get calendarAmountMode => 'Betragsanzeige';

  @override
  String get calendarCompactAmount => 'Kompakt (z. B. 56 Tsd.)';

  @override
  String get calendarFullAmount => 'Vollständiger Betrag (z. B. 56.000)';

  @override
  String get calendarShowNoSpendStamp => 'Kein-Ausgaben-Stempel anzeigen';

  @override
  String get calendarHighlightWeekend => 'Wochenende farblich hervorheben';

  @override
  String get savingsAllTimeTotalLabel => 'Insgesamt gespart & investiert (gesamt)';

  @override
  String get currencyWarningNotice => 'Beträge werden nach Echtzeitkursen umgerechnet. Dadurch können minimale Rundungsdifferenzen entstehen. Bitte nur bei Bedarf ändern!';

  @override
  String get onboardingStep1Title => 'Leg dein Budget für den Alltag fest';

  @override
  String get onboardingBudgetLabelDaily => 'Tagesbudget';

  @override
  String get onboardingBudgetLabelWeekly => 'Budget dieser Woche';

  @override
  String get onboardingBudgetLabelMonthly => 'Budget dieses Monats';

  @override
  String get onboardingStep1NextButton => 'Weiter: Langfristiges Ziel festlegen (1/2)';

  @override
  String get onboardingFooterHint => 'Du kannst das jederzeit in den Einstellungen ändern!';

  @override
  String get onboardingStep2Title => 'Hast du ein Sparziel für die nächsten Jahre?';

  @override
  String get onboardingStep2Subtitle => 'Leg ein Ziel fest und wir berechnen smart deine monatliche Sparrate und verfügbare Juice-Menge.';

  @override
  String get onboardingDurationLabel => 'Zielzeitraum';

  @override
  String get onboardingGoalAmountLabel => 'Zielbetrag';

  @override
  String get onboardingCompleteButton => 'Ziel festlegen und starten';

  @override
  String get onboardingSkipButton => 'Jetzt überspringen';

  @override
  String get commonBack => 'Zurück';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return 'Juice (mL) ist Geld, das du ausgeben kannst! (1$symbol = 1 mL)';
  }

  @override
  String get customDuration => 'Benutzerdefiniert';

  @override
  String get yearUnit => 'Jahr(e)';

  @override
  String get monthUnit => 'Monat(e)';

  @override
  String totalDurationLabel(Object months) {
    return 'Insgesamt $months Monate';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return 'Spare $months Monate lang monatlich etwa $amount und du erreichst dein Ziel! 🌱';
  }

  @override
  String get onboardingChooseGoalType => 'Mit welchem Ziel möchtest du starten?';

  @override
  String get onboardingShortTermTitle => 'Flexibles Kurzzeit-Budget';

  @override
  String get onboardingShortTermDesc => 'Lege fest, wie viel Saft du heute, diese Woche oder diesen Monat trinken möchtest.';

  @override
  String get onboardingLongTermTitle => 'Solides Sparziel';

  @override
  String get onboardingLongTermDesc => 'Setze dir ein langfristiges Sparziel und baue dein Vermögen planvoll auf.';

  @override
  String get startWithJuice => 'Mit Saft starten';

  @override
  String get startWithLongPlan => 'Plan speichern und starten';

  @override
  String get category_income_salary_name => 'Gehalt';

  @override
  String get category_income_salary_desc => 'Die süße Frucht harter Arbeit 💼';

  @override
  String get category_income_side_name => 'Bonus';

  @override
  String get category_income_side_desc => 'Ein süßer Bonus obendrauf 🍯';

  @override
  String get category_income_allowance_name => 'Taschengeld';

  @override
  String get category_income_allowance_desc => 'Ein schönes Überraschungsgeschenk 🎁';

  @override
  String get category_income_finance_name => 'Investitionen';

  @override
  String get category_income_finance_desc => 'Früchte, die dein Geld für dich trägt 📈';

  @override
  String get category_income_etc_name => 'Sonstige Einnahmen';

  @override
  String get category_income_etc_desc => 'Weitere bunte Einnahmen 💧';

  @override
  String get notifEvening1Title => '🍊 Wie viele mL Juice hast du heute getrunken?';

  @override
  String get notifEvening1Body => 'Heute war wieder ein langer Tag! Trag es vor dem Schlafen kurz ein und halte deinen Juice für morgen frisch ✨';

  @override
  String get notifEvening2Title => '🍹 Jeder Tropfen Juice zählt!';

  @override
  String get notifEvening2Body => 'Gab es heute überraschende Ausgaben? Wenn du sie jetzt einträgst, schmeckt dein Juice nächste Woche viel süßer 🍯';

  @override
  String get notifEvening3Title => '🧃 Zeit für den Becher-Check!';

  @override
  String get notifEvening3Body => 'Tippe in einer Sekunde ein, was du heute ausgegeben hast, und prüfe, ob dein Juice-Pegel sicher ist.';

  @override
  String get notifEvening4Title => '🍋 Juice auffüllen, bevor der Kassenbon im Müll landet!';

  @override
  String get notifEvening4Body => 'Nicht erfasste Ausgaben sind der kürzeste Weg zum Leck! Sortiere deine heutigen Ausgaben kurz 🏃‍♂️';

  @override
  String get notifEvening5Title => '🍏 Ein frischer Abschluss für heute!';

  @override
  String get notifEvening5Body => 'Trag deine Ausgaben ein und genieß eine ruhige Nacht. Morgen begrüßen wir dich mit Juice, der nie versiegt 🌙';

  @override
  String get notifMondayTitle => '🍊 Dein Juice ist wieder randvoll!';

  @override
  String get notifMondayBody => 'Die letzte Woche hast du gut gemeistert. Starte frisch in die Woche – mit einem herrlich vollen Budget ✨';

  @override
  String get notifWeekday1Title => '☕️ Die Kaffee-Mahnung auf dem Arbeitsweg';

  @override
  String get notifWeekday1Body => 'Check deine Juice-Anzeige, bevor du den Morgenkaffee trinkst! Ein Schluck weniger macht deinen Wochenend-Juice doppelt so kühl.';

  @override
  String get notifWeekday2Title => '🚨 Gerade etwas zu gierig am Trinken?';

  @override
  String get notifWeekday2Body => 'Trinkst du deinen Juice in letzter Zeit zu hastig? Genieß ihn heute ein bisschen langsamer! 🍊';

  @override
  String get notifWeekday3Title => '🌤 Auch heute wieder frisch!';

  @override
  String get notifWeekday3Body => 'Hab einen Tag so frisch wie das Wetter! Am Ende deines Tages wartet immer deine verlässliche Juice-App.';

  @override
  String get notifWeekday4Title => '🎯 Die 0-mL-Ausgaben-Challenge';

  @override
  String get notifWeekday4Body => 'Schaffst du heute \'0 mL Ausgaben\', erscheint vielleicht ein Regenbogen über deinem Juice-Becher! Nur einen Tag den Geldbeutel sperren? 🔒';

  @override
  String get notifWeekday5Title => '🍕 Freitags-/Wochenend-Abwehr';

  @override
  String get notifWeekday5Body => 'Nur weil Wochenende ist, den Juice-Deckel nicht ganz aufreißen! Versprich, nur so viel einzuschenken, wie du trinkst 🤙';

  @override
  String get notifWeekday6Title => '🌱 Kleine Gönnungen sind okay';

  @override
  String get notifWeekday6Body => 'Kleine Belohnungen für dich sind in Ordnung. Nur das Eintragen nicht vergessen! Kleine Gewohnheiten schützen deinen Juice-Krug.';

  @override
  String get notifWeekday7Title => '📊 Halbzeit der Woche';

  @override
  String get notifWeekday7Body => 'Die Hälfte der Woche ist vorbei. Ist dein Juice-Pegel … sicher? Öffne die App und sieh selbst nach 👀';

  @override
  String get notifWeekday8Title => '🧃 Heute wieder zur Arbeit erschienen';

  @override
  String get notifWeekday8Body => 'Schon wieder zum Schutz deines Geldbeutels angetreten! Hab einen energiegeladenen Tag wie Juice, der nie versiegt 🍊';

  @override
  String get notifSunday1Title => '🧺 Den letzten Schluck dieser Woche verteidigen!';

  @override
  String get notifSunday1Body => 'Widerstehe nur der Sonntagabend-Bestellung, dann ist das Wochenziel geschafft! Vorsicht, nichts verschütten 🍊';

  @override
  String get notifSunday2Title => '🏆 Starke Woche!';

  @override
  String get notifSunday2Body => 'Willst du sehen, wie viel Juice du diese Woche gespart hast? Freu dich auf den frischen Juice, der morgen nachgefüllt wird ✨';

  @override
  String get notifSunday3Title => '🧊 Morgen wird dein Juice-Krug zurückgesetzt!';

  @override
  String get notifSunday3Body => 'Juice übrig? Tolle Ersparnis! Übergelaufen? Kein Problem – bereite schon das Rezept für nächste Woche vor 🧃';

  @override
  String get notifComeback1Title => '🍊 Die Orange ist so traurig, dass sie sich selbst schält.';

  @override
  String get notifComeback1Body => 'Zwei Tage nicht da … du versteckst dich doch nicht vor der Juice-App, weil du heimlich Geld verprasst hast? Komm rein und gestehe.';

  @override
  String get notifComeback2Title => '🧃 Am Boden deines Juice-Krugs bildet sich Schimmel …';

  @override
  String get notifComeback2Body => 'Drei Tage nicht erfasste Belege nagen an deinem Konto. Bitte öffne mich und schneide die faulen Ausgaben heraus! 😱';

  @override
  String get notifComeback3Title => '🍋 [DRINGEND] Dein Kontostand läuft aus.';

  @override
  String get notifComeback3Body => 'Glaubst du, Ausgaben verschwinden, wenn du die App nicht öffnest? Die Belege wissen alles. Kommst du heute nicht, kippe ich deinen Juice-Becher um? 💥';

  @override
  String get notifComeback4Title => '🫗 … Habe ich etwas falsch gemacht?';

  @override
  String get notifComeback4Body => 'Seit einer Woche lässt du deinen Juice hungern. Im leeren Becher sammelt sich Staub. Dein Sparziel verweht wie Staub … schnief.';

  @override
  String get notifComeback5Title => '💀 Glückwunsch! Dein Juice ist komplett verdunstet.';

  @override
  String get notifComeback5Body => 'Zwei Wochen nicht da – du bist sicher schon pleite. Komm rein und rette wenigstens den letzten Tropfen Gewissen! 🏃‍♂️💨';

  @override
  String get notifChannelName => 'Juice-Erinnerungen';

  @override
  String get notifChannelDescription => 'Morgen- und Abend-Erinnerungen zum Eintragen deiner Ausgaben sowie aufmunternde Nachrichten';
}
