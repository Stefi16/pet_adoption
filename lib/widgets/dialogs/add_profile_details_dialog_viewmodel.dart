import 'package:flutter/material.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked/stacked.dart';

class AddProfileDetailsDialogViewModel extends BaseViewModel {
  TextEditingController get textController => _textController;
  final TextEditingController _textController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;

  final bool _isPhoneDialog;

  AddProfileDetailsDialogViewModel(this._isPhoneDialog);

  bool get hasFieldError => _hasFieldError;
  bool _hasFieldError = false;
  set _setFieldError(bool value) {
    if (_hasFieldError != value) {
      _hasFieldError = value;
      notifyListeners();
    }
  }

  void init() {
    _focusNode.requestFocus();
  }

  void onFocusChange(bool isFocused) {
    if (isFocused) {
      _setFieldError = false;
      return;
    }

    validateField();
  }

  void _validateUsername() {
    final username = textController.text.removeWhiteSpaces();

    if (username.length > 3) {
      _setFieldError = false;
      return;
    }

    _setFieldError = true;
  }

  void _validatePhone() {
    final String phone = textController.text;

    if (phone.removeWhiteSpaces().isEmpty) {
      _setFieldError = true;
      return;
    }

    late final RegExp phoneRegex;
    if (phone[0] == '+') {
      phoneRegex = RegExp(r'^\+?[0-9]{12}$');
    } else {
      phoneRegex = RegExp(r'^[0-9]{10}$');
    }

    if (!phoneRegex.hasMatch(phone.replaceAll(' ', ''))) {
      _setFieldError = true;
      return;
    }

    _setFieldError = false;
  }

  void validateField() {
    if (_isPhoneDialog) {
      _validatePhone();
    } else {
      _validateUsername();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
