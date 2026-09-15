import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/thousands_formatter.dart';
import '../../../core/widgets/juice_segmented_tab.dart';
import '../../../data/models/card_item.dart';
import '../../../data/models/category.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/payment_method.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/card_provider.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/currency_provider.dart';
import '../../../providers/expense_provider.dart';
import '../../../services/exchange_rate_service.dart';
import '../../categories/widgets/add_category_dialog.dart';

const _installmentPresets = [1, 2, 3, 6, 12];

/// 지출 추가/수정 바텀시트.
/// [editingExpense]가 주어지면 수정 모드(저장/삭제)로, 아니면 새 지출 추가 모드로 연다.
/// [initialDate]는 추가 모드에서 기본 날짜(예: 캘린더에서 선택한 날짜)를 지정할 때 사용.
Future<void> showAddExpenseSheet(
  BuildContext context, {
  Expense? editingExpense,
  DateTime? initialDate,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddExpenseSheet(
        editingExpense: editingExpense, initialDate: initialDate),
  );
}

class AddExpenseSheet extends ConsumerStatefulWidget {
  const AddExpenseSheet({super.key, this.editingExpense, this.initialDate});

  final Expense? editingExpense;
  final DateTime? initialDate;

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  late final TextEditingController _amountController;
  late final TextEditingController _memoController;
  late final TextEditingController _customInstallmentController;
  late final TextEditingController _splitTotalController;
  String? _selectedCategoryId;
  bool _isFixed = false;
  bool _isIncome = false;
  bool _isSavings = false;
  late DateTime _selectedDate;
  PaymentMethod _paymentMethod = PaymentMethod.checkCard;
  String? _selectedCardId;
  int _installmentMonths = 1;
  bool _customInstallment = false;
  int _splitPeopleCount = 2;
  String? _autoSplitMemoTag;

  /// 이번 지출의 결제 통화. 기본값은 기준 통화(설정 > 통화 단위 설정)이며, 다른 통화를
  /// 고르면 결제일 기준 환율을 조회해 기준 통화로 환산한 뒤 저장한다.
  late CurrencyItem _selectedCurrency;
  double? _exchangeRate;
  bool _isFetchingRate = false;
  bool _manualRateEntry = false;
  late final TextEditingController _manualRateController;

  bool get _isEditing => widget.editingExpense != null;

  /// 외화 결제 선택이 허용되는 경우인지. 수입·저축과 더치페이(자동 계산 필드)는 제외.
  bool get _allowForeignCurrency =>
      !_isIncome && !_isSavings && _paymentMethod != PaymentMethod.splitBill;

  /// 선택된 결제 통화가 소수점 단위(달러/유로 등)를 쓰는 외화일 때만 금액 입력에
  /// 소수점을 허용한다(기준 통화·엔·동 등은 정수 단위 그대로 천 단위 콤마 입력).
  bool get _allowDecimalAmount =>
      _allowForeignCurrency && _selectedCurrency.decimalDigits > 0;

  @override
  void initState() {
    super.initState();
    final editing = widget.editingExpense;
    _amountController = TextEditingController(
      text: editing != null
          ? NumberFormat('#,###')
              .format(editing.originalAmount ?? editing.amount)
          : '',
    );
    _amountController.addListener(() => setState(() {}));
    _memoController = TextEditingController(text: editing?.memo ?? '');
    _selectedCategoryId = editing?.categoryId;
    _isFixed = editing?.isFixed ?? false;
    _isIncome = editing?.isIncome ?? false;
    _isSavings = editing?.isSavings ?? false;
    _selectedDate = editing?.date ?? widget.initialDate ?? DateTime.now();
    _paymentMethod = editing?.paymentMethod ?? PaymentMethod.checkCard;
    _selectedCardId = editing?.cardId;
    _installmentMonths = editing?.installmentMonths ?? 1;
    _customInstallment = !_installmentPresets.contains(_installmentMonths);
    _customInstallmentController = TextEditingController(
        text: _customInstallment ? '$_installmentMonths' : '');
    _splitTotalController = TextEditingController();
    _selectedCurrency = editing?.originalCurrency != null
        ? currencyByCode(editing!.originalCurrency!)
        : ref.read(currencyProvider).currency;
    _exchangeRate = editing?.exchangeRate;
    _manualRateController = TextEditingController(
        text: _exchangeRate != null
            ? NumberFormat('#,##0.####').format(_exchangeRate)
            : '');
  }

  /// 지출/수입/저축 세그먼트 탭 전환(index 0/1/2).
  void _setEntryType(int index) {
    final isIncome = index == 1;
    final isSavings = index == 2;
    if (isIncome == _isIncome && isSavings == _isSavings) return;
    setState(() {
      _isIncome = isIncome;
      _isSavings = isSavings;
      _selectedCategoryId = null;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _memoController.dispose();
    _customInstallmentController.dispose();
    _splitTotalController.dispose();
    _manualRateController.dispose();
    super.dispose();
  }

  /// 더치페이 총액/인원 수가 바뀔 때마다 "내가 낼 주스" 금액을 메인 인풋에 자동 반영하고,
  /// 메모가 비어있거나 이전 자동 태그 그대로면 새 태그로 갱신한다.
  void _onSplitBillInputsChanged(AppLocalizations loc) {
    final total =
        double.tryParse(_splitTotalController.text.replaceAll(',', ''));
    if (total == null || total <= 0 || _splitPeopleCount < 2) return;
    final formatter = NumberFormat('#,###');
    final perPerson = (total / _splitPeopleCount).round();
    final formattedAmount = formatter.format(perPerson);
    if (_amountController.text != formattedAmount) {
      _amountController.text = formattedAmount;
    }
    final tag = loc.splitBillMemoTag(formatter.format(total), _splitPeopleCount);
    final currentMemo = _memoController.text.trim();
    if (currentMemo.isEmpty || currentMemo == _autoSplitMemoTag) {
      _memoController.text = tag;
    }
    _autoSplitMemoTag = tag;
  }

  String _splitBillHint(AppLocalizations loc) {
    final total =
        double.tryParse(_splitTotalController.text.replaceAll(',', ''));
    if (total == null || total <= 0) return '';
    final formatter = NumberFormat('#,###');
    final perPerson = (total / _splitPeopleCount).round();
    return loc.splitBillHint(formatter.format(perPerson),
        formatter.format(total), _splitPeopleCount);
  }

  String _installmentHint(AppLocalizations loc) {
    if (_installmentMonths <= 1) return '';
    final entered = double.tryParse(_amountController.text.replaceAll(',', ''));
    if (entered == null || entered <= 0) return '';
    final isForeign =
        _allowForeignCurrency && _selectedCurrency.code != ref.read(currencyProvider).currency.code;
    if (isForeign && _exchangeRate == null) return '';
    final amount = isForeign ? entered * _exchangeRate! : entered;
    final perMonth = (amount / _installmentMonths).round();
    return loc.installmentMonthlyHint(
        NumberFormat('#,###').format(perMonth), _installmentMonths);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() => _selectedDate = picked);
    // 환율은 결제 날짜 기준이므로, 외화가 선택된 상태에서 날짜가 바뀌면 다시 조회한다.
    if (_selectedCurrency.code != ref.read(currencyProvider).currency.code) {
      _fetchExchangeRate();
    }
  }

  /// 선택된 결제 통화가 기준 통화와 다르면 결제일 기준 환율을 백그라운드로 조회한다.
  /// 실패하거나(오프라인 등) 캐시도 없으면 수동 입력 모드로 전환한다.
  Future<void> _fetchExchangeRate() async {
    final baseCurrency = ref.read(currencyProvider).currency;
    if (_selectedCurrency.code == baseCurrency.code) {
      setState(() {
        _exchangeRate = null;
        _isFetchingRate = false;
        _manualRateEntry = false;
      });
      return;
    }
    setState(() => _isFetchingRate = true);
    final rate = await ExchangeRateService.fetchRate(
      from: _selectedCurrency.code,
      to: baseCurrency.code,
      date: _selectedDate,
    );
    if (!mounted) return;
    setState(() {
      _isFetchingRate = false;
      _exchangeRate = rate;
      _manualRateEntry = rate == null;
      _manualRateController.text =
          rate != null ? NumberFormat('#,##0.####').format(rate) : '';
    });
  }

  Future<void> _openCurrencyPicker() async {
    final loc = AppLocalizations.of(context)!;
    final selected = await showModalBottomSheet<CurrencyItem>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loc.foreignCurrencyPickerTitle,
                  style: Theme.of(sheetContext).textTheme.titleLarge),
              const SizedBox(height: 12),
              for (final c in currencyPresets)
                RadioListTile<String>(
                  value: c.code,
                  groupValue: _selectedCurrency.code,
                  title: Text('${c.symbol}  ${c.displayName(loc)}'),
                  onChanged: (_) => Navigator.of(sheetContext).pop(c),
                ),
            ],
          ),
        ),
      ),
    );
    if (selected != null && selected.code != _selectedCurrency.code) {
      setState(() => _selectedCurrency = selected);
      await _fetchExchangeRate();
    }
  }

  Future<void> _submit() async {
    final loc = AppLocalizations.of(context)!;
    final enteredAmount =
        double.tryParse(_amountController.text.replaceAll(',', ''));
    if (enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.amountAndCategoryRequired)),
      );
      return;
    }

    final baseCurrency = ref.read(currencyProvider).currency;
    final isForeign =
        _allowForeignCurrency && _selectedCurrency.code != baseCurrency.code;
    if (isForeign && _exchangeRate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.exchangeRateFailedMessage)),
      );
      return;
    }
    // 외화로 입력했으면 결제일 기준 환율로 환산한 값을 기준 통화 금액으로 저장하고,
    // 원본 외화 금액/통화/환율은 메타데이터로 함께 남겨 지출 내역에 병기할 수 있게 한다.
    final amount = isForeign ? enteredAmount * _exchangeRate! : enteredAmount;
    final originalAmount = isForeign ? enteredAmount : null;
    final originalCurrency = isForeign ? _selectedCurrency.code : null;
    final exchangeRate = isForeign ? _exchangeRate : null;

    final categoryName = (_isSavings
            ? ref.read(savingsCategoriesProvider)
            : _isIncome
                ? ref.read(incomeCategoriesProvider)
                : ref.read(expenseCategoriesProvider))
        .firstWhere((c) => c.id == _selectedCategoryId)
        .getLocalizedName(context);
    final memo = _memoController.text.trim().isEmpty
        ? null
        : _memoController.text.trim();
    final isNewInstallment = !_isEditing &&
        !_isIncome &&
        !_isSavings &&
        _paymentMethod == PaymentMethod.creditCard &&
        _installmentMonths > 1;

    if (isNewInstallment) {
      final base = Expense(
        id: const Uuid().v4(),
        amount: amount,
        categoryId: _selectedCategoryId!,
        date: _selectedDate,
        memo: memo,
        isFixed: _isFixed,
        cardId: _selectedCardId,
        originalAmount: originalAmount,
        originalCurrency: originalCurrency,
        exchangeRate: exchangeRate,
      );
      await ref
          .read(expenseProvider.notifier)
          .upsertInstallment(base, _installmentMonths);
    } else {
      final excludeCardFields = _isIncome || _isSavings;
      final expense = Expense(
        id: widget.editingExpense?.id ?? const Uuid().v4(),
        amount: amount,
        categoryId: _selectedCategoryId!,
        date: _selectedDate,
        memo: memo,
        isFixed: excludeCardFields ? false : _isFixed,
        isIncome: _isIncome,
        isSavings: _isSavings,
        createdAt: widget.editingExpense?.createdAt,
        paymentMethod:
            excludeCardFields ? PaymentMethod.checkCard : _paymentMethod,
        installmentMonths: widget.editingExpense?.installmentMonths ?? 1,
        currentInstallmentIndex:
            widget.editingExpense?.currentInstallmentIndex ?? 1,
        installmentGroupId: widget.editingExpense?.installmentGroupId,
        cardId: excludeCardFields ? null : _selectedCardId,
        originalAmount: excludeCardFields ? null : originalAmount,
        originalCurrency: excludeCardFields ? null : originalCurrency,
        exchangeRate: excludeCardFields ? null : exchangeRate,
      );
      await ref.read(expenseProvider.notifier).upsert(expense);
    }

    if (!mounted) return;
    if (!_isEditing) {
      final formatter = NumberFormat('#,###');
      final message = _isSavings
          ? loc.savingsRecordedMessage(categoryName, formatter.format(amount))
          : _isIncome
              ? loc.incomeRecordedMessage(categoryName, formatter.format(amount))
              : loc.expenseRecordedMessage(categoryName, formatter.format(amount));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final loc = AppLocalizations.of(context)!;
    final editing = widget.editingExpense;
    if (editing == null) return;
    final label = editing.isSavings
        ? loc.savingsLabel
        : editing.isIncome
            ? loc.incomeLabel
            : loc.expenseLabel;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.deleteTypeTitle(label)),
        content: Text(loc.deleteTypeConfirm(label)),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(loc.commonCancel)),
          FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(loc.commonDelete)),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(expenseProvider.notifier).delete(editing.id);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _openAddCategoryDialog() async {
    final type = _isSavings
        ? CategoryType.savings
        : _isIncome
            ? CategoryType.income
            : CategoryType.expense;
    final newCategoryId =
        await showAddCategorySheet(context, ref, type: type);
    if (newCategoryId != null) {
      setState(() => _selectedCategoryId = newCategoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final baseCurrency = ref.watch(currencyProvider).currency;
    final categories = ref.watch(expenseCategoriesProvider);
    final incomeCategories = ref.watch(incomeCategoriesProvider);
    final savingsCategories = ref.watch(savingsCategoriesProvider);
    if (_isSavings) {
      _selectedCategoryId ??=
          savingsCategories.isNotEmpty ? savingsCategories.first.id : null;
    } else if (_isIncome) {
      _selectedCategoryId ??=
          incomeCategories.isNotEmpty ? incomeCategories.first.id : null;
    } else {
      _selectedCategoryId ??=
          categories.isNotEmpty ? categories.first.id : null;
    }
    final typeLabel = _isSavings
        ? loc.savingsLabel
        : _isIncome
            ? loc.incomeLabel
            : loc.expenseLabel;

    final matchingCards = switch (_paymentMethod) {
      PaymentMethod.checkCard => ref.watch(checkCardsProvider),
      PaymentMethod.creditCard => ref.watch(creditCardsProvider),
      _ => const <CardItem>[],
    };
    if (matchingCards.isEmpty) {
      _selectedCardId = null;
    } else if (!matchingCards.any((c) => c.id == _selectedCardId)) {
      _selectedCardId = matchingCards
          .firstWhere((c) => c.isDefault, orElse: () => matchingCards.first)
          .id;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _isEditing
                            ? loc.editTypeTitle(typeLabel)
                            : loc.addTypeTitle(typeLabel),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (_isEditing)
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        tooltip: loc.commonDelete,
                        onPressed: _delete,
                      ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        JuiceSegmentedTab(
                          items: [loc.expenseLabel, loc.incomeLabel, loc.savingsLabel],
                          selectedIndex: _isSavings ? 2 : (_isIncome ? 1 : 0),
                          onTabChanged: _setEntryType,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _amountController,
                          autofocus: false,
                          readOnly: !_isEditing &&
                              _paymentMethod == PaymentMethod.splitBill,
                          keyboardType: _allowDecimalAmount
                              ? const TextInputType.numberWithOptions(
                                  decimal: true)
                              : TextInputType.number,
                          inputFormatters: _allowDecimalAmount
                              ? [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d{0,2}')),
                                ]
                              : [ThousandsSeparatorInputFormatter()],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                          decoration: InputDecoration(
                            hintText: '0',
                            suffixText: _allowForeignCurrency ? null : ' mL',
                            suffixIcon: _allowForeignCurrency
                                ? _CurrencyPickerButton(
                                    currency: _selectedCurrency,
                                    onTap: _openCurrencyPicker,
                                  )
                                : null,
                            border: InputBorder.none,
                            helperText: !_isEditing &&
                                    _paymentMethod == PaymentMethod.splitBill
                                ? loc.splitBillAutoFillHelper
                                : null,
                          ),
                        ),
                        if (_allowForeignCurrency &&
                            _selectedCurrency.code != baseCurrency.code) ...[
                          const SizedBox(height: 4),
                          _ExchangeRateHint(
                            loc: loc,
                            baseCurrency: baseCurrency,
                            foreignCurrency: _selectedCurrency,
                            enteredAmount: double.tryParse(
                                _amountController.text.replaceAll(',', '')),
                            isFetching: _isFetchingRate,
                            exchangeRate: _exchangeRate,
                            manualRateEntry: _manualRateEntry,
                            manualRateController: _manualRateController,
                            onManualRateChanged: (v) => setState(() =>
                                _exchangeRate =
                                    double.tryParse(v.replaceAll(',', ''))),
                            onToggleManualEntry: () =>
                                setState(() => _manualRateEntry = true),
                            onRetry: _fetchExchangeRate,
                          ),
                        ],
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 86,
                          child: _isSavings || _isIncome
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (_isSavings
                                          ? savingsCategories
                                          : incomeCategories)
                                      .length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 8),
                                  itemBuilder: (context, index) {
                                    final category = (_isSavings
                                        ? savingsCategories
                                        : incomeCategories)[index];
                                    return _CategoryChip(
                                      category: category,
                                      selected:
                                          category.id == _selectedCategoryId,
                                      onTap: () => setState(() =>
                                          _selectedCategoryId = category.id),
                                    );
                                  },
                                )
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length + 1,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 8),
                                  itemBuilder: (context, index) {
                                    if (index == categories.length) {
                                      return _AddCategoryChip(
                                          onTap: _openAddCategoryDialog);
                                    }
                                    final category = categories[index];
                                    return _CategoryChip(
                                      category: category,
                                      selected:
                                          category.id == _selectedCategoryId,
                                      onTap: () => setState(() =>
                                          _selectedCategoryId = category.id),
                                    );
                                  },
                                ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: _pickDate,
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.event_outlined, size: 20),
                                const SizedBox(width: 10),
                                Text(DateFormat('yyyy.M.d (E)', loc.localeName)
                                    .format(_selectedDate)),
                                const Spacer(),
                                const Icon(Icons.chevron_right, size: 18),
                              ],
                            ),
                          ),
                        ),
                        if (!_isIncome && !_isSavings) ...[
                          const SizedBox(height: 8),
                          JuiceSegmentedTab(
                            items: PaymentMethod.values
                                .map((m) => m.label(loc))
                                .toList(),
                            selectedIndex:
                                PaymentMethod.values.indexOf(_paymentMethod),
                            onTabChanged: (index) => setState(() =>
                                _paymentMethod = PaymentMethod.values[index]),
                          ),
                          if (matchingCards.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedCardId,
                              decoration:
                                  InputDecoration(labelText: loc.cardSelectLabel),
                              items: [
                                for (final c in matchingCards)
                                  DropdownMenuItem(
                                      value: c.id, child: Text(c.name)),
                              ],
                              onChanged: (value) => setState(() {
                                _selectedCardId = value;
                                final card = matchingCards
                                    .firstWhere((c) => c.id == value);
                                if (card.type == CardType.corporate) {
                                  _isFixed = true;
                                }
                              }),
                            ),
                          ],
                          if (_isEditing &&
                              widget.editingExpense!.isInstallment) ...[
                            const SizedBox(height: 4),
                            Text(
                              loc.installmentEditNotice(
                                  widget.editingExpense!.currentInstallmentIndex,
                                  widget.editingExpense!.installmentMonths),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                          if (_paymentMethod == PaymentMethod.creditCard &&
                              !_isEditing) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final m in _installmentPresets)
                                  ChoiceChip(
                                    label: Text(m == 1
                                        ? loc.lumpSumLabel
                                        : loc.monthsPresetLabel(m)),
                                    selected: !_customInstallment &&
                                        _installmentMonths == m,
                                    onSelected: (_) => setState(() {
                                      _customInstallment = false;
                                      _installmentMonths = m;
                                    }),
                                  ),
                                ChoiceChip(
                                  label: Text(loc.customInputLabel),
                                  selected: _customInstallment,
                                  onSelected: (_) => setState(() {
                                    _customInstallment = true;
                                    _installmentMonths = int.tryParse(
                                            _customInstallmentController
                                                .text) ??
                                        2;
                                  }),
                                ),
                              ],
                            ),
                            if (_customInstallment) ...[
                              const SizedBox(height: 8),
                              TextField(
                                controller: _customInstallmentController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    hintText: loc.monthsCountHint),
                                onChanged: (v) {
                                  final parsed = int.tryParse(v);
                                  setState(() => _installmentMonths =
                                      parsed == null ? 2 : parsed.clamp(2, 24));
                                },
                              ),
                            ],
                            if (_installmentHint(loc).isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                _installmentHint(loc),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ],
                          ],
                          if (_paymentMethod == PaymentMethod.splitBill &&
                              !_isEditing) ...[
                            const SizedBox(height: 8),
                            TextField(
                              controller: _splitTotalController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                ThousandsSeparatorInputFormatter()
                              ],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  labelText: loc.totalPaymentAmountLabel,
                                  suffixText: ' mL'),
                              onChanged: (_) =>
                                  setState(() => _onSplitBillInputsChanged(loc)),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(loc.splitPeopleCountLabel,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: _splitPeopleCount > 2
                                      ? () => setState(() {
                                            _splitPeopleCount--;
                                            _onSplitBillInputsChanged(loc);
                                          })
                                      : null,
                                ),
                                SizedBox(
                                  width: 48,
                                  child: Text(
                                      loc.peopleCountSuffix(_splitPeopleCount),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => setState(() {
                                    _splitPeopleCount++;
                                    _onSplitBillInputsChanged(loc);
                                  }),
                                ),
                              ],
                            ),
                            if (_splitBillHint(loc).isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                _splitBillHint(loc),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ],
                          ],
                        ],
                        const SizedBox(height: 8),
                        TextField(
                          controller: _memoController,
                          decoration:
                              InputDecoration(hintText: loc.memoHint),
                        ),
                        if (!_isIncome && !_isSavings)
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _isFixed,
                            onChanged: (v) =>
                                setState(() => _isFixed = v ?? false),
                            title: Text(loc.excludeAsFixedTitle),
                            subtitle: Text(loc.excludeAsFixedSubtitle),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 52,
                  child: FilledButton(
                      onPressed: _submit,
                      child: Text(_isEditing ? loc.commonSave : loc.commonAdd)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip(
      {required this.category, required this.selected, required this.onTap});

  final Category category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Color(category.colorValue);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: selected ? 1 : 0.18),
                shape: BoxShape.circle,
                border: selected ? Border.all(color: color, width: 2) : null,
              ),
              child: Icon(
                IconData(category.iconCodePoint,
                    fontFamily: category.iconFontFamily ?? 'MaterialIcons'),
                color: selected ? Colors.white : color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category.getLocalizedName(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddCategoryChip extends StatelessWidget {
  const _AddCategoryChip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1.5),
              ),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 4),
            Text(AppLocalizations.of(context)!.commonAdd,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

/// 금액 입력 필드 우측에 붙는 탭 가능한 결제 통화 표시("$ USD ▾"). 탭하면 외화 선택
/// 바텀시트가 열린다.
class _CurrencyPickerButton extends StatelessWidget {
  const _CurrencyPickerButton({required this.currency, required this.onTap});

  final CurrencyItem currency;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${currency.symbol} ${currency.code}',
                style: Theme.of(context).textTheme.bodyMedium),
            const Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }
}

/// 외화 결제 시 금액 입력 바로 아래에 뜨는 환율 안내. 조회 중/성공/실패 상태에 따라
/// 로딩 문구, "≈ 20,840원 (당일 환율: $1 = 1,344.50원)" 안내, 또는 수동 입력 필드를 보여준다.
class _ExchangeRateHint extends StatelessWidget {
  const _ExchangeRateHint({
    required this.loc,
    required this.baseCurrency,
    required this.foreignCurrency,
    required this.enteredAmount,
    required this.isFetching,
    required this.exchangeRate,
    required this.manualRateEntry,
    required this.manualRateController,
    required this.onManualRateChanged,
    required this.onToggleManualEntry,
    required this.onRetry,
  });

  final AppLocalizations loc;
  final CurrencyItem baseCurrency;
  final CurrencyItem foreignCurrency;
  final double? enteredAmount;
  final bool isFetching;
  final double? exchangeRate;
  final bool manualRateEntry;
  final TextEditingController manualRateController;
  final ValueChanged<String> onManualRateChanged;
  final VoidCallback onToggleManualEntry;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    final dimStyle = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    if (isFetching) {
      return Text(loc.exchangeRateLoadingMessage, style: dimStyle);
    }

    final children = <Widget>[];

    if (exchangeRate != null) {
      final converted = (enteredAmount ?? 0) * exchangeRate!;
      final rateDescription = '1 ${foreignCurrency.code} = '
          '${NumberFormat('#,##0.00').format(exchangeRate)} ${baseCurrency.code}';
      children.add(Text(
        loc.exchangeRateHint(
            baseCurrency.format(converted), rateDescription),
        style: dimStyle,
      ));
      if (!manualRateEntry) {
        children.add(Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            onPressed: onToggleManualEntry,
            child: Text(loc.manualRateEntryToggle,
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ));
      }
    } else {
      children.add(Text(loc.exchangeRateFailedMessage,
          style: dimStyle?.copyWith(color: errorColor)));
      children.add(Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: onRetry,
          child: Text(loc.commonRetry,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ));
    }

    if (manualRateEntry) {
      children.add(TextField(
        controller: manualRateController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          isDense: true,
          labelText:
              loc.manualExchangeRateLabel(foreignCurrency.code, baseCurrency.code),
        ),
        onChanged: onManualRateChanged,
      ));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}
