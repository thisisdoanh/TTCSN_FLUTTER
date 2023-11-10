import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/button.dart';

import '../resources/dimens.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);

    return Scaffold(
      appBar:
          CustomAppbar(function: () {}, checkLeading: true, checkAction: false),
      body: Container(
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.gradientColorBackground,
        child: Column(
          children: [
            const SizedBox(
              height: sizedBoxLarge,
            ),
            const CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  "https://blogchiasekienthuc.com/wp-content/uploads/2022/12/hinh-nen-may-tinh-fantasy-4k-blogchiasekienthuc.com-1.png",
                  scale: 1),
            ),
            const SizedBox(
              height: sizedBoxLarge,
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: ScreenSize.height * 0.1,
                    left: ScreenSize.width * 0.05,
                    child: Column(
                      children: [
                        CustomButton(
                          text: textUserInfo,
                          function: () {
                            Navigator.pushNamed(context, routeUserInfor);
                          },
                          height: heightButton,
                          width: ScreenSize.width * 0.9,
                          textStyle: providerTextStyle.textStyleTextBold(),
                          borderRadius: borderRadiusButtonLarge,
                          color: colorButton,
                          iconSuffix: Icons.person_outline,
                          colorIcon: colorTextBlack,
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomButton(
                          text: textSelectColor,
                          function: () {},
                          height: heightButton,
                          width: ScreenSize.width * 0.9,
                          textStyle: providerTextStyle.textStyleTextBold(),
                          borderRadius: borderRadiusButtonLarge,
                          color: colorButton,
                          iconSuffix: Icons.color_lens_outlined,
                          colorIcon: colorTextBlack,
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomButton(
                          text: textLogOut,
                          function: () {},
                          height: heightButton,
                          width: ScreenSize.width * 0.9,
                          textStyle: providerTextStyle.textStyleTextBold(),
                          borderRadius: borderRadiusButtonLarge,
                          color: colorButton,
                          iconSuffix: Icons.logout,
                          colorIcon: colorTextBlack,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
