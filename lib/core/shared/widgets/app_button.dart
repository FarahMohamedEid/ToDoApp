import 'package:flutter/material.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.buttonColor,
    this.textColor,
  });

  final VoidCallback onPressed;
  final String title;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: onPressed,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: buttonColor ?? ColorsManager.primary,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: textColor ?? ColorsManager.white,
          ),
        ),
      ),
    );
  }
}
