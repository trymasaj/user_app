import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField(
      {super.key,
      required this.currentFocusNode,
      required this.nextFocusNode,
      required this.currentController,
      this.margin,
      this.initialValue,
      required this.onInputChanged,
      this.isEnabled = true,
      this.hint,
      this.autovalidateMode = AutovalidateMode.onUserInteraction});

  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController currentController;
  final EdgeInsetsGeometry? margin;
  final PhoneNumber? initialValue;
  final ValueChanged<PhoneNumber> onInputChanged;
  final bool isEnabled;
  final String? hint;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final currentLocal = context.locale;
    const textStyle = TextStyle(
      fontSize: 14.0,
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: margin,
        child: Theme(
          data: ThemeData(
            //cursorColor to black
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.black,
            ),
            primaryColor: Colors.black,
          ),
          child: IntlPhoneField(
            enabled: isEnabled,
            style: textStyle,
            focusNode: currentFocusNode,
            controller: currentController,
            languageCode: currentLocal.languageCode,
            keyboardType: TextInputType.phone,
            dropdownIconPosition: IconPosition.trailing,
            dropdownTextStyle: textStyle,
            dropdownIcon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (phoneNumber) {
              return Validator().validatePhoneNumber(phoneNumber?.number ?? '');
            },
            cursorColor: Colors.black,
            pickerDialogStyle: PickerDialogStyle(
              backgroundColor: Colors.white,
              countryNameStyle: textStyle,
              countryCodeStyle: textStyle,
              searchFieldInputDecoration: InputDecoration(
                hintText: 'search'.tr(),
                hintStyle: textStyle.copyWith(
                  fontSize: 14.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
            decoration: InputDecoration(
              fillColor: isEnabled
                  ? const Color(0xFFF6F6F6)
                  : AppColors.GREY_NORMAL_COLOR,
              filled: true,
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              hintText: hint ?? 'phone_number'.tr(),
              hintStyle: textStyle.copyWith(
                color: const Color(0xFF8C8C8C),
              ),
              counterText: '',
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.ERROR_COLOR,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.ERROR_COLOR,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            autovalidateMode: autovalidateMode,
            initialCountryCode: 'KW',
            flagsButtonMargin: const EdgeInsets.only(left: 12),
            onChanged: onInputChanged,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(nextFocusNode),
          ),
        ),
      ),
    );
  }
}
