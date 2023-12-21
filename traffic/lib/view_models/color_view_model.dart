
import 'package:flutter/material.dart';
import 'package:traffic/resources/colors.dart';

class ColorViewModel with ChangeNotifier {

  bool isDarkMode = false;
  bool isGradient = true;

  void change(){
    if (!isDarkMode || isGradient){
      colorText = colorTextBlack;
    } else {
      colorText = colorTextWhite;
    }
    notifyListeners();
  }



  List<BoxDecoration> listGradientColorBackground = [
    const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color.fromRGBO(128, 204, 246, 100),
        Color.fromRGBO(160, 160, 160, 34),
      ], begin: Alignment.topCenter, end: Alignment.bottomLeft),
    ),
    const BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xFF4803B8), Color(0x84890052)],
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft),
    ),
  ];

  List<Color> listColorAppbar = [
    const Color(0xFFA8DF8E),
    const Color(0xFF4803B8),
  ];

  List<Color> listColorText = [
    colorTextBlack,
    colorTextWhite,
  ];

  Color colorText = colorTextBlack;

  BoxDecoration gradientColorBackground = const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color(0xFFA8DF8E),
      Color(0xFFF3FDE8),
      Color(0xFFFFE5E5),
      Color(0xFFFFBFBF),
    ], begin: Alignment.topCenter, end: Alignment.bottomLeft),
  );

  Color appbarColor = const Color(0xFFA8DF8E);

  void chooseBackgroundColor(int index) {
    gradientColorBackground = listGradientColorBackground[index];
    appbarColor = listColorAppbar[index];
    notifyListeners();
  }
}
