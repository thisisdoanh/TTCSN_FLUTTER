import 'package:flutter/material.dart';
import 'package:traffic/resources/strings.dart';

import '../data_sources/api_services.dart';

class RegisterViewModel with ChangeNotifier {

  bool _isShowPassword = true;

  String urlIcon = assetIconShowPass;
  String message = "";

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

  Future<void> createUser(
    String name,
    String username,
    String email,
    String password,  BuildContext context,
  ) async {
    message = await ApiServices(context).createUser(name, username, email, password);
    notifyListeners();
  }
}
