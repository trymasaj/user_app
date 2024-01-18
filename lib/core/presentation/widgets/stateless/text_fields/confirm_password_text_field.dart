import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';

class ConfirmPasswordTextFormField extends StatefulWidget {
  const ConfirmPasswordTextFormField({
    super.key,
    required this.currentFocusNode,
    this.nextFocusNode,
    required this.currentController,
    required this.passwordController,
    this.margin,
    this.hint,
    this.validator,
  });

  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController currentController;
  final TextEditingController passwordController;
  final EdgeInsetsGeometry? margin;
  final String? hint;
  final String? Function(String?)? validator;

  @override
  _ConfirmPasswordTextFormFieldState createState() =>
      _ConfirmPasswordTextFormFieldState();
}

class _ConfirmPasswordTextFormFieldState
    extends State<ConfirmPasswordTextFormField> {
  bool _obscureTextLogin = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: DefaultTextFormField(
        currentController: widget.currentController,
        currentFocusNode: widget.currentFocusNode,
        nextFocusNode: widget.nextFocusNode,
        margin: widget.margin,
        hint: widget.hint ?? 'password'.tr(),
        obscureText: _obscureTextLogin,
        maxLines: 1,
        suffixIcon: GestureDetector(
          onTap: _toggleLogin,
          child: Icon(
            _obscureTextLogin
                ? FontAwesomeIcons.eyeSlash
                : FontAwesomeIcons.eye,
            size: 18.0,
            color: Colors.grey,
          ),
        ),
        validator: (confPassword) => Validator()
            .validateConfPassword(widget.passwordController.text, confPassword),
      ),
    );
  }

  void _toggleLogin() => setState(() => _obscureTextLogin = !_obscureTextLogin);
}
