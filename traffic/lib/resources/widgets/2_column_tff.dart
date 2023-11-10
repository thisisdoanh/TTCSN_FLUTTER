import 'package:flutter/material.dart';
import 'package:traffic/resources/widgets/text_form_field.dart';

import '../../view_models/textstyle_view_model.dart';
import '../dimens.dart';

class Custom2ColumnTFF extends StatelessWidget {
  const Custom2ColumnTFF({
    super.key,
    required this.providerTextStyle,
    required this.controller,
    required this.text,
    required this.validator,
    required this.textInputAction,
    required this.textInputType,
  });

  final String text;
  final TextStyleViewModel providerTextStyle;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

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
            width: ScreenSize.width * 0.5,
            validator: validator,
            controller: controller,
            textInputType: textInputType,
            isHide: false,
            textStyle: providerTextStyle.textStyleText(),
            textInputAction: textInputAction,
          ),
        ),
      ],
    );
  }
}
