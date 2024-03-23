import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.child,  this.height,this.padding});
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding:padding?? EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Container(
                  height: 5.h,
                  width: 42.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffBDBDBD),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child
            ]));
  }
}
