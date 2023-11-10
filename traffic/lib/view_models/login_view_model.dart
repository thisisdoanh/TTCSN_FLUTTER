import 'package:flutter/material.dart';
import 'package:traffic/data_sources/api_services.dart';
import 'package:traffic/resources/strings.dart';

class LoginViewModel with ChangeNotifier {
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

  Future<void> sendUser(String username, String password) async {
    await ApiServices().sendUser(username, password);
    notifyListeners();
  }
}
