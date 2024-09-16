import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';

class AppTextFormFiled extends StatelessWidget {
  const AppTextFormFiled._({
    super.key,
    this.title,
    this.hintText,
    this.errorText,
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
    this.isRequireField = false,
    this.onSelectDateTime,
  });

  final String? title;
  final String? hintText;
  final String? errorText;
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
  final bool isRequireField;
  final void Function(DateTime?)? onSelectDateTime;

  factory AppTextFormFiled({
    Key? key,
    String? title,
    String? hintText,
    String? errorText,
    FocusNode? focusNode,
    TextEditingController? controller,
    Function(String)? onChanged,
    Color? backgroundColor,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    bool? obscureText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool? isRequireField,
    String? Function(String?)? validator,
  }) {
    return AppTextFormFiled._(
      key: key,
      title: title,
      hintText: hintText,
      errorText: errorText,
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      backgroundColor: backgroundColor,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isRequireField: isRequireField ?? false,
      validator: validator,
    );
  }

  factory AppTextFormFiled.datetime({
    Key? key,
    String? title,
    String? hintText,
    String? errorText,
    FocusNode? focusNode,
    TextEditingController? controller,
    Function(String)? onChanged,
    Color? backgroundColor,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool? isRequireField,
    required void Function(DateTime?) onSelectDateTime,
  }) {
    return AppTextFormFiled._(
      key: key,
      title: title,
      hintText: hintText,
      errorText: errorText,
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      backgroundColor: backgroundColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isRequireField: isRequireField ?? false,
      onSelectDateTime: onSelectDateTime,
    );
  }

  static double height = 45;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmptyOrNull) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: isRequireField,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    "*",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ),
              const Gap(1),
              Text(
                title!,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade200,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          Gap(5),
        ],
        Container(
          height: height,
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
            readOnly: onSelectDateTime != null,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            onTap: onSelectDateTime == null
                ? null
                : () async {
                    DateTime now = DateTime.now();
                    final dateTime = await showDatePicker(
                      context: context,
                      firstDate: now.copyWith(year: now.year - 80),
                      lastDate: now,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
                    onSelectDateTime!.call(dateTime);
                  },
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
        if (errorText.isNotEmptyOrNull)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Text(
              errorText!,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
