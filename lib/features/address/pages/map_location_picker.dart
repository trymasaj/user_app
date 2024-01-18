import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/extenstions/context_extensions.dart';
import 'package:masaj/features/address/bloc/map_location_picker_cubit/map_location_picker_cubit.dart';
import 'package:masaj/features/address/overlay/location_bottom_sheet.dart';
import 'package:masaj/features/address/widgets/location_pick_text_field.dart';

class MapLocationPicker extends StatefulWidget {
  MapLocationPicker({Key? key}) : super(key: key);
  static const routeName = '/address-location-picker';

  static Widget builder(BuildContext context) {
    return BlocProvider<MapLocationPickerCubit>(
      create: (context) => Injector().mapLocationBloc,
      child: MapLocationPicker(),
    );
  }

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  final googleMapController = Completer<GoogleMapController>();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MapLocationPickerCubit>();

    return BlocListener<MapLocationPickerCubit, MapLocationPickerState>(
      listener: (_, state) async {
        final googleMapController = await this.googleMapController.future;
        googleMapController.animateCamera(
            CameraUpdate.newLatLngZoom(state.latLng.toNullable()!, 15));
        focusNode.unfocus();
      },
      listenWhen: (previous, current) {
        return previous.latLng != current.latLng;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                  onMapCreated: (controller) {
                    googleMapController.complete(controller);
                  },
                  onCameraIdle: () async {
                    final googleMapController =
                        await this.googleMapController.future;
                    final latLng = await googleMapController
                        .getLatLng(context.getScreenCoordinate());
                    await controller.onCameraIdle(latLng);
                  },
                  myLocationEnabled: true,
                  initialCameraPosition:
                      CameraPosition(target: LatLng(30, 30))),
              Align(
                  alignment: Alignment.topCenter,
                  child: LocationPickTextField(
                      focusNode: focusNode,
                      onSelected: controller.onSelected,
                      onSearch: controller.onSearch)),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocSelector<MapLocationPickerCubit,
                      MapLocationPickerState, String>(
                    selector: (state) {
                      return state.address;
                    },
                    builder: (context, address) {
                      return LocationBottomSheet(
                        address: address,
                        onTapContinue: () {},
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
