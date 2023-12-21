import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/resources/widgets/detail_project.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';
import 'package:traffic/view_models/controller.dart';
import 'package:traffic/view_models/user_infor_view_model.dart';

import '../resources/dimens.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<UserInforViewModel>(context);
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);
    final providerController = Provider.of<Controller>(context);

    return Scaffold(
      appBar:
          CustomAppbar(function: () {}, checkLeading: true, checkAction: false),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.isGradient ? providerColor.gradientColorBackground : null,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: sizedBoxMedium,
              ),
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(assetImgUser),
              ),
              const SizedBox(
                height: sizedBoxLarge,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: "$textName:",
                data: providerController.user?.name ?? "",
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textAge,
                data: providerController.user?.age.toString() ?? "",
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textGender,
                data: providerController.user?.gender.toString() ?? "",
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textAddress,
                data: providerController.user?.address.toString() ?? "",
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textAccount,
                data: providerController.user?.username.toString() ?? "",
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textEmail,
                data: providerController.user?.email.toString() ?? "",
              ),
              const SizedBox(
                height: sizedBoxLarge,
              ),
              CustomButton(
                text: textEdit,
                function: () {
                  Navigator.pushNamed(context, routeEditUserInfor);
                },
                height: heightButton,
                width: ScreenSize.width * 0.4,
                textStyle: providerTextStyle.textStyleTextBold(),
                borderRadius: borderRadiusButtonLarge,
                color: colorButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
