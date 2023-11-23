import 'package:allotravaux/resources/style.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Function()? onPressed;
  final Size? buttonSize;
  final bool? isSelected;
  final FontWeight? fontweight;

  const ButtonComponent(
      {super.key,
      this.icon,
      this.text,
      this.onPressed,
      this.fontweight,
      this.buttonSize,
      this.isSelected});

  @override
  Widget build(BuildContext context) {
    Size? size;
    buttonSize == null ? size = const Size(110, 40) : size = buttonSize;
    Color? color;
    isSelected ?? false
        ? color = primaryDarkButton
        : color = primaryLightButton;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const StadiumBorder(),
          minimumSize: size),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.black,
              size: 20,
            ),
          Text(
            text!,
            style: TextStyle(
                color: Colors.black,
                fontSize: isSelected ?? false ? 16 : 14,
                fontWeight: fontweight ??
                    (isSelected ?? false ? FontWeight.w600 : FontWeight.w400)),
          )
        ],
      ),
    );
  }
}
