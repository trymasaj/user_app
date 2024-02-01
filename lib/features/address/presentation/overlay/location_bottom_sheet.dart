import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/overlay/custom_bottom_sheet.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet(
      {super.key, required this.address, required this.onTapContinue});
  final String address;
  final VoidCallback onTapContinue;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text('selected_address'.tr()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SvgPicture.asset(
                'assets/images/pin.svg',
                height: 20.h,
                width: 20.w,
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                address,
                style: TextStyle(
                  color: const Color(0xff1D212C),
                  fontSize: 18.fSize,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomElevatedButton(
          onPressed: onTapContinue,
          text: 'lbl_continue'.tr(),
          buttonStyle: CustomButtonStyles.none,
          decoration:
              CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    ));
  }
}
