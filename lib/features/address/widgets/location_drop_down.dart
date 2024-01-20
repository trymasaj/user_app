import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

/*
class LocationDropDown extends StatelessWidget {
  const LocationDropDown({Key? key}) : super(key: key);
final List
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      isExpanded: true,
      decoration: InputDecoration(

          contentPadding: EdgeInsets.symmetric(
              horizontal: 18.w, vertical: 18.h),
          hintText: "lbl_country".tr(),
          hintStyle:
          CustomTextStyles.bodyMediumBluegray40001_1,
          filled: true,
          fillColor: appTheme.gray5001,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.w),
          )),
      // value: state.selectedCountry.toNullable()?.id,
      items: data
          .map((e) => DropdownMenuItem<int>(
          value: e.id,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (e.flagIcon != null)
                CachedNetworkImage(
                    imageUrl: e.flagIcon!,
                    height: 20.h,
                    fit: BoxFit.cover,
                    width: 20.w),
              SizedBox(width: 3),
              Text(
                e.nameEn!,
                style: CustomTextStyles.bodyMediumOnErrorContainer,
              ),
              Spacer(),

              // SizedBox(width: 20,),

              Text(
                e.code ?? '',
                style: CustomTextStyles
                    .bodyMediumOnErrorContainer,
              ),
*/
/*
                                      Spacer(),
*//*

            ],
          )))
          .toList(),
      onChanged: (value) {},
    );
  }
}
*/
