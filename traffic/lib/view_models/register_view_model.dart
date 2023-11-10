import 'package:flutter/material.dart';
import 'package:traffic/resources/strings.dart';

class RegisterViewModel with ChangeNotifier {
  bool _isShowPassword = true;

  String urlIcon = assetIconShowPass;

  bool get isShowPass => _isShowPassword;

  void changeIconShowPass() {
    _isShowPassword = !_isShowPassword;

    if (_isShowPassword == true) {
      urlIcon = assetIconShowPass;
    } else {
      urlIcon = assetIconHidePass;
    }

    notifyListeners();
  }
}
