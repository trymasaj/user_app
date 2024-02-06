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

class SelectLocationBottomSheet extends StatefulWidget {
  const SelectLocationBottomSheet({Key? key, required this.onSave})
      : super(
          key: key,
        );
  final VoidCallback onSave;

  @override
  State<SelectLocationBottomSheet> createState() =>
      _SelectLocationBottomSheetState();
}

class _SelectLocationBottomSheetState extends State<SelectLocationBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        MediaQuery.of(context).padding.bottom + navbarHeight + 12;
    return CustomBottomSheet(
      height: 450.h,
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
                                      title: address.addressTitle,
                                      isPrimary:
                                          state.selectedAddressIndex == index,
                                      subTitle: address.formattedAddress,
                                      imagePath: ImageConstant
                                          .imgFluentLocation20Regular,
                                      onTap: () {
                                        context
                                            .read<MyAddressesCubit>()
                                            .onSelectAddressAsPrimary(index);
                                      },
                                    ),
                                  )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: MyAddressTile(
                              isRadioButtonVisible: false,
                              onTap: () async {
                                final result =
                                    await NavigatorHelper.of(context).pushNamed(
                                  AddAddressScreen.routeName,
                                ) as Address?;
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
            DefaultButton(
              onPressed: widget.onSave,
              label: "lbl_save".tr(),
            ),
            SizedBox(height: bottomPadding.h),
          ],
        ),
      ),
    );
  }
}
