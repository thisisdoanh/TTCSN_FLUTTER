import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/dimens.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/detail_project.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';

import '../resources/colors.dart';
import '../resources/widgets/2_column_tff.dart';
import '../resources/widgets/button.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';
import '../view_models/user_infor_view_model.dart';

class EditUserInfoScreen extends StatelessWidget {
  EditUserInfoScreen({super.key});

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController controllerGender = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<UserInforViewModel>(context);
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);
    controllerName.text = providerUser.userInfo.name;
    return Scaffold(
      appBar: CustomAppbar(
        function: () {},
        checkLeading: true,
        checkAction: false,
        text: textEditUserInfo,
        textStyle: providerTextStyle.textStyleText(),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        decoration: providerColor.gradientColorBackground,
        height: ScreenSize.height,
        width: ScreenSize.width,
        child: Column(
          children: [
            SizedBox(
              height: sizedBoxLarge,
            ),
            const CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  "https://blogchiasekienthuc.com/wp-content/uploads/2022/12/hinh-nen-may-tinh-fantasy-4k-blogchiasekienthuc.com-1.png",
                  scale: 1),
            ),
            SizedBox(
              height: sizedBoxLarge * 1.5,
            ),
            Custom2ColumnTFF(
              providerTextStyle: providerTextStyle,
              controller: controllerName,
              text: "$textName:",
              validator: (value) {},
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: sizedBoxMedium,
            ),
            Custom2ColumnTFF(
              providerTextStyle: providerTextStyle,
              controller: controllerAge,
              text: textAge,
              validator: (value) {},
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: sizedBoxMedium,
            ),
            Custom2ColumnTFF(
              providerTextStyle: providerTextStyle,
              controller: controllerAddress,
              text: textAddress,
              validator: (value) {},
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: sizedBoxMedium,
            ),
            Custom2ColumnTFF(
              providerTextStyle: providerTextStyle,
              controller: controllerGender,
              text: textGender,
              validator: (value) {},
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: sizedBoxMedium,
            ),
            CustomButton(
              text: textEdit,
              function: () {
                Navigator.pushNamed(context, routeHomePage);
              },
              height: heightButton,
              width: ScreenSize.width * 0.4,
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
