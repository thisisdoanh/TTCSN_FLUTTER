import 'package:flutter/material.dart';

import '../dimens.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.function,
    required this.height,
    required this.width,
    required this.textStyle,
    required this.borderRadius,
    required this.color,
    this.iconLeading,
    this.iconSuffix,
    this.colorIcon,
    
  });

  final String text;
  final Function function;
  final double height;
  final double width;
  final TextStyle textStyle;
  final double borderRadius;
  final Color color;
  final IconData? iconLeading;
  final IconData? iconSuffix;
  final Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(padding0),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: Row(
          children: [
            iconLeading != null
                ? Expanded(
                    flex: 1,
                    child: Icon(
                      iconLeading,
                      size: 40,
                      color: colorIcon,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              flex: 4,
              child: Text(
                text,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            iconSuffix != null
                ? Expanded(
                    flex: 1,
                    child: Icon(
                      iconSuffix,
                      size: 40,
                      color: colorIcon,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
