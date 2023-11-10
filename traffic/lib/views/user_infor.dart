import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/resources/widgets/detail_project.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';
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

    return Scaffold(
      appBar:
          CustomAppbar(function: () {}, checkLeading: true, checkAction: false),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.gradientColorBackground,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: sizedBoxMedium,
              ),
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://blogchiasekienthuc.com/wp-content/uploads/2022/12/hinh-nen-may-tinh-fantasy-4k-blogchiasekienthuc.com-1.png",
                    scale: 1),
              ),
              const SizedBox(
                height: sizedBoxLarge,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: "$textName:",
                data: providerUser.userInfo.name,
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textAge,
                data: providerUser.userInfo.age.toString(),
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textGender,
                data: providerUser.userInfo.gender,
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textAddress,
                data: providerUser.userInfo.address,
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textAccount,
                data: providerUser.userInfo.username,
              ),
              const SizedBox(
                height: sizedBoxMedium,
              ),
              CustomDetail2Column(
                providerTextStyle: providerTextStyle,
                title: textEmail,
                data: providerUser.userInfo.email,
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
