import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';

class AppTextFormFiled extends StatelessWidget {
  const AppTextFormFiled({
    super.key,
    this.title,
    this.hintText,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.backgroundColor,
    this.textInputAction,
    this.keyboardType,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  final String? title;
  final String? hintText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Color? backgroundColor;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmptyOrNull) ...[
          Text(
            title!,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade200,
              letterSpacing: 1,
            ),
          ),
          Gap(5),
        ],
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText ?? false,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: context.theme.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade400,
              ),
            ),
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
