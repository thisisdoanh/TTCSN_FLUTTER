// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/2_column_tff.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/button.dart';

import '../data_sources/api_services.dart';
import '../resources/dimens.dart';
import '../resources/utils/loading.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final TextEditingController controllerChangePass = TextEditingController();

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
        decoration: providerColor.isGradient
            ? providerColor.gradientColorBackground
            : null,
        child: ScrollConfiguration(
          behavior: const MaterialScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(assetImgUser),
                ),
                const SizedBox(
                  height: sizedBoxLarge,
                ),
                Column(
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
                      text: "Đổi mật khẩu",
                      function: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.white,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: sizedBoxMedium,
                                    ),
                                    const Text(
                                      "Đổi mật khẩu",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: sizedBoxMedium,
                                    ),
                                    Custom2ColumnTFF(
                                      providerTextStyle: providerTextStyle,
                                      controller: controllerChangePass,
                                      text: "Mật khẩu",
                                      validator: (value) {},
                                      textInputAction: TextInputAction.done,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                    ),
                                    const SizedBox(
                                      height: sizedBoxMedium,
                                    ),
                                    Center(
                                      child: CustomButton(
                                        text: "Đổi mật khẩu",
                                        function: () async {
                                          controllerChangePass.text = "";
                                          OverlayState overlayState =
                                              Overlay.of(context);
                                          List<OverlayEntry> entries =
                                              createOverlayLoading(context);
                                          for (var element in entries) {
                                            overlayState.insert(element);
                                          }

                                          await ApiServices(context).changePass(
                                              controllerChangePass.text);

                                          for (var element in entries) {
                                            element.remove();
                                          }

                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const AlertDialog(
                                              title: Text(
                                                  "Changed password successfully!"),
                                            ),
                                          );

                                          Future.delayed(
                                            const Duration(seconds: 2),
                                            () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                        height: heightButton,
                                        width: widthButtonLogin + 50,
                                        textStyle: providerTextStyle
                                            .textStyleTextBold(),
                                        borderRadius: borderRadiusButtonLarge,
                                        color: colorButton,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      height: heightButton,
                      width: ScreenSize.width * 0.9,
                      textStyle: providerTextStyle.textStyleTextBold(),
                      borderRadius: borderRadiusButtonLarge,
                      color: colorButton,
                      iconSuffix: Icons.password,
                      colorIcon: colorTextBlack,
                    ),
                    const SizedBox(
                      height: sizedBoxMedium,
                    ),
                    CustomButton(
                      text: textSelectColor,
                      function: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.white,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              height: max(
                                  MediaQuery.of(context).size.height * 0.35,
                                  MediaQuery.of(context).size.width * 0.4),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: sizedBoxMedium,
                                  ),
                                  const Text(
                                    "Chọn màu nền",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: sizedBoxMedium,
                                  ),
                                  Wrap(
                                    runSpacing: 25,
                                    spacing: 25,
                                    children: [
                                      CupertinoButton(
                                        onPressed: () {
                                          context
                                              .read<ColorViewModel>()
                                              .isDarkMode = false;
                                          context
                                              .read<ColorViewModel>()
                                              .isGradient = false;
                                          context
                                              .read<ColorViewModel>()
                                              .change();
                                          context
                                              .read<TextStyleViewModel>()
                                              .isDarkMode = false;
                                          context
                                              .read<TextStyleViewModel>()
                                              .isGradient = false;
                                          context
                                              .read<TextStyleViewModel>()
                                              .change();
                                          // Provider.of<ColorViewModel>(context, listen: false).isDarkMode = false;
                                          // Provider.of<ColorViewModel>(context, listen: false).isGradient = false;
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          height:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      CupertinoButton(
                                        onPressed: () {
                                          context
                                              .read<ColorViewModel>()
                                              .isDarkMode = true;
                                          context
                                              .read<ColorViewModel>()
                                              .isGradient = false;
                                          context
                                              .read<ColorViewModel>()
                                              .change();
                                          context
                                              .read<TextStyleViewModel>()
                                              .isDarkMode = true;
                                          context
                                              .read<TextStyleViewModel>()
                                              .isGradient = false;
                                          context
                                              .read<TextStyleViewModel>()
                                              .change();
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          height:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      CupertinoButton(
                                        onPressed: () {
                                          context
                                              .read<ColorViewModel>()
                                              .isGradient = true;
                                          context
                                              .read<ColorViewModel>()
                                              .change();
                                          context
                                              .read<TextStyleViewModel>()
                                              .isGradient = true;
                                          context
                                              .read<TextStyleViewModel>()
                                              .change();
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          height:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFFA8DF8E),
                                                    Color(0xFFF3FDE8),
                                                    Color(0xFFFFE5E5),
                                                    Color(0xFFFFBFBF),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomLeft),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
                      function: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, routeLogin, (route) => false);
                      },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
