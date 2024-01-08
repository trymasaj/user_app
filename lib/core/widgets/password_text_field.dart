import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/validation_functions.dart';
import 'package:masaj/core/widgets/custom_text_form_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {Key? key, required this.controller, this.validator, required this.hint})
      : super(key: key);
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String hint;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isShowPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 17.h),
        filled: false,
        prefixIcon: Container(
          margin: EdgeInsets.fromLTRB(18.w, 18.h, 8.w, 18.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgLocation,
            height: 20.adaptSize,
            width: 20.adaptSize,
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
              isShowPassword ? Icons.visibility : Icons.visibility_off,
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
      validator: (value) {
        if (value == null || (!isValidPassword(value, isRequired: true))) {
          return "err_msg_please_enter_valid_password".tr();
        }
        return null;
      },
      obscureText: isShowPassword,
    );
  }
}
