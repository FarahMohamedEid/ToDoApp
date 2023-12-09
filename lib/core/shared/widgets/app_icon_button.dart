import 'package:flutter/material.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key,
  required this.iconPath,
  required this.onPressed,
  });

  final IconData iconPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 26,
      icon: Icon(
        iconPath,
        color: ColorsManager.white,
      ),
    );
  }
}
