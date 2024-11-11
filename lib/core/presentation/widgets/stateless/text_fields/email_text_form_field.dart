import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/main_text_form_field.dart';

class EmailTextFormField extends MainTextFormField {
  EmailTextFormField({
    super.key,
    required super.currentFocusNode,
    super.nextFocusNode,
    required super.currentController,
    super.margin = null,
    super.enabled,
    required super.prefixIcon,
  }) : super(
            validator: Validator().validateEmail,
            hintText: AppText.email_address,
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r' ')),
              LengthLimitingTextInputFormatter(50),
            ]);
}
