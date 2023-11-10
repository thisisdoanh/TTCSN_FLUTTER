// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/routes_screens.dart';

import '../../view_models/color_view_model.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {super.key,
      required this.function,
      required this.checkLeading,
      required this.checkAction,
      this.text,
      this.textStyle});

  final String? text;
  final bool checkLeading;
  final bool checkAction;
  final Function function;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);

    return AppBar(
      backgroundColor: providerColor.appbarColor,
      centerTitle: true,
      title: Text(
        text ?? "",
        style: textStyle,
      ),
      leading: checkLeading == true
          ? CupertinoButton(
              child: SvgPicture.asset(assetIconReturn,
                  height: 50, color: providerColor.colorText),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : Container(),
      actions: [
        checkAction == true
            ? CupertinoButton(
                child: Icon(
                  Icons.menu,
                  color: providerColor.colorText,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, routeSettings);
                },
              )
            : Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
