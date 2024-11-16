
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';

class CouponWidget extends StatefulWidget {
  const CouponWidget({
    super.key,
    required FocusNode couponFocusNode,
    required TextEditingController couponEditingController,
  })  : _couponFocusNode = couponFocusNode,
        _couponEditingController = couponEditingController;

  final FocusNode _couponFocusNode;
  final TextEditingController _couponEditingController;

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          return DefaultTextFormField(
            currentFocusNode: widget._couponFocusNode,
            currentController: widget._couponEditingController,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                'assets/images/dicount_icon.svg',
              ),
            ),
            hint: AppText.lbl_coupon_code,
            suffixIcon: SizedBox(
              width: 80,
              child: DefaultButton(
                borderRadius: BorderRadius.circular(8),
                onPressed: () async {
                  final cubit = context.read<BookingCubit>();
                  if (formKey.currentState!.validate()) {
                    if (state.isCouponApplied) {
                      await cubit.deleteBookingVoucher(
                          widget._couponEditingController.text);
                    } else {
                      await cubit.addBookingVoucher(
                          widget._couponEditingController.text);
                    }
                  }
                },
                label: state.isCouponApplied ? AppText.cancel : AppText.lbl_apply,
              ),
            ),
          );
        },
      ),
    );
  }
}
