import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/dimens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';
import 'package:traffic/view_models/color_view_model.dart';
import 'package:traffic/view_models/textstyle_view_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);

    return Scaffold(
      body: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: providerColor.gradientColorBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              child: SvgPicture.asset(
                assetIconReturn,
                height: 40,
               
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: sizedBoxLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textForgotPass.toUpperCase(),
                    style: providerTextStyle.textStyleTextBold(),
                  ),
                  const SizedBox(
                    height: sizedBoxLarge,
                  ),
                  Text(
                    textEmail,
                    style: providerTextStyle.textStyleTextBold(),
                  ),
                  const SizedBox(
                    height: sizedBoxMedium,
                  ),
                  CustomTextFormField(
                    width: ScreenSize.width * 0.9,
                    validator: (value) {
                      return null;
                    },
                    controller: controllerEmail,
                    textInputType: TextInputType.emailAddress,
                    isHide: false,
                    textStyle: providerTextStyle.textStyleText(),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: sizedBoxLarge,
                  ),
                  Center(
                    child: CustomButton(
                      text: textGetPassword,
                      function: () {},
                      height: heightButton,
                      width: widthButtonLogin + 50,
                      textStyle: providerTextStyle.textStyleTextBold(),
                      borderRadius: borderRadiusButtonLarge,
                      color: colorButton,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
