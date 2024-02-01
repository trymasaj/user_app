import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/features/address/domain/entities/address.dart';

class AddressTile extends StatelessWidget {
  const AddressTile(
      {Key? key,
      required this.address,
      required this.onTap,
      required this.onDeleted})
      : super(key: key);
  final Address address;
  final VoidCallback onTap;
  final VoidCallback onDeleted;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
       return onDeleted();
      },
      key: ValueKey<int>(address.id),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 80.h,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 12.w),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffF9F8F6)),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          ImageConstant.imgFluentLocation20Regular,
                          width: 22.w,
                          height: 22.h,
                          colorFilter:
                              ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                text: address.googleMapAddress,
                                fontSize: 16.fSize,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff181B28),
                              ),
                              SizedBox(width: 5.w),
                              if (address.isPrimary)
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xffF9F8F6)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.w, vertical: 2.h),
                                      child: CustomText(
                                        text: 'Primary',
                                        color: Color(0xffEDA674),
                                        fontSize: 12.fSize,
                                      ),
                                    )),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: CustomText(
                              text: address.formattedAddress,
                              fontSize: 14.fSize,
                              color: Color(0xff5D5F69),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
