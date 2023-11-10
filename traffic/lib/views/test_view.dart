import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:traffic/resources/dimens.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset(
        'assets/icons/image.svg',
        height: ScreenSize.height,
        width: ScreenSize.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
