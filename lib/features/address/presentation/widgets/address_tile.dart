import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/features/address/domain/entities/address.dart';

class Dismissible extends StatelessWidget {
  const Dismissible({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

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
    return address.isPrimary
        ? buildTile()
        : Slidable(
            key: ValueKey(address.id),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(
                onDismissed: onDeleted,
              ),
              children: [
                SlidableAction(
                  onPressed: (context) => onDeleted(),
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: AppText.delete,
                ),
              ],
            ),
            child: buildTile(),
          );
  }

  Widget buildTile() {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
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
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffF9F8F6)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        ImageConstant.imgFluentLocation20Regular,
                        width: 22.w,
                        height: 22.h,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomText(
                                text: address.addressTitle.isEmpty
                                    ? address.formattedAddress
                                    : address.addressTitle,
                                fontSize: 15.fSize,
                                maxLines: 2,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff181B28),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            if (address.isPrimary)
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xffF9F8F6)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0.w, vertical: 2.h),
                                    child: CustomText(
                                      text: AppText.lbl_primary_address,
                                      color: const Color(0xffEDA674),
                                      fontSize: 12.fSize,
                                    ),
                                  )),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        if (address.addressTitle != '')
                          Expanded(
                            child: CustomText(
                              text: address.formattedAddress,
                              fontSize: 14.fSize,
                              color: const Color(0xff5D5F69),
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
    );
  }
}
