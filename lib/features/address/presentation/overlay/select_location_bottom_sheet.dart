import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/custom_bottom_sheet.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/state_widgets.dart';
import 'package:masaj/features/address/application/blocs/add_new_address_bloc/update_address_bloc.dart';
import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/presentation/pages/update_address_screen.dart';
import 'package:masaj/features/address/presentation/widgets/my_address_tile.dart';
import 'package:collection/collection.dart';

// ignore_for_file: must_be_immutable
class SelectLocationBottomSheet extends StatelessWidget {
  const SelectLocationBottomSheet({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return const SelectLocationBottomSheet();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      height: 400.h,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 23.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "lbl_location".tr(),
                style: CustomTextStyles.titleMediumGray90003,
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: BlocBuilder<MyAddressesCubit, MyAddressesState>(
                builder: (context, state) {
                  return LoadStateHandler(
                    onTapRetry: () {},
                    customState: state.addresses,
                    onData: (data) {
                      return Expanded(
                          child: ListView(
                        children: [
                          ...state.addressesData
                              .mapIndexed((index, address) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                    child: MyAddressTile(
                                      title: address.type,
                                      isPrimary: address.isPrimary,
                                      subTitle: address.formattedAddress,
                                      imagePath: ImageConstant
                                          .imgFluentLocation20Regular,
                                      onTap: () {
                                        context
                                            .read<MyAddressesCubit>()
                                            .setAsPrimary(index);
                                      },
                                    ),
                                  )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: MyAddressTile(
                              isRadioButtonVisible: false,
                              onTap: () async {
                                final result = await NavigatorHelper.of(context)
                                    .pushNamed(UpdateAddressScreen.routeName,
                                        arguments: UpdateAddressArguments(
                                          updater:
                                              getIt<CreateAddressUpdater>(),
                                        )) as Address?;
                                if (result != null) {
                                  context.read<MyAddressesCubit>().add(result);
                                }
                              },
                              title: 'lbl_new_address'.tr(),
                              isPrimary: false,
                              subTitle: 'Add new Address',
                              imagePath: ImageConstant.imgPlus,
                            ),
                          ),
                        ],
                      ));
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 15.h),
/*
            CustomElevatedButton(
              text: "lbl_save".tr(),
              buttonStyle: CustomButtonStyles.none,
              decoration: CustomButtonStyles
                  .gradientSecondaryContainerToPrimaryDecoration,
            ),
*/
            DefaultButton(
              onPressed: () {
                NavigatorHelper.of(context).pop();
              },
              label: "lbl_save".tr(),
            ),
            SizedBox(height: 22.h),
          ],
        ),
      ),
    );
  }
}
