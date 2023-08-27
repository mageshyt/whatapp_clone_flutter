import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hintText,
      this.readonly,
      this.textAlign,
      this.keyboardType,
      this.prefixText,
      this.onChanged,
      this.onTap})
      : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool? readonly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      readOnly: readonly ?? false,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        prefixText: prefixText,
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(color: Theme.of(context).hintColor),
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors.greenDark,
            width: 2,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors.greenDark,
          ),
        ),
      ),
    );
  }
}
