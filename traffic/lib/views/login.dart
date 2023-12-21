// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:traffic/data_sources/api_services.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/utils/loading.dart';
import 'package:traffic/resources/widgets/aleart_dialog.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';
import 'package:traffic/view_models/login_view_model.dart';

import '../resources/dimens.dart';
import '../resources/widgets/appbar.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controllerAccount = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerLogin = Provider.of<LoginViewModel>(context);
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Form(
        key: formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar(
              function: () {},
              checkLeading: false,
              checkAction: false,
              textStyle: providerTextStyle.textStyleTitle(),
              text: textLogin.toUpperCase()),
          body: Container(
            height: ScreenSize.height,
            width: ScreenSize.width,
            decoration: providerColor.isGradient ? providerColor.gradientColorBackground : null,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: sizedBoxMedium,
                              ),
                              Image.asset(
                                assetImgLogo,
                                fit: BoxFit.contain,
                                height: ScreenSize.height * 0.15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: sizedBoxLarge * 1.5,
                        ),
                        Text(
                          textAccount,
                          style: providerTextStyle.textStyleTextBold(),
                        ),
                        const SizedBox(
                          height: sizedBoxSmall,
                        ),
                        CustomTextFormField(
                          width: ScreenSize.width * 0.9,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Vui lòng nhập tên đăng nhập';
                            }
                            if (value.length < 6) {
                              return 'Tên đăng nhập phải có ít nhất 6 ký tự';
                            }
                            return null;
                          },
                          controller: controllerAccount,
                          textInputType: TextInputType.text,
                          isHide: false,
                          textStyle: providerTextStyle.textStyleText(),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        Text(
                          textPass,
                          style: providerTextStyle.textStyleTextBold(),
                        ),
                        const SizedBox(
                          height: sizedBoxSmall,
                        ),
                        CustomTextFormField(
                          width: ScreenSize.width * 0.9,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            if (value.length < 5) {
                              return 'Mật khẩu phải có ít nhất 5 ký tự';
                            }

                            // Kiểm tra chứa chữ hoa và số
                            // if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])')
                            //     .hasMatch(value)) {
                            //   return 'Mật khẩu phải chứa ít nhất một chữ hoa và một số';
                            // }
                            return null;
                          },
                          controller: controllerPassword,
                          textInputType: TextInputType.text,
                          isHide: providerLogin.isShowPass,
                          textStyle: providerTextStyle.textStyleText(),
                          textInputAction: TextInputAction.done,
                          functionSuffixIcon: () =>
                              providerLogin.changeIconShowPass(),
                          suffixIcon: providerLogin.urlIcon,
                        ),
                        const SizedBox(
                          height: sizedBoxSmall * 0.5,
                        ),
                        CupertinoButton(
                          onPressed: () {
                            Navigator.pushNamed(context, routeForgotPassword);
                          },
                          padding: const EdgeInsets.all(padding0),
                          child: Text(
                            "$textForgotPass?",
                            style: providerTextStyle.textStyleTextBold(),
                          ),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        Center(
                          child: CustomButton(
                            text: textLogin,
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                if (context.mounted) {
                                  OverlayState overlayState = Overlay.of(context);
                                  List<OverlayEntry> entries =
                                      createOverlayLoading(context);
                                  for (var element in entries) {
                                    overlayState.insert(element);
                                  }

                                  await providerLogin.sendUser(
                                      controllerAccount.text,
                                      controllerPassword.text,
                                      context);

                                  for (var element in entries) {
                                    element.remove();
                                  }
                                }

                                if (providerLogin.message != "") {
                                  CustomDialog().showErrorDialog(
                                      context, providerLogin.message);
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, routeHomePage, (route) => false);
                                }
                              }
                            },
                            height: heightButton,
                            width: widthButtonLogin,
                            textStyle:
                                providerTextStyle.textStyleTextBoldButton(),
                            borderRadius: borderRadiusButtonLarge,
                            color: colorButton,
                          ),
                        ),
                        const SizedBox(
                          height: sizedBoxLarge,
                        ),
                        Text(
                          textNoAccount,
                          style: providerTextStyle.textStyleTextBold(),
                        ),
                        const SizedBox(
                          height: sizedBoxSmall,
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(padding0),
                          onPressed: () {
                            Navigator.pushNamed(context, routeRegister);
                          },
                          child: Text(
                            textRegister,
                            style: providerTextStyle.textStyleTextBold(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
