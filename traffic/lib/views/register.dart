import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';
import 'package:traffic/view_models/register_view_model.dart';
import 'package:traffic/view_models/textstyle_view_model.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../resources/widgets/button.dart';
import '../view_models/color_view_model.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();
  final TextEditingController controllerRepeatPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerPass = Provider.of<RegisterViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: CustomAppbar(
          function: () {},
          checkLeading: true,
          checkAction: false,
          textStyle: providerTextStyle.textStyleTitle(),
          text: textRegister.toUpperCase(),
        ),
        body: Container(
          height: ScreenSize.height,
          width: ScreenSize.width,
          decoration: providerColor.gradientColorBackground,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textName,
                        style: providerTextStyle.textStyleTextBold(),
                      ),
                      const SizedBox(
                        height: sizedBoxSmall,
                      ),
                      CustomTextFormField(
                        width: ScreenSize.width * 0.9,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Vui lòng nhập họ và tên';
                          }
                          // Kiểm tra xem họ và tên có chứa ký tự đặc biệt hay không
                          if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            return 'Họ và tên không được chứa ký tự đặc biệt';
                          }
                          return null;
                        },
                        controller: controllerName,
                        textInputType: TextInputType.text,
                        isHide: false,
                        textStyle: providerTextStyle.textStyleText(),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: sizedBoxMedium,
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
                        controller: controllerUsername,
                        textInputType: TextInputType.text,
                        isHide: false,
                        textStyle: providerTextStyle.textStyleText(),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: sizedBoxMedium,
                      ),
                      Text(
                        textEmail,
                        style: providerTextStyle.textStyleTextBold(),
                      ),
                      const SizedBox(
                        height: sizedBoxSmall,
                      ),
                      CustomTextFormField(
                        width: ScreenSize.width * 0.9,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Vui lòng nhập địa chỉ email';
                          }
                          // Kiểm tra xem địa chỉ email có đúng định dạng hay không
                          if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                              .hasMatch(value)) {
                            return 'Địa chỉ email không hợp lệ';
                          }
                          return null;
                        },
                        controller: controllerEmail,
                        textInputType: TextInputType.emailAddress,
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
                          if (value.length < 8) {
                            return 'Mật khẩu phải có ít nhất 8 ký tự';
                          }

                          // Kiểm tra chứa chữ hoa và số
                          if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])')
                              .hasMatch(value)) {
                            return 'Mật khẩu phải chứa ít nhất một chữ hoa và một số';
                          }
                          return null;
                        },
                        controller: controllerPass,
                        textInputType: TextInputType.text,
                        isHide: providerPass.isShowPass,
                        textStyle: providerTextStyle.textStyleText(),
                        textInputAction: TextInputAction.next,
                        functionSuffixIcon: () =>
                            providerPass.changeIconShowPass(),
                        suffixIcon: providerPass.urlIcon,
                      ),
                      const SizedBox(
                        height: sizedBoxMedium,
                      ),
                      Text(
                        textRepeatPass,
                        style: providerTextStyle.textStyleTextBold(),
                      ),
                      const SizedBox(
                        height: sizedBoxSmall,
                      ),
                      CustomTextFormField(
                        width: ScreenSize.width * 0.9,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Vui lòng nhập lại mật khẩu';
                          }
                          if (value != controllerPass.text) {
                            return 'Mật khẩu nhập lại không khớp';
                          }
                          return null;
                        },
                        controller: controllerRepeatPass,
                        textInputType: TextInputType.text,
                        isHide: providerPass.isShowPass,
                        textStyle: providerTextStyle.textStyleText(),
                        textInputAction: TextInputAction.done,
                        functionSuffixIcon: () =>
                            providerPass.changeIconShowPass(),
                        suffixIcon: providerPass.urlIcon,
                      ),
                      const SizedBox(
                        height: sizedBoxMedium,
                      ),
                      Center(
                        child: CustomButton(
                          text: textRegister,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, routeLogin);
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
