import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'package:masaj/core/presentation/colors/app_colors.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({
    super.key,
    required this.currentFocusNode,
    required this.nextFocusNode,
    required this.currentController,
    this.margin,
    this.initialValue,
    required this.onInputChanged,
    this.isEnabled = true,
    this.hint,
  });

  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController currentController;
  final EdgeInsetsGeometry? margin;
  final PhoneNumber? initialValue;
  final ValueChanged<PhoneNumber> onInputChanged;
  final bool isEnabled;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final currentLocal = context.locale;
    const textStyle = TextStyle(
      fontSize: 14.0,
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );
    return Container(
      margin: margin,
      child: IntlPhoneField(
        //locale: CurrentUser().languageCode,
        // countries: const ['SA', 'EG', 'AE', 'KW'],

        enabled: isEnabled,
        focusNode: currentFocusNode,
        controller: currentController,
        languageCode: currentLocal.languageCode,
        keyboardType: TextInputType.phone,
        dropdownIconPosition: IconPosition.trailing,

        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        cursorColor: Colors.black,
        style: textStyle,
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
              color: const Color(0xFF8C8C8C),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            fillColor: const Color(0xFFF6F6F6),
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
          fillColor:
              isEnabled ? const Color(0xFFF6F6F6) : AppColors.GREY_NORMAL_COLOR,
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
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),

        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialCountryCode: 'KW',
        flagsButtonMargin: EdgeInsets.only(
          left: currentLocal.languageCode == 'ar' ? 0 : 12,
          right: currentLocal.languageCode == 'ar' ? 12 : 0,
        ),
        onChanged: onInputChanged,
        onSubmitted: (_) => FocusScope.of(context).requestFocus(nextFocusNode),
      ),
    );
  }
}
