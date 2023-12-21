// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:traffic/data_sources/api_services.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/dimens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';
import 'package:traffic/view_models/color_view_model.dart';
import 'package:traffic/view_models/textstyle_view_model.dart';

import '../resources/utils/loading.dart';

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
        decoration: providerColor.isGradient ? providerColor.gradientColorBackground : null,
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
                      function: () async {
                        OverlayState overlayState = Overlay.of(context);
                        List<OverlayEntry> entries =
                        createOverlayLoading(context);
                        for (var element in entries) {
                          overlayState.insert(element);
                        }

                        await ApiServices(context).forgotPass(controllerEmail.text);

                        for (var element in entries) {
                          element.remove();
                        }
                        
                        showDialog(context: context, builder: (context) => const AlertDialog(
                          title: Text("The password reset link has been sent to your email. Please verify"),
                        ),);

                        Future.delayed(const Duration(seconds: 3), () => Navigator.pop(context),);

                      },
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
