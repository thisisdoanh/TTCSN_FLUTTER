import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';

class TextStyleViewModel with ChangeNotifier {
  static final TextStyleViewModel _instance = TextStyleViewModel._internal();
  factory TextStyleViewModel() => _instance;

  Color _textColor = colorTextBlack;

  Color get textColor => _textColor;

  void changeTextColor(int index) {
    _textColor = colorTextWhite;
    notifyListeners();
  }

  static TextStyleViewModel of(BuildContext context) {
    return Provider.of<TextStyleViewModel>(context, listen: false);
  }

  TextStyle textStyleTextBoldButton() {
    final textColorProvider = TextStyleViewModel();
    final textColor = textColorProvider.textColor;
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: textColor,
      height: 1.0,
    );
  }

  TextStyle textStyleTextBoldButtonSmall() {
    final textColorProvider = TextStyleViewModel();
    final textColor = textColorProvider.textColor;
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: textColor,
      height: 1.0,
    );
  }

  TextStyle textStyleTextBold() {
    final textColorProvider = TextStyleViewModel();
    final textColor = textColorProvider.textColor;
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 19,
      fontWeight: FontWeight.w500,
      color: textColor,
      height: 1.0,
    );
  }

  TextStyle textStyleTextBoldTittle() {
    final textColorProvider = TextStyleViewModel();
    final textColor = textColorProvider.textColor;
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: textColor,
      height: 1.0,
    );
  }

  TextStyle textStyleTextBoldSmall() {
    final textColorProvider = TextStyleViewModel();
    final textColor = textColorProvider.textColor;
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: textColor,
      height: 1.0,
    );
  }

  TextStyle textStyleTextBoldTitleDetailProject() {
    final textColorProvider = TextStyleViewModel();
    final textColor = textColorProvider.textColor;
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: textColor,
      height: 1.0,
    );
  }

  TextStyle textStyleTextDetailProject() {
    final textColorProvider = TextStyleViewModel();
    final textColor = textColorProvider.textColor;
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textColor,
      height: 1.0,
    );
  }

  TextStyle textStyleTitle() {
    final textColorProvider = TextStyleViewModel();
    final textColor = textColorProvider.textColor;
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: textColor,
      height: 1.0,
    );
  }

  TextStyle textStyleText() {
    return const TextStyle(
      fontFamily: "Inter",
      fontSize: 18,
      color: colorTextBlack,
    );
  }

  TextStyleViewModel._internal();
}
