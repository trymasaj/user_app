import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/state_widgets.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/presentation/pages/update_address_screen.dart';
import 'package:masaj/features/address/presentation/widgets/address_tile.dart';

class AddressPage extends StatelessWidget {
  static const routeName = '/address';
  const AddressPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = context.read<MyAddressesCubit>();
    return Scaffold(
        appBar: CustomAppBar(
          actions: [
            TextButton(
                onPressed: () async {
                  final result = await NavigatorHelper.of(context).pushNamed(
                    AddAddressScreen.routeName,
                  ) as Address?;
                  if (result != null) {
                    controller.add(result);
                  }
                },
                child: const SubtitleText(
                  text: 'lbl_add',
                  color: AppColors.PRIMARY_COLOR,
                ))
          ],
          title: 'lbl_addresses'.tr(),
        ),
        body: BlocBuilder<MyAddressesCubit, MyAddressesState>(
          builder: (context, state) {
            return LoadStateHandler(
              customState: state.addresses,
              onTapRetry: controller.getAddresses,
              onData: (data) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: Color(0xffE7E7E7),
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final address = data[index];
                    return AddressTile(
                      onDeleted: () {
                        controller.deleteAddress(index);
                      },
                      address: address,
                      onTap: () async {
                        final result = await NavigatorHelper.of(context)
                            .pushNamed(EditAddressScreen.routeName,
                                arguments: EditAddressArguments(
                                    oldAddress: address)) as Address?;
                        if (result != null) {
                          controller.update(index, result);
                        }
                      },
                    );
                  },
                ),
              ),
            );
          },
        ));
  }
}
