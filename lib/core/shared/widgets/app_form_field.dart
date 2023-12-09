import 'package:flutter/material.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';
import 'package:todo_app/core/shared/fonts/font_manager.dart';

class AppFormField extends StatefulWidget {
  const AppFormField({
    super.key,
    this.hint,
    this.controller,
    this.type = TextInputType.text,
    this.error,
    this.readOnly = false,
    this.onChange,
    this.onTab,
    this.label,
    this.prefixIcon,
    this.maxLines,
    this.textInputAction,
    this.autoFocus,
  });

  final String? hint;
  final TextEditingController? controller;
  final TextInputType type;
  final String? error;
  final bool readOnly;
  final Function(String)? onChange;
  final Function()? onTab;
  final String? label;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final bool? autoFocus;




  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChange,
      maxLines: widget.maxLines ?? 1,
      autofocus: widget.autoFocus ?? false,
      strutStyle: const StrutStyle(
        height: 1,
      ),
      onTap: widget.onTab,
      textInputAction: widget.textInputAction,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: ColorsManager.black,
        fontWeight: FontWeightManager.medium,
      ),
      enableInteractiveSelection: true,
      canRequestFocus: true,
      cursorColor: ColorsManager.primary,
      readOnly: widget.readOnly,
      validator: (value) {
        if (value!.isEmpty) {
          return widget.error;
        }
        return null;
      },
      keyboardType: widget.type,
      decoration: InputDecoration(
        fillColor: ColorsManager.white,
        filled: true,
        hintText: widget.hint,
        label: widget.label != null
            ? Text(
          widget.label!,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ColorsManager.black,
          ),
        )
            : null,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: ColorsManager.darkGray,
          fontWeight: FontWeightManager.semiBold,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.primary,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.darkGray,
            width: 1.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.darkGray,
            width: 1.0,
          ),
          // borderSide: BorderSide.none,
        ),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: ColorsManager.darkGray,
      ),
    );
  }
}
