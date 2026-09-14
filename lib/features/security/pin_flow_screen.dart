import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/app_lock_provider.dart';
import 'widgets/pin_dots.dart';
import 'widgets/pin_keypad.dart';

enum PinFlowMode { verify, setup }

/// PIN 확인(verify, 4자리 일치 시 true 반환) 또는 신규 설정(setup, 입력+재입력 일치 시
/// 그 PIN 문자열을 반환) 플로우를 여는 헬퍼.
Future<T?> showPinFlow<T>(BuildContext context,
    {required PinFlowMode mode, String? title}) {
  return Navigator.of(context).push<T>(
    MaterialPageRoute(builder: (_) => PinFlowScreen(mode: mode, title: title)),
  );
}

class PinFlowScreen extends ConsumerStatefulWidget {
  const PinFlowScreen({super.key, required this.mode, this.title});

  final PinFlowMode mode;
  final String? title;

  @override
  ConsumerState<PinFlowScreen> createState() => _PinFlowScreenState();
}

enum _Stage { verifyCurrent, enterNew, confirmNew }

class _PinFlowScreenState extends ConsumerState<PinFlowScreen> {
  late _Stage _stage;
  String _input = '';
  String? _firstNewPin;
  String? _error;

  @override
  void initState() {
    super.initState();
    _stage = widget.mode == PinFlowMode.verify
        ? _Stage.verifyCurrent
        : _Stage.enterNew;
  }

  String _prompt(AppLocalizations loc) => switch (_stage) {
        _Stage.verifyCurrent => loc.enterCurrentPinPrompt,
        _Stage.enterNew => loc.enterNewPinPrompt,
        _Stage.confirmNew => loc.confirmNewPinPrompt,
      };

  Future<void> _onDigit(String digit) async {
    final loc = AppLocalizations.of(context)!;
    if (_input.length >= 4) return;
    setState(() {
      _input += digit;
      _error = null;
    });
    if (_input.length != 4) return;

    switch (_stage) {
      case _Stage.verifyCurrent:
        final ok = await ref.read(appLockProvider.notifier).verifyPin(_input);
        if (!mounted) return;
        if (ok) {
          if (widget.mode == PinFlowMode.verify) {
            Navigator.of(context).pop(true);
          } else {
            setState(() {
              _stage = _Stage.enterNew;
              _input = '';
            });
          }
        } else {
          setState(() {
            _error = loc.pinMismatchError;
            _input = '';
          });
        }
      case _Stage.enterNew:
        setState(() {
          _firstNewPin = _input;
          _stage = _Stage.confirmNew;
          _input = '';
        });
      case _Stage.confirmNew:
        if (_input == _firstNewPin) {
          Navigator.of(context).pop(_input);
        } else {
          setState(() {
            _error = loc.pinConfirmMismatchError;
            _stage = _Stage.enterNew;
            _input = '';
            _firstNewPin = null;
          });
        }
    }
  }

  void _onBackspace() {
    if (_input.isEmpty) return;
    setState(() => _input = _input.substring(0, _input.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(widget.title ?? loc.pinConfirmTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(_prompt(loc), style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(
              _error ?? ' ',
              style: const TextStyle(color: Color(0xFFFF3B30), fontSize: 13),
            ),
            const SizedBox(height: 24),
            PinDots(length: 4, filled: _input.length),
            const Spacer(),
            PinKeypad(onDigit: _onDigit, onBackspace: _onBackspace),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
