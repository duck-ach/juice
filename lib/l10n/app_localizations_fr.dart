import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Juice Budget';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get setBudgetTitle => 'Définissez votre budget juice';

  @override
  String get weeklyBudget => 'Juice restant cette semaine';

  @override
  String get paymentCheckCard => 'Carte de débit';

  @override
  String get paymentCreditCard => 'Carte de crédit';

  @override
  String get paymentCash => 'Espèces · Virement';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonNext => 'Suivant';

  @override
  String get goalSettingsTitle => 'Paramètres d\'objectif';

  @override
  String get activePeriodSectionTitle => 'Période d\'objectif active';

  @override
  String get activePeriodSectionDescription => 'La période sur laquelle se base la jauge d\'accueil. Renseignez ci-dessous l\'objectif de chaque période pour qu\'il s\'applique instantanément.';

  @override
  String get weekStartDayTileTitle => 'Premier jour de la semaine';

  @override
  String get periodTargetSectionTitle => 'Montant cible par période';

  @override
  String get periodTargetSectionDescription => 'Enregistrez un montant cible distinct pour chaque période et choisissez celle dont vous avez besoin.';

  @override
  String get periodTargetAmountSuffix => 'Montant cible';

  @override
  String get installmentSectionTitle => 'Mode de prise en compte des paiements échelonnés';

  @override
  String get installmentSectionDescription => 'Choisissez quand et comment les paiements échelonnés apparaissent dans le calendrier/la jauge de juice.';

  @override
  String get recommendedSuffix => 'Recommandé';

  @override
  String get savingsPlanSectionTitle => 'Planificateur d\'épargne moyen/long terme';

  @override
  String get savingsPlanSectionDescription => 'Indiquez vos revenus mensuels, dépenses fixes et objectif d\'épargne pour calculer le juice disponible.';

  @override
  String get savingsPlanToggleTitle => 'Avez-vous un objectif d\'épargne à moyen/long terme ?';

  @override
  String get autoBudgetSetMessage => 'Objectifs quotidien/hebdomadaire/mensuel définis automatiquement 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 Résumé de mon plan juice';

  @override
  String get replanButton => 'Refaire le plan';

  @override
  String get applyBudgetButton => 'Configurer le juice avec ce budget';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years an(s) $months mois';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years an(s)';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months mois';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return 'Objectif : épargner $amount won(s) en $duration';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return 'Dépenses fixes (incontournables) : $amount won(s)/mois';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return 'Juice recommandé : $daily mL/jour · $weekly mL/semaine · $monthly mL/mois';
  }

  @override
  String savingsPlanPaceFasterLine(Object months) {
    return 'À ce rythme, vous atteindrez votre objectif $months mois plus tôt ! 🚀';
  }

  @override
  String savingsPlanPaceSlowerLine(Object months) {
    return 'À ce rythme, vous pourriez avoir $months mois de retard sur le plan. Vous allez y arriver 💪';
  }

  @override
  String get savingsPlanPaceOnTrackLine => 'Votre rythme actuel correspond parfaitement au plan ! Continuez comme ça 🍊';

  @override
  String get recalibrateButton => 'Changement de revenu · Recalibrer';

  @override
  String get recalibrateSheetTitle => 'Recalibrer le plan';

  @override
  String get recalibrateSheetSubtitle => 'Indiquez votre nouveau revenu mensuel et choisissez l\'une des deux façons de l\'appliquer immédiatement.';

  @override
  String get recalibrateIncomeFieldLabel => 'Nouveau revenu mensuel';

  @override
  String get recalibrateShortenOption => 'Raccourcir la durée de l\'objectif';

  @override
  String recalibrateShortenPreview(Object before, Object after) {
    return 'Gardez votre budget de vie actuel et raccourcissez la durée de $before à $after mois.';
  }

  @override
  String get recalibrateShortenUnavailable => 'Avec ce revenu, impossible de raccourcir la durée en gardant votre budget de vie actuel.';

  @override
  String get recalibrateBoostOption => 'Augmenter le juice (budget de vie)';

  @override
  String recalibrateBoostPreview(Object before, Object after) {
    return 'Gardez la même durée d\'objectif et augmentez votre juice quotidien de $before mL à $after mL.';
  }

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get savingsCardSectionTitle => 'Carte d\'épargne de la semaine';

  @override
  String get savingsCardSectionDescription => 'Transformez une semaine réussie en carte à partager.';

  @override
  String get generatingCard => 'Génération de la carte...';

  @override
  String get shareCardButton => 'Partager la carte';

  @override
  String get setTargetAmountFirst => 'Veuillez d\'abord définir un montant cible';

  @override
  String get menuGoalSettingsTitle => 'Paramètres d\'objectif';

  @override
  String get menuGoalSettingsSubtitle => 'Objectif d\'épargne à long terme, période d\'objectif, cible par période';

  @override
  String get menuThemeSettingsTitle => 'Paramètres de thème';

  @override
  String get menuThemeSettingsSubtitle => 'Mode d\'affichage et thème juice';

  @override
  String get menuWidgetSettingsTitle => 'Paramètres du widget';

  @override
  String get menuWidgetSettingsSubtitle => 'Masquer le montant sur le widget d\'accueil';

  @override
  String get menuCardManagementTitle => 'Gestion de mes cartes';

  @override
  String get menuCardManagementSubtitle => 'Enregistrez vos cartes et réorganisez-les';

  @override
  String get menuNotificationSettingsTitle => 'Paramètres de notification';

  @override
  String get menuNotificationSettingsSubtitle => 'Activer/désactiver les rappels du matin/soir';

  @override
  String get menuBackupSettingsTitle => 'Sauvegarde et restauration';

  @override
  String get menuBackupSettingsSubtitle => 'Exporter en CSV, exporter/importer une sauvegarde';

  @override
  String get menuSecuritySettingsTitle => 'Sécurité';

  @override
  String get menuSecuritySettingsSubtitle => 'Code PIN, authentification biométrique';

  @override
  String get menuContactSupportTitle => 'Contact & retours';

  @override
  String get menuContactSupportSubtitle => 'Envoyez-nous votre avis par e-mail';

  @override
  String get feedbackTitle => 'Contact & retours 🍊';

  @override
  String get feedbackTypeBug => 'Signaler un bug';

  @override
  String get feedbackTypeFeature => 'Suggérer une fonctionnalité';

  @override
  String get feedbackTypeOther => 'Autre';

  @override
  String get feedbackEmailHint => 'Votre e-mail (facultatif, pour une réponse)';

  @override
  String get feedbackContentHint => 'Partagez votre avis avec nous.';

  @override
  String get feedbackAttachImage => 'Joindre une capture d\'écran';

  @override
  String get feedbackSubmit => 'Envoyer';

  @override
  String get feedbackDeviceInfoNotice => 'Les infos appareil/OS sont incluses pour nous aider à résoudre votre demande plus vite.';

  @override
  String get feedbackContentRequired => 'Veuillez saisir votre message';

  @override
  String get feedbackMailUnavailable => 'Impossible d\'ouvrir l\'appli Mail, le contenu a été copié.';

  @override
  String get privacyPolicyTitle => 'Politique de confidentialité';

  @override
  String get menuPrivacyPolicySubtitle => 'Découvrez comment vos données sont traitées';

  @override
  String get privacyWelcomeTitle => 'Bienvenue sur Juice Budget !';

  @override
  String get privacyAgreeNotice => 'Juice Budget est un carnet de comptes 100 % local sur votre appareil — aucune de vos données financières ou personnelles n\'est jamais envoyée à un serveur externe.';

  @override
  String get viewPrivacyPolicy => 'Voir la politique de confidentialité complète';

  @override
  String get agreeAndStart => 'Accepter et commencer';

  @override
  String get savingsCardSuccessMessage => 'Le juice de cette semaine\nest resté frais !';

  @override
  String get savingsCardOverMessage => 'Le juice de cette semaine\na un peu débordé';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return 'Dépensé $spent sur $budget';
  }

  @override
  String get savingsCardSuccessStamp => 'RÉUSSI';

  @override
  String get savingsCardOverStamp => 'À AMÉLIORER';

  @override
  String get pinSetupTitle => 'Définir le mot de passe';

  @override
  String get biometricUnlockReason => 'Authentifiez-vous pour déverrouiller';

  @override
  String get pinConfirmTitle => 'Confirmer le mot de passe';

  @override
  String get pinConfirmCurrentTitle => 'Confirmer le mot de passe actuel';

  @override
  String get pinSetupNewTitle => 'Définir un nouveau mot de passe';

  @override
  String get pinChangedMessage => 'Mot de passe modifié';

  @override
  String get biometricLinkTitle => 'Associer l\'authentification biométrique';

  @override
  String get biometricLinkConfirm => 'Voulez-vous associer l\'authentification biométrique ?';

  @override
  String get biometricLinkAction => 'Associer';

  @override
  String get biometricLinkReason => 'Authentifiez-vous pour associer la biométrie';

  @override
  String get biometricUnavailableMessage => 'L\'authentification biométrique n\'est pas disponible';

  @override
  String get securityTitle => 'Sécurité';

  @override
  String get securityDescription => 'Verrouillez l\'application avec un code PIN ou la biométrie.';

  @override
  String get appLockTitle => 'Verrouillage de l\'application';

  @override
  String get appLockDescription => 'Protégez l\'accès avec un code PIN à 4 chiffres.';

  @override
  String get changePasswordTitle => 'Changer le mot de passe';

  @override
  String get biometricUseTitle => 'Utiliser la biométrie';

  @override
  String get biometricUseDescription => 'Déverrouillez plus vite avec Face ID/empreinte digitale.';

  @override
  String get csvShareText => 'Historique des dépenses Juice';

  @override
  String get backupShareText => 'Sauvegarde des données Juice';

  @override
  String backupFailedMessage(Object error) {
    return 'Échec de la sauvegarde : $error';
  }

  @override
  String get restoreDataTitle => 'Restaurer les données';

  @override
  String get restoreDataConfirm => 'Les données existantes seront remplacées par le fichier de sauvegarde. Continuer ?';

  @override
  String get restoreAction => 'Restaurer';

  @override
  String get restoreSuccessMessage => 'Restauration terminée';

  @override
  String get restoreFailedMessage => 'Échec de la restauration. Vérifiez qu\'il s\'agit bien d\'un fichier de sauvegarde Juice valide';

  @override
  String get backupSettingsTitle => 'Sauvegarde et restauration';

  @override
  String get exportExpensesTitle => 'Exporter l\'historique des dépenses';

  @override
  String get exportExpensesDescription => 'Partagez un CSV avec la date, la catégorie, le montant, l\'indicateur de dépense fixe et le mémo.';

  @override
  String get exportingCsv => 'Exportation...';

  @override
  String get exportCsvButton => 'Exporter en CSV';

  @override
  String get backupRestoreTitle => 'Sauvegarde · Restauration';

  @override
  String get backupRestoreDescription => 'Sauvegardez et restaurez dépenses, revenus, catégories et paramètres de budget dans un seul fichier.';

  @override
  String get backupDataTitle => 'Sauvegarder les données';

  @override
  String get backupDataDescription => 'Enregistrez via le menu de partage vers Fichiers, e-mail, etc.';

  @override
  String get restoreDataTileTitle => 'Restaurer les données';

  @override
  String get restoreDataTileDescription => 'Choisissez un fichier de sauvegarde pour remplacer les données existantes.';

  @override
  String get categoryDefaultDescription => 'Ma recette juice personnelle';

  @override
  String get categoryDeleteTitle => 'Supprimer la catégorie';

  @override
  String categoryDeleteConfirm(Object name) {
    return 'Supprimer la catégorie « $name » ?\nLes dépenses déjà enregistrées seront conservées.';
  }

  @override
  String get categoryInUseMessage => 'Certains enregistrements utilisent cette catégorie. Déplacez-les vers une autre catégorie avant de la supprimer.';

  @override
  String get categoryEditTitle => 'Modifier la catégorie';

  @override
  String get categoryAddTitle => 'Ajouter une catégorie';

  @override
  String get categoryNameLabel => 'Nom de la catégorie';

  @override
  String get categoryDescriptionLabel => 'Description courte';

  @override
  String get colorLabel => 'Couleur';

  @override
  String get iconLabel => 'Icône';

  @override
  String get categoryManageTitle => 'Gestion des catégories';

  @override
  String get expenseCategoryTab => 'Catégories de dépenses';

  @override
  String get incomeCategoryTab => 'Catégories de revenus';

  @override
  String get defaultCategoryUndeletable => 'Les catégories par défaut ne peuvent pas être supprimées';

  @override
  String get cardDeleteTitle => 'Supprimer la carte';

  @override
  String cardDeleteConfirm(Object name) {
    return 'Supprimer la carte « $name » ?\nLes dépenses déjà enregistrées seront conservées.';
  }

  @override
  String get cardEditTitle => 'Modifier la carte';

  @override
  String get cardAddTitle => 'Ajouter une carte';

  @override
  String get cardNameLabel => 'Nom de la carte';

  @override
  String get cardTypeLabel => 'Type de carte';

  @override
  String get cardManagementTitle => 'Gestion de mes cartes';

  @override
  String get defaultCardUndeletable => 'Les cartes par défaut ne peuvent pas être supprimées';

  @override
  String get cardTypeCorporate => 'Professionnelle/Entreprise';

  @override
  String get cardTypeCorporateExcluded => 'Professionnelle (dépense) · Exclue du juice';

  @override
  String get corporateExpenseNotice => '🏢 Les dépenses professionnelles n\'ont pas besoin de catégorie et sont automatiquement exclues de vos dépenses personnelles.';

  @override
  String get corporateBadgeLabel => '🏢 Professionnelle · Exclue du personnel';

  @override
  String get corporateCardLabel => 'Carte professionnelle';

  @override
  String get corporateMemoRequired => 'Veuillez saisir un mémo (motif) pour les dépenses professionnelles';

  @override
  String get juiceThemeLabel => 'Thème juice';

  @override
  String get themeSettingsTitle => 'Paramètres de thème';

  @override
  String get screenModeLabel => 'Mode d\'affichage';

  @override
  String get themeModeSystem => 'Système';

  @override
  String get themeModeLight => 'Clair';

  @override
  String get themeModeDark => 'Sombre';

  @override
  String get juiceThemeDescription => 'Choisissez la couleur de juice qui évolue avec votre budget restant. Elle devient aussi la couleur d\'accent de l\'application.';

  @override
  String get themeOrange => 'Orange';

  @override
  String get themeStrawberry => 'Fraise';

  @override
  String get themeApple => 'Pomme';

  @override
  String get themeGrape => 'Raisin';

  @override
  String get themeBlueberry => 'Myrtille';

  @override
  String get themeMulberry => 'Mûre';

  @override
  String get themeRandom => 'Aléatoire (à chaque ouverture de l\'app)';

  @override
  String get widgetSettingsTitle => 'Paramètres du widget';

  @override
  String get homeScreenWidgetTitle => 'Widget d\'écran d\'accueil';

  @override
  String get homeScreenWidgetDescription => 'Ajoutez un widget de jauge juice et un widget de saisie rapide à votre écran d\'accueil.';

  @override
  String get hideWidgetAmountTitle => 'Masquer le montant sur le widget';

  @override
  String get hideWidgetAmountDescription => 'Affiche ***mL et le pourcentage restant à la place du montant.';

  @override
  String get notificationSettingsTitle => 'Paramètres de notification';

  @override
  String get notificationScheduleDescription => 'Nous envoyons des rappels tous les jours à 7 h et 20 h pour vous encourager à saisir vos dépenses.';

  @override
  String get receiveNotificationsTitle => 'Recevoir les notifications Juice';

  @override
  String get receiveNotificationsDescription => 'Nous vous relancerons aussi si vous n\'avez pas ouvert l\'application depuis un moment.';

  @override
  String get navHome => 'Accueil';

  @override
  String get navCalendar => 'Calendrier';

  @override
  String get navAssets => 'Actifs';

  @override
  String get navStats => 'Stats';

  @override
  String get navSettings => 'Paramètres';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 Part d\'échéance du jour : $amount mL';
  }

  @override
  String get filterVariableOnlyLong => 'Afficher uniquement les dépenses variables';

  @override
  String get filterAllLong => 'Tout afficher';

  @override
  String noGoalTitle(Object period) {
    return 'Aucun montant cible défini pour $period';
  }

  @override
  String noGoalDescription(Object period) {
    return 'Renseignez la cible pour $period dans les paramètres d\'objectif.';
  }

  @override
  String get goToGoalSettings => 'Aller aux paramètres d\'objectif';

  @override
  String get noExpensesYet => 'Aucune dépense enregistrée pour le moment';

  @override
  String remainingJuiceLabel(Object period) {
    return 'Juice restant $period';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '$percent % utilisé';
  }

  @override
  String get overBudgetMessage1 => 'Dommage ! Gardons un peu de juice la semaine prochaine 🍊';

  @override
  String get overBudgetMessage2 => 'Le pichet de juice est vide ! Faites une pause cette semaine 🥲';

  @override
  String get overBudgetMessage3 => 'Un peu de juice renversé ! On refait le plein la semaine prochaine 🧃';

  @override
  String get overBudgetMessage4 => 'Jusqu\'à la dernière goutte ! Sirotez plus doucement la semaine prochaine ✨';

  @override
  String get incomeFallbackName => 'Revenu';

  @override
  String get unknownCategoryName => 'Inconnu';

  @override
  String get fixedExpenseLabel => 'Fixe';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return 'Échéance $index/$months';
  }

  @override
  String get deletedMessage => 'Supprimé';

  @override
  String get undoAction => 'Annuler';

  @override
  String get amountAndCategoryRequired => 'Veuillez vérifier le montant et la catégorie';

  @override
  String get expenseLabel => 'Dépense';

  @override
  String get incomeLabel => 'Revenu';

  @override
  String editTypeTitle(Object type) {
    return 'Modifier $type';
  }

  @override
  String addTypeTitle(Object type) {
    return 'Ajouter $type';
  }

  @override
  String deleteTypeTitle(Object type) {
    return 'Supprimer $type';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return 'Supprimer cet enregistrement de $type ?';
  }

  @override
  String get cardSelectLabel => 'Choisir la carte';

  @override
  String installmentEditNotice(Object index, Object months) {
    return 'Échéance $index/$months — les autres échéances ne seront pas modifiées';
  }

  @override
  String get lumpSumLabel => 'Paiement unique';

  @override
  String monthsPresetLabel(Object months) {
    return '$months mois';
  }

  @override
  String get customInputLabel => 'Personnalisé';

  @override
  String get monthsCountHint => 'Nombre de mois (2-24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return 'Reflété comme $amount mL chaque mois pendant $months échéances';
  }

  @override
  String get memoHint => 'Mémo (facultatif)';

  @override
  String get excludeAsFixedTitle => 'Exclure en tant que dépense fixe';

  @override
  String get excludeAsFixedSubtitle => 'Loyer, assurance, etc. — non pris en compte dans la jauge de juice';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return 'Revenu « $category » de $amount mL reçu ! 💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return '$amount mL enregistrés pour « $category » ! 🍊';
  }

  @override
  String get calendarTitle => 'Calendrier';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return 'Ce mois-ci : $expense dépensés · $income gagnés';
  }

  @override
  String get filterVariableOnlyShort => 'Variable';

  @override
  String get filterAllShort => 'Tout';

  @override
  String get noExpenseTodayMessage => 'Une journée sans dépense, ça fait du bien ! 🍊';

  @override
  String get assetsTitle => 'Actifs';

  @override
  String get cumulativeNetWorthLabel => 'Patrimoine net cumulé';

  @override
  String get cumulativeNetWorthDescription => 'Tous les revenus enregistrés moins les dépenses jusqu\'à présent.';

  @override
  String get scopeThisYear => 'cette année';

  @override
  String get scopeLast5Years => 'les 5 dernières années';

  @override
  String totalIncomeLabel(Object scope) {
    return 'Revenu total ($scope)';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return 'Dépense totale ($scope)';
  }

  @override
  String get netChangeTrendTitle => 'Tendance de variation nette';

  @override
  String get netChangeTrendDescription => 'Variation nette = revenus moins dépenses. Vert = excédent, rouge = déficit.';

  @override
  String get statsTitle => 'Stats';

  @override
  String get filterFixedIncluded => 'Inclure les dépenses fixes';

  @override
  String get totalExpenseTitle => 'Dépense totale';

  @override
  String get categorySpendingTitle => 'Dépenses par catégorie';

  @override
  String get paymentMethodSpendingTitle => 'Dépenses par mode de paiement';

  @override
  String get statsPeriodThisWeek => 'Cette semaine';

  @override
  String get statsPeriodThisMonth => 'Ce mois-ci';

  @override
  String get statsPeriodLast4Weeks => '4 dernières semaines';

  @override
  String get statsPeriodMonthly => 'Mensuel';

  @override
  String get statsPeriodYearly => 'Annuel';

  @override
  String get cardStatsViewSummary => 'Résumé';

  @override
  String get cardStatsViewByCard => 'Par carte';

  @override
  String get noExpensesInPeriod => 'Aucun enregistrement pour cette période';

  @override
  String get categoryDetailThisMonthTotal => 'Total du mois';

  @override
  String get categoryDetailMonthlyTrendTitle => 'Tendance mensuelle';

  @override
  String get categoryDetailExpenseListTitle => 'Détail des transactions';

  @override
  String get categoryDetailEmptyMessage => 'Aucun enregistrement pour le moment';

  @override
  String monthlyTotalLabel(Object month) {
    return 'Total $month';
  }

  @override
  String get categoryDetailEmptyMonthMessage => 'Aucune dépense ce mois-ci 🍊';

  @override
  String get installmentIncludedSuffix => 'échéances incl.';

  @override
  String get cardUnassigned => 'Aucune carte assignée';

  @override
  String get fillJuiceButton => 'Remplir le juice';

  @override
  String get finishWizardButton => 'Démarrer avec cette recette';

  @override
  String get incomeTypeFixed => 'Revenu fixe';

  @override
  String get incomeTypeVariable => 'Revenu variable';

  @override
  String get incomeTypeAllowance => 'Argent de poche / Épargne';

  @override
  String get freqMonthly => 'Mensuel';

  @override
  String get freqBiweekly => 'Toutes les 2 semaines';

  @override
  String get freqWeekly => 'Hebdomadaire';

  @override
  String get questionIncomeFixed => 'Combien de juice (revenu) rentre chaque mois ? 💰';

  @override
  String get questionIncomeFixedSub => 'Indiquez le montant qui arrive réellement sur votre compte.';

  @override
  String get questionIncomeVariable => 'Quel est le revenu minimum sûr, même en basse saison ? 💼';

  @override
  String get questionIncomeVariableSub => 'Estimez prudemment pour que le plan tienne même un mois creux.';

  @override
  String get questionWeeklyExpenseVariable => 'Combien comptez-vous dépenser par semaine pour vos frais de vie (dépenses variables) ?';

  @override
  String get questionIncomeAllowance => 'Combien d\'argent de poche recevez-vous ou avez-vous économisé ? 🌱';

  @override
  String get subAllowanceRegular => '🗓️ Argent de poche régulier';

  @override
  String get subAllowanceIrregular => '🎲 Argent de poche/petit boulot irrégulier';

  @override
  String get questionIrregularMinSave => 'Quel est le montant minimum que vous êtes sûr de pouvoir épargner chaque mois ? 🪙';

  @override
  String praiseVariablePlan(Object amount) {
    return '🍊 Sur la base de votre minimum en basse saison, vous pouvez épargner au moins $amount won(s) par an en toute sécurité !\nLes mois où vous gagnez plus, utilisez le juice bonus pour accélérer votre épargne 🚀';
  }

  @override
  String praiseAllowancePlan(Object amount) {
    return 'De petites gouttes finissent par former un océan ! Dans un an, vous aurez $amount won(s) d\'un magnifique juice épargné ✨';
  }

  @override
  String get guideExtendGoalPeriod => 'On allonge un peu la durée de l\'objectif pour épargner confortablement avec votre argent de poche ? 🍊';

  @override
  String freqConversionCaption(Object monthly, Object weekly) {
    return '≈ $monthly won(s)/mois · environ $weekly won(s)/semaine disponibles 🍊';
  }

  @override
  String get wonSuffixSpaced => ' won';

  @override
  String get goalStepQuestion => 'Pendant combien de temps,\net combien voulez-vous épargner ?';

  @override
  String get yearsFieldLabel => 'ans';

  @override
  String get monthsFieldLabel => 'mois';

  @override
  String get goalAmountFieldLabel => 'Montant d\'épargne cible';

  @override
  String get wonUnit => 'won';

  @override
  String get fixedExpenseStepQuestion => 'Avez-vous des dépenses\nfixes mensuelles ?';

  @override
  String get fixedExpenseStepSubtitle => 'Loyer, assurance, forfait mobile, etc. — non comptabilisés dans le pichet de juice.';

  @override
  String get itemNameHint => 'Nom de l\'élément';

  @override
  String get addItemButton => 'Ajouter un élément';

  @override
  String get resultStepQuestion => 'Votre plan juice\nest prêt !';

  @override
  String get resultNegativeMessage => 'Les dépenses fixes et l\'épargne dépassent les revenus 😥 Revenez ajuster l\'objectif ou la durée.';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return 'Revenu mensuel $income won − dépenses fixes $fixed won − épargne mensuelle, il reste :';
  }

  @override
  String get resultWeeklyPrefix => 'Cette semaine : ';

  @override
  String get resultWeeklySuffix => ' de juice à savourer ! 🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '$daily mL/jour · $monthly mL/mois';
  }

  @override
  String get periodDaily => 'Aujourd\'hui';

  @override
  String get periodWeekly => 'Cette semaine';

  @override
  String get periodMonthly => 'Ce mois-ci';

  @override
  String get periodSettingDaily => 'Quotidien';

  @override
  String get periodSettingWeekly => 'Hebdomadaire';

  @override
  String get periodSettingMonthly => 'Mensuel';

  @override
  String get weekStartMonday => 'Commence le lundi (lun.–dim.)';

  @override
  String get weekStartSunday => 'Commence le dimanche (dim.–sam.)';

  @override
  String get installmentModeMonthlyLabel => 'Facturé en une fois le mois suivant';

  @override
  String get installmentModeDailyLabel => 'Facturé également chaque jour';

  @override
  String get installmentModeMonthlyDescription => 'Comme un vrai relevé de carte, le montant de l\'échéance est enregistré en une fois le 1er de chaque mois.';

  @override
  String get installmentModeDailyDescription => 'Le montant de l\'échéance du mois est divisé par le nombre de jours et retiré un peu chaque jour de la jauge de juice.';

  @override
  String get splashOrangeSubText => 'Le budget de la semaine, rafraîchissant et bien rempli';

  @override
  String get splashGreenAppleSubText => 'Une habitude fraîche de dépense réfléchie';

  @override
  String get splashGrapeSubText => 'Protégez avec douceur votre propre limite';

  @override
  String get splashStrawberrySubText => 'Une journée bien remplie';

  @override
  String get confirmNewPinPrompt => 'Veuillez ressaisir votre nouveau mot de passe';

  @override
  String get enterCurrentPinPrompt => 'Veuillez saisir votre mot de passe actuel';

  @override
  String get enterNewPinPrompt => 'Veuillez saisir un nouveau mot de passe';

  @override
  String get enterPinPrompt => 'Veuillez saisir votre mot de passe';

  @override
  String get juiceLockTitle => 'Le juice est verrouillé';

  @override
  String get pinConfirmMismatchError => 'Les mots de passe ne correspondent pas. Réessayez';

  @override
  String get pinMismatchError => 'Le mot de passe ne correspond pas';

  @override
  String get shareCardText => 'Ma carte d\'épargne juice';

  @override
  String get unlockJuiceReason => 'Authentifiez-vous pour déverrouiller votre juice';

  @override
  String get unlockWithBiometrics => 'Déverrouiller avec la biométrie';

  @override
  String yearsPresetLabel(Object years) {
    return '$years an(s)';
  }

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsCurrency => 'Devise de base';

  @override
  String get currencySelectTitle => 'Choisissez votre devise';

  @override
  String get commonDone => 'Terminé';

  @override
  String get currencyNameKrw => 'Won sud-coréen (₩)';

  @override
  String get currencyNameUsd => 'Dollar américain (\$)';

  @override
  String get currencyNameJpy => 'Yen japonais (¥)';

  @override
  String get currencyNameEur => 'Euro (€)';

  @override
  String get currencyNameVnd => 'Dong vietnamien (₫)';

  @override
  String get currencyNameTwd => 'Nouveau dollar taïwanais (NT\$)';

  @override
  String get currencyNameCny => 'Yuan chinois (¥)';

  @override
  String get currencyNameBrl => 'Réal brésilien (R\$)';

  @override
  String get foreignCurrencyPickerTitle => 'Choisir la devise de paiement';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted (taux du jour : $rate)';
  }

  @override
  String get exchangeRateLoadingMessage => 'Récupération du taux de change...';

  @override
  String get exchangeRateFailedMessage => 'Impossible de récupérer le taux de change. Saisissez-le manuellement ou utilisez le dernier taux connu.';

  @override
  String get manualRateEntryToggle => 'Saisir le taux manuellement';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonCopy => 'Copier';

  @override
  String linkOpenFailedMessage(Object target) {
    return 'Aucune application trouvée pour ouvrir : $target';
  }

  @override
  String get commonConfirm => 'Confirmer';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return 'Changer votre devise de base pour $toCode ? Tous les montants déjà enregistrés seront automatiquement convertis au taux de change actuel.';
  }

  @override
  String get currencyMigrationLoadingMessage => 'Conversion de vos enregistrements existants vers la nouvelle devise... 🍊';

  @override
  String get currencyMigrationFailedMessage => 'Impossible de récupérer le taux de change, les montants existants ont donc été laissés inchangés';

  @override
  String get category_food_name => 'Alimentation';

  @override
  String get category_food_desc => 'Une délicieuse énergie pour la journée 🍱';

  @override
  String get category_cafe_name => 'Café & En-cas';

  @override
  String get category_cafe_desc => 'Une douce cuillère de plaisir ☕️';

  @override
  String get category_transport_name => 'Transports';

  @override
  String get category_transport_desc => 'Un trajet tout en douceur 🚌';

  @override
  String get category_shopping_name => 'Shopping';

  @override
  String get category_shopping_desc => 'Le plaisir de se faire plaisir 🛍️';

  @override
  String get category_culture_name => 'Loisirs & Culture';

  @override
  String get category_culture_desc => 'Une douce pause pour l\'esprit 🎬';

  @override
  String get category_life_name => 'Logement';

  @override
  String get category_life_desc => 'Un peu de fraîcheur au quotidien 🧼';

  @override
  String get category_etc_name => 'Divers';

  @override
  String get category_etc_desc => 'Les petites dépenses du quotidien 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return 'Juice épargné +$amount mL';
  }

  @override
  String get savingHistoryTitle => 'Historique d\'épargne';

  @override
  String get savingHistoryEmpty => 'Aucune période terminée pour l\'instant.\nTerminez votre première période !';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '+$amount mL épargnés !';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return '$amount mL dépensés en trop';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return 'Cible $target / Dépensé $spent';
  }

  @override
  String get savingOptionTitle => 'Que faire du juice restant';

  @override
  String get savingOptionDescription => 'Choisissez ce qu\'il advient de votre budget non utilisé à la fin d\'une période.';

  @override
  String get savingOptionRollover => 'Reporter sur la période suivante';

  @override
  String get savingOptionSavings => 'Mettre de côté comme fonds d\'urgence';

  @override
  String get savedJuiceStoreTooltip => 'Réserve de juice';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return 'Juice épargné : $amount mL ($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return 'Inclut +$amount mL reportés de la période précédente';
  }

  @override
  String get savingsAssetCardTitle => 'Actifs protégés par l\'épargne';

  @override
  String get savingsAssetCardDescription => 'Total du juice restant des périodes terminées avec l\'option épargne.';

  @override
  String get savingPraise_1 => 'Vous avez déjà épargné tout ça ! Incroyable !! Vous vous rapprochez de votre objectif 🍊';

  @override
  String get savingPraise_2 => 'Vous avez gardé votre précieux juice bien frais ! Vos habitudes d\'épargne brillent ✨';

  @override
  String get savingPraise_3 => 'Le juice épargné se transforme en richesse solide ! Continuez comme ça aujourd\'hui 🧃';

  @override
  String get savingPraise_4 => 'Épargner est une merveilleuse habitude ! Plus votre juice grandit, plus votre esprit s\'apaise 🍯';

  @override
  String get savingPraise_5 => 'Bravo d\'avoir défendu votre objectif sans faiblir ! Gardons le prochain juice frais aussi 🍏';

  @override
  String get savingsLabel => 'Épargne';

  @override
  String get savingsCategoryTab => 'Catégories d\'épargne';

  @override
  String get category_savings_bank_name => 'Épargne';

  @override
  String get category_savings_bank_desc => 'Un petit pécule qui grandit petit à petit 🏦';

  @override
  String get category_savings_invest_name => 'Investissement/Actions';

  @override
  String get category_savings_invest_desc => 'Semer des graines de fruits pour demain 📈';

  @override
  String get category_savings_housing_name => 'Épargne logement';

  @override
  String get category_savings_housing_desc => 'Le doux rêve d\'avoir son propre logement 🏠';

  @override
  String get category_savings_isa_name => 'Compte d\'épargne défiscalisé';

  @override
  String get category_savings_isa_desc => 'Une pochette fiscale fiable et polyvalente 🛡️';

  @override
  String get category_savings_emergency_name => 'Fonds d\'urgence';

  @override
  String get category_savings_emergency_desc => 'Un coussin sur lequel compter à tout moment 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return '$amount mL enregistrés en épargne pour « $category » ! 🌱';
  }

  @override
  String get statsTotalIncomeTitle => 'Revenu total';

  @override
  String get statsTotalSavingsTitle => 'Épargne totale';

  @override
  String get incomeCategoryTitleStats => 'Revenus par catégorie';

  @override
  String get savingsCategoryTitleStats => 'Épargne par catégorie';

  @override
  String get savingsOverviewSectionTitle => '🌱 Épargne & investissements';

  @override
  String get savingsThisMonthTotalLabel => 'Total épargné et investi ce mois-ci';

  @override
  String get savingsOverviewEmptyMessage => 'Aucune épargne ou investissement enregistré pour le moment';

  @override
  String get scopeThisMonth => 'ce mois-ci';

  @override
  String get calendarSettingsTitle => 'Paramètres du calendrier';

  @override
  String get calendarStartDayLabel => 'Jour de début du calendrier';

  @override
  String get calendarStartMon => 'Début le lundi';

  @override
  String get calendarStartSun => 'Début le dimanche';

  @override
  String get calendarAmountMode => 'Affichage des montants';

  @override
  String get calendarCompactAmount => 'Compact (ex. 56 k)';

  @override
  String get calendarFullAmount => 'Montant complet (ex. 56 000)';

  @override
  String get calendarShowNoSpendStamp => 'Afficher le tampon jour sans dépense';

  @override
  String get calendarHighlightWeekend => 'Mettre en couleur le week-end';

  @override
  String get savingsAllTimeTotalLabel => 'Total épargné et investi (cumulé)';

  @override
  String get currencyWarningNotice => 'Les montants sont recalculés avec les taux en temps réel, ce qui peut créer de légers écarts sur les données passées. À ne changer qu\'en cas de nécessité !';

  @override
  String get onboardingStep1Title => 'Définissons un budget de dépenses confortable';

  @override
  String get onboardingBudgetLabelDaily => 'Budget quotidien';

  @override
  String get onboardingBudgetLabelWeekly => 'Budget de la semaine';

  @override
  String get onboardingBudgetLabelMonthly => 'Budget du mois';

  @override
  String get onboardingStep1NextButton => 'Suivant : définir un objectif à long terme (1/2)';

  @override
  String get onboardingFooterHint => 'Vous pourrez toujours changer cela plus tard dans les paramètres !';

  @override
  String get onboardingStep2Title => 'Avez-vous un objectif d\'épargne pour dans quelques années ?';

  @override
  String get onboardingStep2Subtitle => 'Définissez un objectif et nous calculerons intelligemment votre épargne mensuelle et le juice disponible.';

  @override
  String get onboardingDurationLabel => 'Durée de l\'objectif';

  @override
  String get onboardingGoalAmountLabel => 'Montant de l\'objectif';

  @override
  String get onboardingCompleteButton => 'Définir l\'objectif et commencer';

  @override
  String get onboardingSkipButton => 'Passer pour l\'instant';

  @override
  String get commonBack => 'Retour';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return 'Le juice (mL), c\'est de l\'argent que vous pouvez dépenser ! (1$symbol = 1 mL)';
  }

  @override
  String get customDuration => 'Personnalisé';

  @override
  String get yearUnit => 'an';

  @override
  String get monthUnit => 'mois';

  @override
  String totalDurationLabel(Object months) {
    return 'Total $months mois';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return 'Épargnez environ $amount par mois pendant $months mois et vous atteindrez votre objectif ! 🌱';
  }

  @override
  String get onboardingChooseGoalType => 'Par quel objectif souhaitez-vous commencer ?';

  @override
  String get onboardingShortTermTitle => 'Un budget léger à court terme';

  @override
  String get onboardingShortTermDesc => 'Définissez combien de juice siroter aujourd\'hui, cette semaine ou ce mois-ci, et gérez vos dépenses en toute légèreté.';

  @override
  String get onboardingLongTermTitle => 'Un objectif d\'épargne solide à moyen/long terme';

  @override
  String get onboardingLongTermDesc => 'Définissez l\'objectif global à atteindre dans quelques années et épargnez intelligemment pour y parvenir.';

  @override
  String get startWithJuice => 'Remplir le juice et commencer';

  @override
  String get startWithLongPlan => 'Enregistrer le plan et commencer';

  @override
  String get category_income_salary_name => 'Salaire';

  @override
  String get category_income_salary_desc => 'Le doux fruit de votre travail 💼';

  @override
  String get category_income_side_name => 'Revenu complémentaire';

  @override
  String get category_income_side_desc => 'Un petit bonus de miel qui s\'infiltre 🍯';

  @override
  String get category_income_allowance_name => 'Argent de poche';

  @override
  String get category_income_allowance_desc => 'Un charmant cadeau surprise 🎁';

  @override
  String get category_income_finance_name => 'Revenus de placement';

  @override
  String get category_income_finance_desc => 'De l\'argent qui a fait grandir l\'argent 📈';

  @override
  String get category_income_etc_name => 'Autre revenu';

  @override
  String get category_income_etc_desc => 'D\'autres revenus variés 💧';
}
