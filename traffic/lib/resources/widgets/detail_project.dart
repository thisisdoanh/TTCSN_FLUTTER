import 'package:flutter/material.dart';

import '../../view_models/textstyle_view_model.dart';

class CustomDetail2Column extends StatelessWidget {
  const CustomDetail2Column({
    super.key,
    required this.providerTextStyle,
    required this.title,
    required this.data,
  });

  final TextStyleViewModel providerTextStyle;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: providerTextStyle.textStyleTextBoldTitleDetailProject(),
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: providerTextStyle.textStyleTextDetailProject(),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
