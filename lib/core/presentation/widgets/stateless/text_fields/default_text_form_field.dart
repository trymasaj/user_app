import 'package:flutter/material.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/main_text_form_field.dart';

class DefaultTextFormField extends MainTextFormField {
  DefaultTextFormField(
      {super.key,
      required super.currentFocusNode,
      super.nextFocusNode,
      required super.currentController,
      super.inputFormatters,
      required final String hint,
      TextInputType super.keyboardType = TextInputType.text,
      super.margin = null,
      super.contentPadding,
      super.enabled,
      final bool isRequired = false,
      super.expanded,
      super.maxLines,
      super.obscureText,
      super.suffixIcon,
      final String? Function(String?)? validator,
      super.onChanged,
      super.readOnly,
      super.onTap,
      super.borderColor,
      super.decoration,
      super.prefixIcon,
      super.fillColor})
      : super(
          validator:
              validator ?? (isRequired ? Validator().validateEmptyField : null),
          hintText: hint,
          textCapitalization: TextCapitalization.words,
        );
}
