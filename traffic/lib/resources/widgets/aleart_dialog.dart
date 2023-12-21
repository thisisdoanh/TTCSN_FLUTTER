import 'dart:async';

import 'package:flutter/material.dart';

class CustomDialog {
  void showErrorDialog(BuildContext context, String content) {
    // Hiển thị alert dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Lỗi"),
          content: Text(content),
        );
      },
    );

    // Tự động đóng alert dialog sau 1 giây
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
}
