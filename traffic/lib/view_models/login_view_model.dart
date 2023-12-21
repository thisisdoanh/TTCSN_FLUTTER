import 'package:flutter/material.dart';
import 'package:traffic/data_sources/api_services.dart';
import 'package:traffic/resources/strings.dart';

class LoginViewModel with ChangeNotifier {

  bool _isShowPassword = true;
  String urlIcon = assetIconShowPass;

  String message = "";

  bool get isShowPass => _isShowPassword;
  bool isLoading = false;

  void changeIconShowPass() {
    _isShowPassword = !_isShowPassword;

    if (_isShowPassword == true) {
      urlIcon = assetIconShowPass;
    } else {
      urlIcon = assetIconHidePass;
    }

    notifyListeners();
  }

  Future<void> sendUser(String username, String password, BuildContext context) async {
    message = await ApiServices(context).sendUser(username, password) ?? "";
    // message = await ApiServices(context).fetchUser() ?? "";
    notifyListeners();
  }
}
