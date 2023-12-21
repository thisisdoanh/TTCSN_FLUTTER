import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/dimens.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/view_models/color_view_model.dart';

import '../view_models/textstyle_view_model.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);

    return Scaffold(
      body: Container(
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.isGradient ? providerColor.gradientColorBackground : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetImgLogo,
              fit: BoxFit.contain,
              height: ScreenSize.height * 0.2,
            ),
            const SizedBox(
              height: sizedBoxLarge,
            ),
            CustomButton(
              text: textStart,
              function: () {
                Navigator.pushNamed(context, routeLogin);
              },
              height: heightButton,
              width: ScreenSize.width * 0.5,
              textStyle: providerTextStyle.textStyleTextBoldButton(),
              borderRadius: borderRadiusButtonLarge,
              color: colorButton,
            ),
          ],
        ),
      ),
    );
  }
}
