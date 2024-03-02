import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key,
      required this.controller,
      this.iconColor = const Color(0xff000000),
      this.validator,
      required this.hint});

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String hint;
  final Color iconColor;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.FONT_COLOR,
      ),
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 17.h),
        prefixIcon: Container(
          margin: EdgeInsets.fromLTRB(18.w, 18.h, 8.w, 18.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgLocation,
            height: 20.adaptSize,
            width: 20.adaptSize,
            color: widget.iconColor,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 56.h,
        ),
        hintText: widget.hint.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              isShowPassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              size: 15,
              color: appTheme.blueGray40001,
            ),
            onPressed: () {
              setState(() {
                isShowPassword = !isShowPassword;
              });
            },
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 56.h,
        ),
      ),
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty || value.length < 6) {
              return 'err_msg_please_enter_valid_password'.tr();
            }
            // if (value == null || (!isValidPassword(value, isRequired: true))) {
            //   return 'err_msg_please_enter_valid_password'.tr();
            // }
            return null;
          },
      obscureText: !isShowPassword,
    );
  }
}
