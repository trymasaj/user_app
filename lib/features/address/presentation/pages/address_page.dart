import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/state_widgets.dart';
import 'package:masaj/features/address/application/blocs/add_new_address_bloc/update_address_bloc.dart';
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
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () async {
                 final result =  await NavigatorHelper.of(context).pushNamed(
                      UpdateAddressScreen.routeName,
                      arguments: UpdateAddressArguments(
                          updater: getIt<CreateAddressUpdater>()))as Address?;
                  if(result != null){
                    controller.add(result);
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 14.fSize),
                ))
          ],
          title: Text('lbl_addresses'.tr()),
        ),
        body: BlocBuilder<MyAddressesCubit, MyAddressesState>(
          builder: (context, state) {
            return LoadStateHandler(
              customState: state.addresses,
              onTapRetry: controller.getAddresses,
              onData: (data) => ListView.separated(
                separatorBuilder: (context, index) => Divider(
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
                     final result = await NavigatorHelper.of(context).pushNamed(
                          UpdateAddressScreen.routeName,
                          arguments: UpdateAddressArguments(
                              updater: getIt<UpdateAddressUpdater>(
                                  param1: address))) as Address?;
                      if(result != null){
                        controller.update(index, result);
                      }
                    },
                  );
                },
              ),
            );
          },
        ));
  }
}