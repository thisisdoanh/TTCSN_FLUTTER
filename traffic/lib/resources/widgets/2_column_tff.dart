// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';

import '../../view_models/textstyle_view_model.dart';
import '../dimens.dart';

class Custom2ColumnTFF extends StatelessWidget {
  Custom2ColumnTFF({
    super.key,
    required this.providerTextStyle,
    required this.controller,
    required this.text,
    required this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.isReadOnly, this.onPressTFF,
  });

  final String text;
  final TextStyleViewModel providerTextStyle;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  bool? isReadOnly = false;
  final Function? onPressTFF;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: providerTextStyle.textStyleTextBoldTitleDetailProject(),
          ),
        ),
        Expanded(
          flex: 2,
          child: CustomTextFormField(
            onPressTFF: (){
               if (onPressTFF != null) {
            onPressTFF!();
          }
            },
            width: ScreenSize.width * 0.5,
            validator: validator,
            controller: controller,
            textInputType: textInputType,
            isHide: false,
            isReadOnly: isReadOnly ?? false,
            textStyle: providerTextStyle.textStyleText(),
            textInputAction: textInputAction,
          ),
        ),
      ],
    );
  }
}
