import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dimens.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.width,
    required this.validator,
    required this.controller,
    required this.textInputType,
    required this.isHide,
    required this.textStyle,
    required this.textInputAction,
    this.suffixIcon,
    this.functionSuffixIcon,
  });
  final FormFieldValidator validator;
  final double width;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isHide;
  final TextStyle textStyle;
  final TextInputAction textInputAction;
  final String? suffixIcon;
  final Function? functionSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     border: Border.all(color: colorTextBlack),
      //     borderRadius: BorderRadius.circular(borderRadiusButtonLarge)),
      width: width,
      padding: const EdgeInsets.all(padding0),
      child: TextFormField(
        textInputAction: textInputAction,
        obscureText: isHide,
        validator: validator,
        keyboardType: textInputType,
        controller: controller,
        style: textStyle,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 10, height: 0.5),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(borderRadiusButtonLarge),
          ),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: suffixIcon != null
              ? CupertinoButton(
                  padding: const EdgeInsets.all(padding0),
                  onPressed: () {
                    functionSuffixIcon!();
                  },
                  child: SvgPicture.asset(suffixIcon!),
                )
              : null,
          border: OutlineInputBorder(
            gapPadding: 2.0,
            borderSide: BorderSide(
              color: Colors.orange,
              width: 10,
            ),
            borderRadius: BorderRadius.circular(borderRadiusButtonLarge),
          ),
        ),
      ),
    );
  }
}
