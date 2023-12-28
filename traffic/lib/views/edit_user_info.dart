import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/data_sources/api_services.dart';
import 'package:traffic/resources/dimens.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/detail_project.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';

import '../resources/colors.dart';
import '../resources/utils/loading.dart';
import '../resources/widgets/2_column_tff.dart';
import '../resources/widgets/button.dart';
import '../view_models/color_view_model.dart';
import '../view_models/controller.dart';
import '../view_models/textstyle_view_model.dart';
import '../view_models/user_infor_view_model.dart';

class EditUserInfoScreen extends StatelessWidget {
  EditUserInfoScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController controllerGender = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerPhoneNum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerUser = Provider.of<UserInforViewModel>(context);
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);
    final providerController = Provider.of<Controller>(context);
    controllerName.text = providerController.user?.name ?? "";
    controllerAge.text = providerController.user?.age.toString() ?? "";
    controllerAddress.text = providerController.user?.address ?? "";
    controllerGender.text = providerController.user?.gender ?? "";
    controllerPhoneNum.text = providerController.user?.phone ?? "";

    return Scaffold(
      appBar: CustomAppbar(
        function: () {},
        checkLeading: true,
        checkAction: false,
        text: textEditUserInfo,
        textStyle: providerTextStyle.textStyleText(),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: providerColor.isGradient
              ? providerColor.gradientColorBackground
              : null,
          height: ScreenSize.height,
          width: ScreenSize.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: sizedBoxLarge,
                ),
                const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(assetImgUser),
                ),
                const SizedBox(
                  height: sizedBoxLarge * 1.5,
                ),
                Custom2ColumnTFF(
                  providerTextStyle: providerTextStyle,
                  controller: controllerName,
                  text: "$textName:",
                  validator: (value) {
                    if (value.toString().trim() == "") {
                      return "Không được để trống";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                Custom2ColumnTFF(
                  providerTextStyle: providerTextStyle,
                  controller: controllerAge,
                  text: textAge,
                  validator: (value) {
                    if (value.toString().trim() == "") {
                      return "Không được để trống";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                Custom2ColumnTFF(
                  providerTextStyle: providerTextStyle,
                  controller: controllerAddress,
                  text: textAddress,
                  validator: (value) {
                    if (value.toString().trim() == "") {
                      return "Không được để trống";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                Custom2ColumnTFF(
                  providerTextStyle: providerTextStyle,
                  controller: controllerGender,
                  text: textGender,
                  validator: (value) {
                    if (value.toString().trim() == "") {
                      return "Không được để trống";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                Custom2ColumnTFF(
                  providerTextStyle: providerTextStyle,
                  controller: controllerPhoneNum,
                  text: "Số điện thoại:",
                  validator: (value) {
                    if (value.toString().trim() == "") {
                      return "Không được để trống";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomButton(
                  text: textEdit,
                  function: () async {
                    if (formKey.currentState!.validate()) {
                      if (context.mounted) {
                        OverlayState overlayState = Overlay.of(context);
                        List<OverlayEntry> entries =
                            createOverlayLoading(context);
                        for (var element in entries) {
                          overlayState.insert(element);
                        }
                        String message = await ApiServices(context).updateUser(
                            controllerName.text,
                            controllerAge.text,
                            controllerAddress.text,
                            controllerGender.text,
                            controllerPhoneNum.text);
                        for (var element in entries) {
                          element.remove();
                        }

                        showDialog(
                          context:
                          context,
                          builder:
                              (context) =>
                              AlertDialog(
                                title: Text(
                                    message ??
                                        ""),
                              ),
                        );

                        await Future.delayed(
                            const Duration(
                                seconds: 2),
                                () {
                              Navigator.pop(
                                  context);

                            },
                        );


                        Navigator.pushNamedAndRemoveUntil(
                            context, // Navigator.pushNamed(context, routeHomePage);
                            routeHomePage,
                            (route) => false);
                        // Navigator.pushNamed(context, routeHomePage);
                      }
                    }
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
        ),
      ),
    );
  }
}
