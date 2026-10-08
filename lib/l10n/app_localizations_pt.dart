import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Juice Budget';

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String get setBudgetTitle => 'Defina seu orçamento de juice';

  @override
  String get weeklyBudget => 'Juice restante nesta semana';

  @override
  String get paymentCheckCard => 'Cartão de débito';

  @override
  String get paymentCreditCard => 'Cartão de crédito';

  @override
  String get defaultCheckCardName => 'Cartão de débito (padrão)';

  @override
  String get defaultCreditCardName => 'Cartão de crédito (padrão)';

  @override
  String get paymentCash => 'Dinheiro · Transferência';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonAdd => 'Adicionar';

  @override
  String get commonNext => 'Avançar';

  @override
  String get goalSettingsTitle => 'Configurações de meta';

  @override
  String get activePeriodSectionTitle => 'Período de meta ativo';

  @override
  String get activePeriodSectionDescription => 'O período em que o medidor da tela inicial se baseia. Preencha a meta de cada período abaixo para que a troca seja aplicada instantaneamente.';

  @override
  String get weekStartDayTileTitle => 'Dia de início da semana';

  @override
  String get periodTargetSectionTitle => 'Valor meta por período';

  @override
  String get periodTargetSectionDescription => 'Salve um valor meta separado para cada período e escolha o que você precisa.';

  @override
  String get periodTargetAmountSuffix => 'Valor meta';

  @override
  String get installmentSectionTitle => 'Forma de considerar parcelamentos';

  @override
  String get installmentSectionDescription => 'Escolha quando e como as despesas parceladas aparecem no calendário/medidor de juice.';

  @override
  String get recommendedSuffix => 'Recomendado';

  @override
  String get savingsPlanSectionTitle => 'Planejador de poupança de médio/longo prazo';

  @override
  String get savingsPlanSectionDescription => 'Informe sua renda mensal, despesas fixas e meta de poupança para calcular quanto juice você pode gastar.';

  @override
  String get savingsPlanToggleTitle => 'Você tem uma meta de poupança de médio/longo prazo?';

  @override
  String get autoBudgetSetMessage => 'Metas diária/semanal/mensal definidas automaticamente 🍊';

  @override
  String get savingsPlanSummaryTitle => '🍊 Resumo do meu plano de juice';

  @override
  String get replanButton => 'Refazer o plano';

  @override
  String get applyBudgetButton => 'Definir juice automaticamente com este orçamento';

  @override
  String durationYearsAndMonths(Object years, Object months) {
    return '$years ano(s) e $months mês(es)';
  }

  @override
  String durationYearsOnly(Object years) {
    return '$years ano(s)';
  }

  @override
  String durationMonthsOnly(Object months) {
    return '$months mês(es)';
  }

  @override
  String savingsPlanGoalLine(Object duration, Object amount) {
    return 'Meta: economizar $amount em $duration';
  }

  @override
  String savingsPlanFixedExpenseLine(Object amount) {
    return 'Custos fixos (inevitáveis): $amount/mês';
  }

  @override
  String get savingsPlanMonthlyRequiredLabel => 'Valor a poupar por mês';

  @override
  String savingsPlanMonthlyRequiredAmount(Object amount) {
    return '$amount';
  }

  @override
  String get savingsPlanAchievementRateLabel => 'Taxa de conquista da meta';

  @override
  String get savingsPlanRecommendedSectionLabel => 'Orçamento de gastos recomendado';

  @override
  String get savingsPlanDailyGridLabel => 'Por dia';

  @override
  String get savingsPlanWeeklyGridLabel => 'Esta semana';

  @override
  String get savingsPlanMonthlyGridLabel => 'Este mês';

  @override
  String get savingsPlanViewInAssetsButton => 'Ver detalhes na aba Patrimônio';

  @override
  String savingsPlanActualTraceLine(Object actual, Object goal, Object percent) {
    return 'Poupança real $actual / meta $goal ($percent%)';
  }

  @override
  String get manageFixedIncomesButton => 'Gerenciar rendas fixas';

  @override
  String savingsPlanFixedIncomeTotalLine(Object total) {
    return 'Total de renda fixa: $total';
  }

  @override
  String savingsPlanRecommendedLine(Object daily, Object weekly, Object monthly) {
    return 'Juice recomendado: $daily mL/dia · $weekly mL/semana · $monthly mL/mês';
  }

  @override
  String savingsPlanPaceFasterLine(Object months) {
    return 'No ritmo atual, você vai atingir a meta $months meses mais cedo! 🚀';
  }

  @override
  String savingsPlanPaceSlowerLine(Object months) {
    return 'No ritmo atual, você pode ficar $months meses atrás do planejado. Você consegue 💪';
  }

  @override
  String get savingsPlanPaceOnTrackLine => 'Seu ritmo atual está perfeitamente alinhado com o plano! Continue assim 🍊';

  @override
  String get recalibrateButton => 'Mudança de renda · Recalibrar';

  @override
  String get recalibrateSheetTitle => 'Recalibrar plano';

  @override
  String get recalibrateSheetSubtitle => 'Informe sua nova renda mensal e escolha uma das duas formas de aplicá-la agora.';

  @override
  String get recalibrateIncomeFieldLabel => 'Nova renda mensal';

  @override
  String get recalibrateShortenOption => 'Encurtar o prazo da meta';

  @override
  String recalibrateShortenPreview(Object before, Object after) {
    return 'Mantenha seu orçamento de vida atual e encurte o prazo de $before para $after meses.';
  }

  @override
  String get recalibrateShortenUnavailable => 'Com essa renda, não é possível encurtar o prazo mantendo seu orçamento de vida atual.';

  @override
  String get recalibrateBoostOption => 'Aumentar o juice (orçamento de vida)';

  @override
  String recalibrateBoostPreview(Object before, Object after) {
    return 'Mantenha o mesmo prazo e aumente seu juice diário de $before mL para $after mL.';
  }

  @override
  String get recalibrateBudgetSliderLabel => 'Orçamento de vida (Juice) deste mês';

  @override
  String get recalibrateWeeklyBudgetLabel => 'Meta semanal';

  @override
  String recalibratePreviewLine(Object before, Object after) {
    return 'Com esse orçamento, o prazo da meta muda de $before para $after meses';
  }

  @override
  String get recalibrateNoSavingsWarning => 'Com esse orçamento, você não vai economizar nada este mês. Tente mover o controle deslizante para a esquerda.';

  @override
  String get recalibrateStatGoal => 'Valor da meta';

  @override
  String get recalibrateStatSaved => 'Já economizado';

  @override
  String get recalibrateStatRemaining => 'Restante';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get savingsCardSectionTitle => 'Cartão de economia da semana';

  @override
  String get savingsCardSectionDescription => 'Transforme uma semana dentro do orçamento em um cartão para compartilhar.';

  @override
  String get generatingCard => 'Gerando cartão...';

  @override
  String get shareCardButton => 'Compartilhar cartão';

  @override
  String shareCardFailedMessage(Object error) {
    return 'Falha ao compartilhar o cartão: $error';
  }

  @override
  String get setTargetAmountFirst => 'Defina primeiro um valor meta';

  @override
  String get menuGoalSettingsTitle => 'Configurações de meta';

  @override
  String get menuGoalSettingsSubtitle => 'Meta de poupança de longo prazo, período de meta, meta por período';

  @override
  String get menuFixedExpenseManagementTitle => 'Gerenciar despesas fixas';

  @override
  String get menuFixedExpenseManagementSubtitle => 'Gerencie itens de despesas fixas e as configurações de preenchimento automático do calendário';

  @override
  String get fixedExpenseManageInfoBanner => 'Vinculado às despesas fixas do seu plano de poupança de médio/longo prazo — se elas aumentarem ou diminuírem, seu orçamento diário/semanal/mensal disponível pode mudar.';

  @override
  String get fixedExpensePaymentDayLabel => 'Dia de pagamento';

  @override
  String fixedExpenseDayOptionLabel(Object day) {
    return 'Dia $day';
  }

  @override
  String get fixedExpenseLastDayOptionLabel => 'Dia 31 (último dia do mês)';

  @override
  String get calendarAutoFillTitle => 'Preenchimento automático de despesas fixas';

  @override
  String get calendarAutoFillSubtitle => 'Registra automaticamente suas despesas fixas no calendário todo mês';

  @override
  String get menuThemeSettingsTitle => 'Configurações de tema';

  @override
  String get menuThemeSettingsSubtitle => 'Modo de tela e tema de juice';

  @override
  String get menuWidgetSettingsTitle => 'Configurações do widget';

  @override
  String get menuWidgetSettingsSubtitle => 'Ocultar valor no widget da tela inicial';

  @override
  String get menuCardManagementTitle => 'Gerenciar meus cartões';

  @override
  String get menuCardManagementSubtitle => 'Cadastre seus cartões e reordene-os';

  @override
  String get menuNotificationSettingsTitle => 'Configurações de notificação';

  @override
  String get menuNotificationSettingsSubtitle => 'Ativar/desativar lembretes de manhã/noite';

  @override
  String get menuBackupSettingsTitle => 'Backup e restauração de dados';

  @override
  String get menuBackupSettingsSubtitle => 'Exportar CSV, exportar/importar arquivo de backup';

  @override
  String get menuSecuritySettingsTitle => 'Segurança';

  @override
  String get menuSecuritySettingsSubtitle => 'Código PIN, autenticação biométrica';

  @override
  String get menuContactSupportTitle => 'Contato e feedback';

  @override
  String get menuContactSupportSubtitle => 'Envie sua opinião por e-mail';

  @override
  String get feedbackTitle => 'Contato e feedback 🍊';

  @override
  String get feedbackTypeBug => 'Reportar bug';

  @override
  String get feedbackTypeFeature => 'Sugerir recurso';

  @override
  String get feedbackTypeOther => 'Outro';

  @override
  String get feedbackEmailHint => 'Seu e-mail (opcional, para resposta)';

  @override
  String get feedbackContentHint => 'Compartilhe sua opinião conosco.';

  @override
  String get feedbackAttachImage => 'Anexar captura de tela';

  @override
  String get feedbackSubmit => 'Enviar';

  @override
  String get feedbackDeviceInfoNotice => 'Informações do dispositivo/SO são incluídas para agilizar o atendimento.';

  @override
  String get feedbackComposeReplyEmail => 'E-mail de resposta';

  @override
  String get feedbackComposeNotEntered => '(não informado)';

  @override
  String get feedbackComposeContent => 'Conteúdo';

  @override
  String get feedbackComposeDeviceInfo => 'Informações do dispositivo';

  @override
  String get feedbackContentRequired => 'Digite sua mensagem';

  @override
  String get feedbackMailUnavailable => 'Não foi possível abrir o app de E-mail, o conteúdo foi copiado.';

  @override
  String get privacyPolicyTitle => 'Política de Privacidade';

  @override
  String get menuPrivacyPolicySubtitle => 'Veja como seus dados pessoais são tratados';

  @override
  String get privacyWelcomeTitle => 'Bem-vindo(a) ao Juice Budget!';

  @override
  String get privacyAgreeNotice => 'O Juice Budget é um controle financeiro 100% local no seu dispositivo — nenhuma das suas informações financeiras ou pessoais é enviada a um servidor externo.';

  @override
  String get viewPrivacyPolicy => 'Ver a Política de Privacidade completa';

  @override
  String get agreeAndStart => 'Concordar e começar';

  @override
  String get savingsCardSuccessMessage => 'O juice desta semana\nficou fresquinho!';

  @override
  String get savingsCardOverMessage => 'O juice desta semana\nderramou um pouco';

  @override
  String savingsCardSpentLine(Object budget, Object spent) {
    return 'Gasto $spent de $budget';
  }

  @override
  String get savingsCardSuccessStamp => 'SUCESSO';

  @override
  String get savingsCardOverStamp => 'PODE MELHORAR';

  @override
  String get pinSetupTitle => 'Definir senha';

  @override
  String get biometricUnlockReason => 'Autentique-se para desbloquear';

  @override
  String get pinConfirmTitle => 'Confirmar senha';

  @override
  String get pinConfirmCurrentTitle => 'Confirmar senha atual';

  @override
  String get pinSetupNewTitle => 'Definir nova senha';

  @override
  String get pinChangedMessage => 'Senha alterada';

  @override
  String get biometricLinkTitle => 'Vincular autenticação biométrica';

  @override
  String get biometricLinkConfirm => 'Deseja vincular a autenticação biométrica?';

  @override
  String get biometricLinkAction => 'Vincular';

  @override
  String get biometricLinkReason => 'Autentique-se para vincular a biometria';

  @override
  String get biometricUnavailableMessage => 'A autenticação biométrica não está disponível';

  @override
  String get securityTitle => 'Segurança';

  @override
  String get securityDescription => 'Bloqueie o app com um PIN ou biometria.';

  @override
  String get appLockTitle => 'Bloqueio do app';

  @override
  String get appLockDescription => 'Proteja o acesso ao app com um PIN de 4 dígitos.';

  @override
  String get changePasswordTitle => 'Alterar senha';

  @override
  String get biometricUseTitle => 'Usar biometria';

  @override
  String get biometricUseDescription => 'Desbloqueie mais rápido com Face ID/impressão digital.';

  @override
  String get csvShareText => 'Histórico de despesas do Juice';

  @override
  String get csvHeaderDate => 'Data';

  @override
  String get csvHeaderCategory => 'Categoria';

  @override
  String get csvHeaderAmount => 'Valor';

  @override
  String get csvHeaderIsFixed => 'Despesa fixa';

  @override
  String get csvHeaderMemo => 'Nota';

  @override
  String get csvUnknownCategory => 'Desconhecido';

  @override
  String get backupShareText => 'Backup de dados do Juice';

  @override
  String backupFailedMessage(Object error) {
    return 'Falha no backup: $error';
  }

  @override
  String get restoreDataTitle => 'Restaurar dados';

  @override
  String get restoreDataConfirm => 'Os dados existentes serão substituídos pelo arquivo de backup. Continuar?';

  @override
  String get restoreAction => 'Restaurar';

  @override
  String get restoreSuccessMessage => 'Restauração concluída';

  @override
  String get restoreFailedMessage => 'Falha na restauração. Verifique se este é um arquivo de backup válido do Juice';

  @override
  String get backupSettingsTitle => 'Backup e restauração de dados';

  @override
  String get exportExpensesTitle => 'Exportar histórico de despesas';

  @override
  String get exportExpensesDescription => 'Compartilhe um CSV com data, categoria, valor, indicador de despesa fixa e memorando.';

  @override
  String get exportingCsv => 'Exportando...';

  @override
  String get exportCsvButton => 'Exportar como CSV';

  @override
  String get backupRestoreTitle => 'Backup · Restauração de dados';

  @override
  String get backupRestoreDescription => 'Faça backup e restaure despesas, receitas, categorias e configurações de orçamento em um único arquivo.';

  @override
  String get backupDataTitle => 'Fazer backup dos dados';

  @override
  String get backupDataDescription => 'Salve via menu de compartilhamento em Arquivos, e-mail, etc.';

  @override
  String get restoreDataTileTitle => 'Restaurar dados';

  @override
  String get restoreDataTileDescription => 'Escolha um arquivo de backup para substituir os dados existentes.';

  @override
  String get categoryDefaultDescription => 'Minha receita especial de juice';

  @override
  String get categoryDeleteTitle => 'Excluir categoria';

  @override
  String categoryDeleteConfirm(Object name) {
    return 'Excluir a categoria \'$name\'?\nAs despesas já registradas serão mantidas.';
  }

  @override
  String get categoryInUseMessage => 'Alguns registros usam esta categoria. Mova-os para outra categoria antes de excluir.';

  @override
  String get categoryEditTitle => 'Editar categoria';

  @override
  String get categoryAddTitle => 'Adicionar categoria';

  @override
  String get categoryNameLabel => 'Nome da categoria';

  @override
  String get categoryDescriptionLabel => 'Descrição curta';

  @override
  String get colorLabel => 'Cor';

  @override
  String get iconLabel => 'Ícone';

  @override
  String get categoryManageTitle => 'Gerenciar categorias';

  @override
  String get expenseCategoryTab => 'Categorias de despesa';

  @override
  String get incomeCategoryTab => 'Categorias de receita';

  @override
  String get defaultCategoryUndeletable => 'Categorias padrão não podem ser excluídas';

  @override
  String get cardDeleteTitle => 'Excluir cartão';

  @override
  String cardDeleteConfirm(Object name) {
    return 'Excluir o cartão \'$name\'?\nAs despesas já registradas serão mantidas.';
  }

  @override
  String get cardEditTitle => 'Editar cartão';

  @override
  String get cardAddTitle => 'Adicionar cartão';

  @override
  String get cardNameLabel => 'Nome do cartão';

  @override
  String get cardTypeLabel => 'Tipo de cartão';

  @override
  String get cardManagementTitle => 'Gerenciar meus cartões';

  @override
  String get defaultCardLastOneUndeletable => 'Este é o único cartão deste tipo, por isso não pode ser excluído. Adicione outro primeiro.';

  @override
  String get cardTypeCorporate => 'Corporativo/Empresarial';

  @override
  String get cardTypeCorporateExcluded => 'Corporativo (despesa) · Excluído do juice';

  @override
  String get corporateExpenseNotice => '🏢 Despesas corporativas/empresariais dispensam a seleção de categoria e são automaticamente excluídas dos seus gastos pessoais.';

  @override
  String get corporateBadgeLabel => '🏢 Corporativo/Empresarial · Excluído do pessoal';

  @override
  String get corporateCardLabel => 'Cartão corporativo/empresarial';

  @override
  String get corporateMemoRequired => 'Informe um memorando (finalidade) para despesas corporativas/empresariais';

  @override
  String get juiceThemeLabel => 'Tema de juice';

  @override
  String get themeSettingsTitle => 'Configurações de tema';

  @override
  String get screenModeLabel => 'Modo de tela';

  @override
  String get themeModeSystem => 'Sistema';

  @override
  String get themeModeLight => 'Claro';

  @override
  String get themeModeDark => 'Escuro';

  @override
  String get juiceThemeDescription => 'Escolha a cor do juice que muda conforme seu orçamento restante. Ela também se torna a cor de destaque do app.';

  @override
  String get themeOrange => 'Laranja';

  @override
  String get themeStrawberry => 'Morango';

  @override
  String get themeApple => 'Maçã';

  @override
  String get themeGrape => 'Uva';

  @override
  String get themeBlueberry => 'Mirtilo';

  @override
  String get themeMulberry => 'Amora';

  @override
  String get themeRandom => 'Aleatório (toda vez que abrir o app)';

  @override
  String get widgetSettingsTitle => 'Configurações do widget';

  @override
  String get homeScreenWidgetTitle => 'Widget da tela inicial';

  @override
  String get homeScreenWidgetDescription => 'Você pode adicionar um widget de medidor de juice e um widget de registro rápido à tela inicial.';

  @override
  String get hideWidgetAmountTitle => 'Ocultar valor no widget';

  @override
  String get hideWidgetAmountDescription => 'Mostra ***mL e o percentual restante em vez do valor.';

  @override
  String get notificationSettingsTitle => 'Configurações de notificação';

  @override
  String get notificationScheduleDescription => 'Enviaremos lembretes todos os dias às 7h e às 20h para incentivar o registro.';

  @override
  String get receiveNotificationsTitle => 'Receber notificações do Juice';

  @override
  String get receiveNotificationsDescription => 'Também vamos te lembrar de voltar caso você fique um tempo sem abrir o app.';

  @override
  String get navHome => 'Início';

  @override
  String get navCalendar => 'Calendário';

  @override
  String get navAssets => 'Patrimônio';

  @override
  String get navStats => 'Estatísticas';

  @override
  String get navSettings => 'Ajustes';

  @override
  String todayInstallmentLabel(Object amount) {
    return '🧊 Parcela de hoje: $amount mL';
  }

  @override
  String get filterVariableOnlyLong => 'Mostrar apenas variáveis';

  @override
  String get filterAllLong => 'Mostrar tudo';

  @override
  String noGoalTitle(Object period) {
    return 'Ainda não há valor meta definido para $period';
  }

  @override
  String noGoalDescription(Object period) {
    return 'Preencha a meta de $period em Configurações de meta.';
  }

  @override
  String get goToGoalSettings => 'Ir para Configurações de meta';

  @override
  String get noExpensesYet => 'Nenhuma despesa registrada ainda';

  @override
  String remainingJuiceLabel(Object period) {
    return 'Juice restante $period';
  }

  @override
  String spentPercentLabel(Object percent) {
    return '$percent% usado';
  }

  @override
  String get overBudgetMessage1 => 'Que pena! Vamos deixar um pouco de juice para a próxima semana 🍊';

  @override
  String get overBudgetMessage2 => 'O galão de juice esvaziou! Respire fundo esta semana 🥲';

  @override
  String get overBudgetMessage3 => 'Derramou um pouco de juice! Vamos encher tudo de novo na próxima semana 🧃';

  @override
  String get overBudgetMessage4 => 'Até a última gota! Saboreie mais devagar na próxima semana ✨';

  @override
  String get incomeFallbackName => 'Receita';

  @override
  String get unknownCategoryName => 'Desconhecido';

  @override
  String get fixedExpenseLabel => 'Fixa';

  @override
  String installmentProgressLabel(Object index, Object months) {
    return 'Parcela $index/$months';
  }

  @override
  String get deletedMessage => 'Excluído';

  @override
  String get undoAction => 'Desfazer';

  @override
  String get amountAndCategoryRequired => 'Verifique o valor e a categoria';

  @override
  String get expenseLabel => 'Despesa';

  @override
  String get incomeLabel => 'Receita';

  @override
  String editTypeTitle(Object type) {
    return 'Editar $type';
  }

  @override
  String addTypeTitle(Object type) {
    return 'Adicionar $type';
  }

  @override
  String deleteTypeTitle(Object type) {
    return 'Excluir $type';
  }

  @override
  String deleteTypeConfirm(Object type) {
    return 'Excluir este registro de $type?';
  }

  @override
  String get cardSelectLabel => 'Selecionar cartão';

  @override
  String installmentMemoSuffix(Object index, Object months) {
    return '(Parcela $index/$months)';
  }

  @override
  String installmentEditNotice(Object index, Object months) {
    return 'Parcela $index/$months — as outras parcelas não serão alteradas junto';
  }

  @override
  String get lumpSumLabel => 'À vista';

  @override
  String monthsPresetLabel(Object months) {
    return '${months}x';
  }

  @override
  String get customInputLabel => 'Personalizado';

  @override
  String get monthsCountHint => 'Número de meses (2-24)';

  @override
  String installmentMonthlyHint(Object amount, Object months) {
    return 'Será refletido como $amount mL por mês durante $months parcelas';
  }

  @override
  String get memoHint => 'Memorando (opcional)';

  @override
  String get excludeAsFixedTitle => 'Excluir como despesa fixa';

  @override
  String get excludeAsFixedSubtitle => 'Aluguel, seguro, etc. — não considerados no medidor de juice';

  @override
  String incomeRecordedMessage(Object category, Object amount) {
    return 'Receita de \'$category\' de $amount mL recebida! 💰';
  }

  @override
  String expenseRecordedMessage(Object category, Object amount) {
    return '$amount mL registrados em \'$category\'! 🍊';
  }

  @override
  String get calendarTitle => 'Calendário';

  @override
  String monthlyTotalsLine(Object expense, Object income) {
    return 'Este mês: $expense gastos · $income recebidos';
  }

  @override
  String get filterVariableOnlyShort => 'Só variáveis';

  @override
  String get filterAllShort => 'Tudo';

  @override
  String get noExpenseTodayMessage => 'Um dia refrescante sem gastos! 🍊';

  @override
  String get assetsTitle => 'Patrimônio';

  @override
  String get cumulativeNetWorthLabel => 'Patrimônio líquido acumulado';

  @override
  String get cumulativeNetWorthDescription => 'Toda a receita registrada menos as despesas até agora.';

  @override
  String get scopeThisYear => 'este ano';

  @override
  String get scopeLast5Years => 'últimos 5 anos';

  @override
  String totalIncomeLabel(Object scope) {
    return 'Receita total ($scope)';
  }

  @override
  String totalExpenseLabel(Object scope) {
    return 'Despesa total ($scope)';
  }

  @override
  String get netChangeTrendTitle => 'Tendência de variação líquida';

  @override
  String get netChangeTrendDescription => 'Variação líquida = receita menos despesas. Verde é superávit, vermelho é déficit.';

  @override
  String get statsTitle => 'Estatísticas';

  @override
  String get filterFixedIncluded => 'Incluir fixas';

  @override
  String get totalExpenseTitle => 'Despesa total';

  @override
  String get categorySpendingTitle => 'Gastos por categoria';

  @override
  String get paymentMethodSpendingTitle => 'Gastos por forma de pagamento';

  @override
  String get statsPeriodThisWeek => 'Esta semana';

  @override
  String get statsPeriodThisMonth => 'Este mês';

  @override
  String get statsPeriodLast4Weeks => 'Últimas 4 semanas';

  @override
  String get statsPeriodMonthly => 'Mensal';

  @override
  String get statsPeriodYearly => 'Anual';

  @override
  String get cardStatsViewSummary => 'Resumo';

  @override
  String get cardStatsViewByCard => 'Por cartão';

  @override
  String get noExpensesInPeriod => 'Nenhum registro neste período';

  @override
  String get categoryDetailThisMonthTotal => 'Total do mês';

  @override
  String get categoryDetailMonthlyTrendTitle => 'Tendência mensal';

  @override
  String get categoryDetailExpenseListTitle => 'Detalhes das transações';

  @override
  String get categoryDetailEmptyMessage => 'Ainda não há registros';

  @override
  String monthlyTotalLabel(Object month) {
    return 'Total de $month';
  }

  @override
  String get categoryDetailEmptyMonthMessage => 'Nenhuma despesa neste mês 🍊';

  @override
  String get installmentIncludedSuffix => 'com parcelas';

  @override
  String get cardUnassigned => 'Sem cartão definido';

  @override
  String get fillJuiceButton => 'Encher o juice';

  @override
  String get finishWizardButton => 'Começar com esta receita';

  @override
  String get incomeTypeFixed => 'Renda fixa';

  @override
  String get incomeTypeVariable => 'Renda variável';

  @override
  String get incomeTypeAllowance => 'Mesada / Capital inicial';

  @override
  String get freqMonthly => 'Mensal';

  @override
  String get freqBiweekly => 'A cada 2 semanas';

  @override
  String get freqWeekly => 'Semanal';

  @override
  String get questionIncomeFixed => 'Quanto juice (receita) entra por mês? 💰';

  @override
  String get questionIncomeFixedSub => 'Informe o valor que realmente cai na sua conta.';

  @override
  String get questionIncomeVariable => 'Qual é a receita mínima segura que você tem mesmo na baixa temporada? 💼';

  @override
  String get questionIncomeVariableSub => 'Estime de forma conservadora para o plano se manter mesmo em um mês fraco.';

  @override
  String get questionWeeklyExpenseVariable => 'Quanto você planeja gastar por semana com custo de vida (despesas variáveis)?';

  @override
  String get questionIncomeAllowance => 'Quanto de mesada você recebe ou já guardou? 🌱';

  @override
  String get subAllowanceRegular => '🗓️ Mesada regular';

  @override
  String get subAllowanceIrregular => '🎲 Mesada/trabalho eventual irregular';

  @override
  String get questionIrregularMinSave => 'Qual é o valor mínimo que você tem certeza de conseguir poupar todo mês? 🪙';

  @override
  String praiseVariablePlan(Object amount) {
    return '🍊 Com base no seu mínimo de baixa temporada, você pode guardar com segurança pelo menos $amount por ano!\nNos meses em que ganhar mais, use o juice bônus para acelerar sua poupança 🚀';
  }

  @override
  String praiseAllowancePlan(Object amount) {
    return 'Pequenas gotas formam um oceano! Em um ano, você terá $amount de um lindo juice guardado ✨';
  }

  @override
  String get guideExtendGoalPeriod => 'Que tal esticar um pouco o prazo da meta para poupar com tranquilidade dentro da sua mesada? 🍊';

  @override
  String freqConversionCaption(Object monthly, Object weekly) {
    return '≈ $monthly/mês · cerca de $weekly/semana disponível 🍊';
  }

  @override
  String get goalStepQuestion => 'Por quanto tempo e quanto\nvocê quer economizar?';

  @override
  String get yearsFieldLabel => 'anos';

  @override
  String get monthsFieldLabel => 'meses';

  @override
  String get goalAmountFieldLabel => 'Valor meta de poupança';

  @override
  String get fixedExpenseStepQuestion => 'Você tem despesas\nfixas mensais?';

  @override
  String get fixedExpenseDefaultRent => 'Aluguel';

  @override
  String get fixedExpenseDefaultCommunication => 'Conta de telefone';

  @override
  String get fixedExpenseDefaultInsurance => 'Seguro';

  @override
  String get fixedExpenseDefaultSubscription => 'Assinaturas';

  @override
  String get fixedExpenseStepSubtitle => 'Aluguel, seguro, conta de telefone, etc. — custos não contabilizados no galão de juice.';

  @override
  String get itemNameHint => 'Nome do item';

  @override
  String get addItemButton => 'Adicionar item';

  @override
  String get resultStepQuestion => 'Seu plano de juice\nestá completo!';

  @override
  String get resultNegativeMessage => 'Despesas fixas e poupança excedem a receita 😥 Volte e ajuste a meta ou o prazo.';

  @override
  String resultBreakdownLine(Object income, Object fixed) {
    return 'Receita mensal $income − custos fixos $fixed − poupança mensal, resta:';
  }

  @override
  String get resultWeeklyPrefix => 'Esta semana: ';

  @override
  String get resultWeeklySuffix => ' de juice para aproveitar! 🍊';

  @override
  String resultDailyMonthlyLine(Object daily, Object monthly) {
    return '$daily mL/dia · $monthly mL/mês';
  }

  @override
  String get periodDaily => 'Hoje';

  @override
  String get periodWeekly => 'Esta semana';

  @override
  String get periodMonthly => 'Este mês';

  @override
  String get periodSettingDaily => 'Diário';

  @override
  String get periodSettingWeekly => 'Semanal';

  @override
  String get periodSettingMonthly => 'Mensal';

  @override
  String get weekStartMonday => 'Começa na segunda (seg.–dom.)';

  @override
  String get weekStartSunday => 'Começa no domingo (dom.–sáb.)';

  @override
  String get installmentModeMonthlyLabel => 'Cobrado de uma vez no mês seguinte';

  @override
  String get installmentModeDailyLabel => 'Cobrado igualmente todos os dias';

  @override
  String get installmentModeMonthlyDescription => 'Como uma fatura de cartão de verdade, o valor da parcela é registrado como despesa uma única vez no dia 1º de cada mês.';

  @override
  String get installmentModeDailyDescription => 'O valor da parcela do mês é dividido pelo número de dias e reduz um pouco o medidor de juice a cada dia.';

  @override
  String get splashOrangeSubText => 'O orçamento da semana, cheio e refrescante';

  @override
  String get splashGreenAppleSubText => 'Um novo hábito de gastar com consciência';

  @override
  String get splashGrapeSubText => 'Protegendo docemente o seu próprio limite';

  @override
  String get splashStrawberrySubText => 'Um dia que se completa muito bem';

  @override
  String get confirmNewPinPrompt => 'Digite novamente sua nova senha';

  @override
  String get enterCurrentPinPrompt => 'Digite sua senha atual';

  @override
  String get enterNewPinPrompt => 'Digite uma nova senha';

  @override
  String get enterPinPrompt => 'Digite sua senha';

  @override
  String get juiceLockTitle => 'O juice está bloqueado';

  @override
  String get pinConfirmMismatchError => 'As senhas não coincidem. Tente novamente';

  @override
  String get pinMismatchError => 'A senha não coincide';

  @override
  String get shareCardText => 'Meu cartão de economia de juice';

  @override
  String get unlockJuiceReason => 'Autentique-se para desbloquear seu juice';

  @override
  String get unlockWithBiometrics => 'Desbloquear com biometria';

  @override
  String yearsPresetLabel(Object years) {
    return '$years ano(s)';
  }

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsCurrency => 'Moeda base';

  @override
  String get currencySelectTitle => 'Selecione sua moeda';

  @override
  String get commonDone => 'Concluído';

  @override
  String get currencyNameKrw => 'Won sul-coreano (₩)';

  @override
  String get currencyNameUsd => 'Dólar americano (\$)';

  @override
  String get currencyNameJpy => 'Iene japonês (¥)';

  @override
  String get currencyNameEur => 'Euro (€)';

  @override
  String get currencyNameVnd => 'Dong vietnamita (₫)';

  @override
  String get currencyNameTwd => 'Novo dólar taiwanês (NT\$)';

  @override
  String get currencyNameCny => 'Yuan chinês (¥)';

  @override
  String get currencyNameBrl => 'Real brasileiro (R\$)';

  @override
  String get foreignCurrencyPickerTitle => 'Selecione a moeda de pagamento';

  @override
  String exchangeRateHint(Object converted, Object rate) {
    return '≈ $converted (taxa de hoje: $rate)';
  }

  @override
  String get exchangeRateLoadingMessage => 'Buscando taxa de câmbio...';

  @override
  String get exchangeRateFailedMessage => 'Não foi possível obter a taxa de câmbio. Informe-a manualmente ou use a última taxa conhecida.';

  @override
  String get manualRateEntryToggle => 'Informar taxa manualmente';

  @override
  String manualExchangeRateLabel(Object code, Object baseCode) {
    return '1 $code = ? $baseCode';
  }

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonCopy => 'Copiar';

  @override
  String linkOpenFailedMessage(Object target) {
    return 'Não encontramos um app para abrir: $target';
  }

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String currencyMigrationConfirmMessage(Object toCode) {
    return 'Alterar sua moeda base para $toCode? Todos os valores já registrados serão convertidos automaticamente pela taxa de câmbio atual.';
  }

  @override
  String get currencyMigrationLoadingMessage => 'Convertendo seus registros existentes para a nova moeda... 🍊';

  @override
  String get currencyMigrationFailedMessage => 'Não foi possível obter a taxa de câmbio, então os valores existentes foram mantidos inalterados';

  @override
  String get category_food_name => 'Alimentação';

  @override
  String get category_food_desc => 'Uma energia deliciosa para hoje 🍱';

  @override
  String get category_cafe_name => 'Café & Lanches';

  @override
  String get category_cafe_desc => 'Uma doce colher de alegria ☕️';

  @override
  String get category_transport_name => 'Transporte';

  @override
  String get category_transport_desc => 'Um trajeto tranquilo até o destino 🚌';

  @override
  String get category_shopping_name => 'Compras';

  @override
  String get category_shopping_desc => 'O prazer de se presentear 🛍️';

  @override
  String get category_culture_name => 'Lazer & Cultura';

  @override
  String get category_culture_desc => 'Uma doce recarga para a alma 🎬';

  @override
  String get category_life_name => 'Moradia';

  @override
  String get category_life_desc => 'Um toque fresco para o dia a dia 🧼';

  @override
  String get category_etc_name => 'Outros';

  @override
  String get category_etc_desc => 'Gastos variados do cotidiano 💬';

  @override
  String savedJuiceBadgeLabel(Object amount) {
    return 'Juice economizado +$amount mL';
  }

  @override
  String get savingHistoryTitle => 'Histórico de poupança';

  @override
  String get savingHistoryEmpty => 'Nenhum período concluído ainda.\nFinalize seu primeiro período!';

  @override
  String savingHistorySuccessLine(Object amount) {
    return '+$amount mL economizados!';
  }

  @override
  String savingHistoryOverLine(Object amount) {
    return 'Gasto $amount mL a mais';
  }

  @override
  String savingHistoryDetailLine(Object target, Object spent) {
    return 'Meta $target / Gasto $spent';
  }

  @override
  String get savingOptionTitle => 'O que fazer com o juice restante';

  @override
  String get savingOptionDescription => 'Escolha o que acontece com o orçamento não utilizado ao fim de um período.';

  @override
  String get savingOptionRollover => 'Transferir para o próximo período';

  @override
  String get savingOptionSavings => 'Guardar como reserva de emergência';

  @override
  String get savedJuiceStoreTooltip => 'Cofre de juice';

  @override
  String savingHistoryTotalLabel(Object amount, Object currencyAmount) {
    return 'Juice economizado: $amount mL ($currencyAmount)';
  }

  @override
  String rolloverBonusLabel(Object amount) {
    return 'Inclui +$amount mL transferidos do período anterior';
  }

  @override
  String get savingsAssetCardTitle => 'Patrimônio protegido pela poupança';

  @override
  String get savingsAssetCardDescription => 'Total de juice restante dos períodos concluídos com a opção de poupança.';

  @override
  String get savingPraise_1 => 'Você já economizou tanto! Incrível!! Está cada vez mais perto da sua meta 🍊';

  @override
  String get savingPraise_2 => 'Você manteve seu precioso juice fresquinho! Seus hábitos de poupança estão brilhando ✨';

  @override
  String get savingPraise_3 => 'O juice economizado está virando riqueza de verdade! Continue assim hoje também 🧃';

  @override
  String get savingPraise_4 => 'Poupar é um hábito maravilhoso! Quanto mais seu juice cresce, mais tranquila fica sua mente 🍯';

  @override
  String get savingPraise_5 => 'Muito bem por defender sua meta sem vacilar! Vamos manter o próximo juice fresco também 🍏';

  @override
  String get savingsLabel => 'Poupança';

  @override
  String get savingsCategoryTab => 'Categorias de poupança';

  @override
  String get category_savings_bank_name => 'Poupança';

  @override
  String get category_savings_bank_desc => 'Construindo uma reserva, aos poucos 🏦';

  @override
  String get category_savings_invest_name => 'Investimentos/Ações';

  @override
  String get category_savings_invest_desc => 'Plantando sementes de fruta para amanhã 📈';

  @override
  String get category_savings_housing_name => 'Poupança para imóvel';

  @override
  String get category_savings_housing_desc => 'O doce sonho de ter a própria casa 🏠';

  @override
  String get category_savings_isa_name => 'Conta de poupança com benefício fiscal';

  @override
  String get category_savings_isa_desc => 'Uma bolsinha confiável e versátil para economizar impostos 🛡️';

  @override
  String get category_savings_emergency_name => 'Fundo de emergência';

  @override
  String get category_savings_emergency_desc => 'Um amparo em que você pode contar a qualquer momento 🧃';

  @override
  String savingsRecordedMessage(Object category, Object amount) {
    return '$amount mL registrados em poupança para \'$category\'! 🌱';
  }

  @override
  String get statsTotalIncomeTitle => 'Receita total';

  @override
  String get statsTotalSavingsTitle => 'Poupança total';

  @override
  String get incomeCategoryTitleStats => 'Receita por categoria';

  @override
  String get savingsCategoryTitleStats => 'Poupança por categoria';

  @override
  String get savingsOverviewSectionTitle => '🌱 Poupança e investimentos';

  @override
  String get savingsThisMonthTotalLabel => 'Total economizado e investido este mês';

  @override
  String get savingsOverviewEmptyMessage => 'Nenhuma poupança ou investimento registrado ainda';

  @override
  String get scopeThisMonth => 'este mês';

  @override
  String get calendarSettingsTitle => 'Configurações do calendário';

  @override
  String get calendarStartDayLabel => 'Dia de início do calendário';

  @override
  String get calendarStartMon => 'Começar na segunda-feira';

  @override
  String get calendarStartSun => 'Começar no domingo';

  @override
  String get calendarAmountMode => 'Exibição de valores';

  @override
  String get calendarCompactAmount => 'Compacto (ex.: 56 mil)';

  @override
  String get calendarFullAmount => 'Valor completo (ex.: 56.000)';

  @override
  String get calendarShowNoSpendStamp => 'Mostrar selo de dia sem gastos';

  @override
  String get calendarHighlightWeekend => 'Destacar fim de semana';

  @override
  String get savingsAllTimeTotalLabel => 'Total economizado e investido (histórico)';

  @override
  String get currencyWarningNotice => 'Os valores são recalculados usando taxas em tempo real, o que pode causar pequenas divergências em dados antigos. Altere apenas quando necessário!';

  @override
  String get onboardingStep1Title => 'Vamos definir um orçamento de gastos confortável';

  @override
  String get onboardingBudgetLabelDaily => 'Orçamento diário';

  @override
  String get onboardingBudgetLabelWeekly => 'Orçamento desta semana';

  @override
  String get onboardingBudgetLabelMonthly => 'Orçamento deste mês';

  @override
  String get onboardingStep1NextButton => 'Próximo: definir uma meta de longo prazo (1/2)';

  @override
  String get onboardingFooterHint => 'Você sempre pode mudar isso depois nas Configurações!';

  @override
  String get onboardingStep2Title => 'Você tem uma meta de poupança para daqui a alguns anos?';

  @override
  String get onboardingStep2Subtitle => 'Defina uma meta e calcularemos de forma inteligente sua poupança mensal e o juice disponível.';

  @override
  String get onboardingDurationLabel => 'Duração da meta';

  @override
  String get onboardingGoalAmountLabel => 'Valor da meta';

  @override
  String get onboardingCompleteButton => 'Definir meta e começar';

  @override
  String get onboardingSkipButton => 'Pular por agora';

  @override
  String get commonBack => 'Voltar';

  @override
  String onboardingStep1Subtitle(Object symbol) {
    return 'Juice (mL) é dinheiro que você pode gastar! (1$symbol = 1 mL)';
  }

  @override
  String get customDuration => 'Personalizado';

  @override
  String get yearUnit => 'ano';

  @override
  String get monthUnit => 'mês';

  @override
  String totalDurationLabel(Object months) {
    return 'Total de $months meses';
  }

  @override
  String onboardingMonthlyEstimateMessage(Object months, Object amount) {
    return 'Economize cerca de $amount por mês durante $months meses e você alcançará sua meta! 🌱';
  }

  @override
  String get onboardingChooseGoalType => 'Com qual meta você gostaria de começar?';

  @override
  String get onboardingShortTermTitle => 'Um orçamento leve de curto prazo';

  @override
  String get onboardingShortTermDesc => 'Defina quanto juice você vai tomar hoje, nesta semana ou neste mês, e gerencie os gastos com leveza.';

  @override
  String get onboardingLongTermTitle => 'Uma meta sólida de poupança de médio/longo prazo';

  @override
  String get onboardingLongTermDesc => 'Defina a meta total que você quer alcançar daqui a alguns anos e economize de forma inteligente para chegar lá.';

  @override
  String get startWithJuice => 'Encher o juice e começar';

  @override
  String get startWithLongPlan => 'Salvar o plano e começar';

  @override
  String get category_income_salary_name => 'Salário';

  @override
  String get category_income_salary_desc => 'O doce fruto do seu trabalho 💼';

  @override
  String get category_income_side_name => 'Renda extra';

  @override
  String get category_income_side_desc => 'Um bônus de mel que escorre aos poucos 🍯';

  @override
  String get category_income_allowance_name => 'Mesada';

  @override
  String get category_income_allowance_desc => 'Um presente surpresa encantador 🎁';

  @override
  String get category_income_finance_name => 'Renda de investimentos';

  @override
  String get category_income_finance_desc => 'Dinheiro que fez mais dinheiro crescer 📈';

  @override
  String get category_income_etc_name => 'Outras receitas';

  @override
  String get category_income_etc_desc => 'Outras receitas variadas 💧';

  @override
  String get notifEveningMon1Title => '🍊 Segunda-feira superada!';

  @override
  String get notifEveningMon1Body => 'Feche o dia com 3 segundos organizando os recibos. O primeiro registro da semana é o mais doce.';

  @override
  String get notifEveningMon2Title => '📒 Hora do caderno de segunda';

  @override
  String get notifEveningMon2Body => 'O começo da semana é o que mais importa. Registre o que gastou hoje e metade da gestão do juice já está feita!';

  @override
  String get notifEveningMon3Title => '🧃 Blues de segunda derrotado!';

  @override
  String get notifEveningMon3Body => 'Você sobreviveu ao primeiro dia útil. Registre seus gastos e tenha uma noite aconchegante.';

  @override
  String get notifEveningMon4Title => '☕️ Já registrou o café de segunda?';

  @override
  String get notifEveningMon4Body => 'Na segunda costuma entrar um cafezinho a mais. Não esqueça os gastos pequenos de hoje.';

  @override
  String get notifEveningMon5Title => '🌙 Primeiro dia da semana, e o copo?';

  @override
  String get notifEveningMon5Body => 'Seu juice ainda está bem cheio. Registre só o que gastou e os próximos seis dias ficam mais folgados.';

  @override
  String get notifEveningTue1Title => '🍊 Checagem de juice de terça';

  @override
  String get notifEveningTue1Body => 'Mantenha o embalo de segunda! Registre os gastos de hoje e o ritmo da semana aparece num piscar de olhos.';

  @override
  String get notifEveningTue2Title => '🧾 Antes que os recibos se acumulem!';

  @override
  String get notifEveningTue2Body => 'Recibo acumulado dá mais preguiça de registrar. Dedique um minuto aos de hoje.';

  @override
  String get notifEveningTue3Title => '🥤 Já registrou o almoço de hoje?';

  @override
  String get notifEveningTue3Body => 'Almoço, café, lanchinho… os pequenos são os mais fáceis de esquecer. Que tal registrar tudo antes de dormir?';

  @override
  String get notifEveningTue4Title => '🌿 Pequenos hábitos protegem seu juice';

  @override
  String get notifEveningTue4Body => 'Um minuto de registro na noite de terça protege seu saldo do mês. Você está indo muito bem!';

  @override
  String get notifEveningTue5Title => '🎯 Meta de hoje cumprida?';

  @override
  String get notifEveningTue5Body => 'Se você ficou dentro do juice de hoje, merece aplausos! Abra o app para ver como foi.';

  @override
  String get notifEveningWed1Title => '⛰ Quarta, o topo da semana!';

  @override
  String get notifEveningWed1Body => 'Estamos bem na metade. Confira se o juice dá e planeje a segunda metade.';

  @override
  String get notifEveningWed2Title => '📊 Checagem do nível de juice no meio da semana';

  @override
  String get notifEveningWed2Body => 'Quarta à noite é hora de conferir! Registre os gastos de hoje e veja seu ritmo da semana.';

  @override
  String get notifEveningWed3Title => '🍹 Você passou da metade da semana';

  @override
  String get notifEveningWed3Body => 'Obrigado por chegar até aqui. Registre o que gastou hoje e descanse.';

  @override
  String get notifEveningWed4Title => '🐪 Aguente firme como um camelo';

  @override
  String get notifEveningWed4Body => 'Confira seu copo antes de quinta e sexta chegarem. Registrando agora, o fim de semana fica bem mais seguro.';

  @override
  String get notifEveningWed5Title => '🧮 Metade feita, quanto juice sobrou?';

  @override
  String get notifEveningWed5Body => 'É só registrar que o app faz a conta. Digite os gastos de hoje!';

  @override
  String get notifEveningThu1Title => '🌆 Amanhã é sexta!';

  @override
  String get notifEveningThu1Body => 'Organize os gastos de hoje antes da correria de sexta. Saber seu nível de juice deixa amanhã mais divertido.';

  @override
  String get notifEveningThu2Title => '🛡 Ligue o escudo de sexta';

  @override
  String get notifEveningThu2Body => 'Se tem compromisso amanhã, o juice economizado hoje será seu grande aliado. Registre hoje e prepare-se!';

  @override
  String get notifEveningThu3Title => '🍋 Quinta, a carteira já está coçando';

  @override
  String get notifEveningThu3Body => 'Quanto mais perto do fim de semana, mais a carteira se anima. Registre os gastos de hoje para acalmá-la mais uma vez.';

  @override
  String get notifEveningThu4Title => '📝 A semana está quase no fim';

  @override
  String get notifEveningThu4Body => 'Aguente só mais um pouco e chega o fim de semana! Uma linha registrada na quinta protege a meta da semana.';

  @override
  String get notifEveningThu5Title => '🌙 Checagem do copo de hoje feita?';

  @override
  String get notifEveningThu5Body => 'Chegar à sexta sabendo o nível de juice é bem diferente de chegar sem saber. Confira agora.';

  @override
  String get notifEveningFri1Title => '🍻 A batalha da sexta começou!';

  @override
  String get notifEveningFri1Body => 'Hoje à noite é missão proteger a carteira! Curta a comida e a bebida, mas registre cada pagamento.';

  @override
  String get notifEveningFri2Title => '🔒 Modo guardião da carteira ligado';

  @override
  String get notifEveningFri2Body => 'As tentações da sexta estão chegando. Segure um pouco, confira o registro de hoje e depois aproveite!';

  @override
  String get notifEveningFri3Title => '🍕 Calma antes de abrir o app de delivery!';

  @override
  String get notifEveningFri3Body => 'Veja primeiro o nível do juice. Sobrando bastante? Pode ir! Pouco? Peça meia porção!';

  @override
  String get notifEveningFri4Title => '🎉 Você conseguiu, é sexta';

  @override
  String get notifEveningFri4Body => 'Aproveite, mas sem exagerar nos gastos! Registre o que gastar e na segunda você sorri.';

  @override
  String get notifEveningFri5Title => '🧃 Sexta à noite: não derrame o copo!';

  @override
  String get notifEveningFri5Body => 'Quanto mais animada a sexta, mais fácil o juice vazar. Capture os gastos de hoje no registro.';

  @override
  String get notifEveningSat1Title => '🛍 Registre os passeios de sábado!';

  @override
  String get notifEveningSat1Body => 'Amigos, compras, comida boa… registre tudo o que gastou hoje antes de esquecer.';

  @override
  String get notifEveningSat2Title => '🌇 Curtindo o fim de semana?';

  @override
  String get notifEveningSat2Body => 'Gasto feliz é gasto bom. Só não esqueça de registrar! Amanhã você se arrepende menos.';

  @override
  String get notifEveningSat3Title => '🍰 O gasto doce de hoje, já registrou?';

  @override
  String get notifEveningSat3Body => 'Registrando até os pequenos luxos, a culpa derrete. Que tal deixar uma linha agora?';

  @override
  String get notifEveningSat4Title => '🧺 Hora do acerto de contas do fim de semana';

  @override
  String get notifEveningSat4Body => 'Um dia inteiro fora rende um bolso cheio de recibos. Organize rapidinho antes de dormir.';

  @override
  String get notifEveningSat5Title => '🌙 Checagem de juice de sábado à noite';

  @override
  String get notifEveningSat5Body => 'Mais um dia e seu juice reinicia. Registre os gastos de hoje e feche o dia direitinho.';

  @override
  String get notifEveningSun1Title => '🧺 Domingo à noite: fechando a semana';

  @override
  String get notifEveningSun1Body => 'Deixe o último registro da semana. Olhar para trás deixa a próxima semana bem mais leve.';

  @override
  String get notifEveningSun2Title => '🔄 Amanhã seu juice reinicia';

  @override
  String get notifEveningSun2Body => 'Registre também os gastos de hoje e o boletim da semana está completo! Prepare-se para um juice novinho.';

  @override
  String get notifEveningSun3Title => '🍽 A tentação do delivery de domingo à noite';

  @override
  String get notifEveningSun3Body => 'Basta passar por este último dia para bater a meta da semana! Veja o nível do juice antes de pedir.';

  @override
  String get notifEveningSun4Title => '🏆 Mais uma semana de ótimo trabalho';

  @override
  String get notifEveningSun4Body => 'Você registrou até o fim, impressionante! Acrescente os gastos de hoje e descanse bem.';

  @override
  String get notifEveningSun5Title => '🌌 Última checagem para a nova semana';

  @override
  String get notifEveningSun5Body => 'A partir de amanhã o copo volta a ficar cheio. Feche esta semana direitinho com o registro de hoje.';

  @override
  String get notifMondayTitle => '🍊 Seu juice novo está cheinho!';

  @override
  String get notifMondayBody => 'Você segurou bem a semana passada. Que tal começar a semana com um orçamento cheio e fresquinho? ✨';

  @override
  String get notifWeekday1Title => '🌅 A afirmação do dia';

  @override
  String get notifWeekday1Body => 'Hoje eu uso meu juice com sabedoria. Economizar um pouquinho, sorrir bastante — tenha um ótimo dia!';

  @override
  String get notifWeekday2Title => '🔮 Seu horóscopo de juice de hoje';

  @override
  String get notifWeekday2Body => 'Hoje uma pequena escolha vira uma grande doçura! Pare 3 segundos antes de uma compra por impulso e a sorte vem junto 🍀';

  @override
  String get notifWeekday3Title => '📖 Frase do dia';

  @override
  String get notifWeekday3Body => '“Pequenas gotas formam um oceano.” Os poucos mL que você economiza hoje viram uma grande meta um dia.';

  @override
  String get notifWeekday4Title => '☀️ Bom dia, fique fresquinho!';

  @override
  String get notifWeekday4Body => 'Hoje vai se encher exatamente do jeito que você quer. Comece devagar, um gole de cada vez.';

  @override
  String get notifWeekday5Title => '🍀 Seu ponto de sorte de hoje';

  @override
  String get notifWeekday5Body => 'A sorte de hoje está em “registrar”! Anotar o que gasta deixa a mente e a carteira mais leves.';

  @override
  String get notifWeekday6Title => '🌱 A mentalidade de hoje';

  @override
  String get notifWeekday6Body => 'Você não precisa ser perfeito. Ser um pouco mais econômico que ontem já é ir muito bem.';

  @override
  String get notifWeekday7Title => '🌈 Uma colherada de incentivo';

  @override
  String get notifWeekday7Body => 'Você está indo muito melhor do que imagina. Torcendo pelas suas escolhas inteligentes hoje!';

  @override
  String get notifWeekday8Title => '✨ Horóscopo de hoje: dia de sorte';

  @override
  String get notifWeekday8Body => 'Hoje sua carteira está cheia de boa energia. Generoso onde importa, firme onde não!';

  @override
  String get notifSunday1Title => '🌤 Afirmação de domingo';

  @override
  String get notifSunday1Body => 'Eu vivi bem esta semana e vou dar conta da próxima. Tenha um domingo tranquilo.';

  @override
  String get notifSunday2Title => '📖 Frase de domingo';

  @override
  String get notifSunday2Body => '“O tempo de olhar para trás leva você mais longe.” Hoje é dia de rever com calma o juice da semana.';

  @override
  String get notifSunday3Title => '🔮 Horóscopo de domingo: recarga';

  @override
  String get notifSunday3Body => 'Ótimo dia para recarregar para amanhã! Descanso tranquilo em vez de gastos grandes traz sorte 🍀';

  @override
  String get notifComeback1Title => '🍊 A laranja ficou tão triste que começou a se descascar.';

  @override
  String get notifComeback1Body => 'Dois dias sem aparecer… você não está fugindo do app porque gastou escondido, está? Entre e confesse.';

  @override
  String get notifComeback2Title => '🧃 Está nascendo mofo no fundo da jarra de juice…';

  @override
  String get notifComeback2Body => 'Três dias de recibos sem anotar estão roendo sua conta. Por favor, me abra e corte os gastos podres! 😱';

  @override
  String get notifComeback3Title => '🍋 [URGENTE] Seu saldo está vazando.';

  @override
  String get notifComeback3Body => 'Acha que o dinheiro gasto some se não abrir o app? Os recibos sabem de tudo. Se não vier hoje, eu derrubo o seu copo de juice? 💥';

  @override
  String get notifComeback4Title => '🫗 …Eu fiz alguma coisa errada?';

  @override
  String get notifComeback4Body => 'Uma semana inteira deixando o juice passar fome. O copo vazio está juntando poeira. Sua meta de poupança está voando como poeira… buáá.';

  @override
  String get notifComeback5Title => '💀 Parabéns! Seu juice evaporou por completo.';

  @override
  String get notifComeback5Body => 'Duas semanas sem aparecer, deve estar quebrado. Que tal entrar agora para salvar ao menos a última gota de consciência? 🏃‍♂️💨';

  @override
  String get notifChannelName => 'Lembretes do Juice';

  @override
  String get notifChannelDescription => 'Lembretes matinais e noturnos para anotar gastos e mensagens de incentivo';
}
