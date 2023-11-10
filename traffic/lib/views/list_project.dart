import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/dimens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/view_models/color_view_model.dart';
import 'package:traffic/view_models/textstyle_view_model.dart';

class ListProjectScreen extends StatelessWidget {
  const ListProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);

    return Scaffold(
      appBar: CustomAppbar(
        function: () {},
        checkLeading: false,
        checkAction: true,
      ),
      body: Container(
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.gradientColorBackground,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        textTextProjectHomePageAdmin,
                        style: providerTextStyle.textStyleTextBoldTittle(),
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        text: textTextAddProjectHomePage,
                        function: () {},
                        height: heightButton,
                        width: ScreenSize.width * 0.3,
                        textStyle:
                            providerTextStyle.textStyleTextBoldButtonSmall(),
                        borderRadius: borderRadiusButtonLarge,
                        color: colorButton,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
