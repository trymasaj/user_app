import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/extenstions/context_extensions.dart';
import 'package:masaj/features/address/application/blocs/map_location_picker_cubit/map_location_picker_cubit.dart';
import 'package:masaj/features/address/presentation/overlay/location_bottom_sheet.dart';
import 'package:masaj/features/address/presentation/widgets/location_pick_text_field.dart';

class MapLocationPickerArguments {
  final LatLng? initialLatlng;

  MapLocationPickerArguments({required this.initialLatlng});
}

class MapLocationPickerResult {
  final LatLng latLng;
  final String address;

  MapLocationPickerResult({required this.latLng, required this.address});
}

class MapLocationPicker extends StatefulWidget {
  final MapLocationPickerArguments arguments;
  const MapLocationPicker({super.key, required this.arguments});
  static const routeName = '/address-location-picker';

  static Widget builder(MapLocationPickerArguments arguments) {
    return BlocProvider<MapLocationPickerCubit>(
      create: (context) =>
          getIt(param1: arguments)..navigateToCurrentLocation(),
      child: MapLocationPicker(
        arguments: arguments,
      ),
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
            CameraUpdate.newLatLngZoom(state.selectedLatlng.toNullable()!, 15));
        focusNode.unfocus();
      },
      listenWhen: (previous, current) {
        return previous.selectedLatlng != current.selectedLatlng;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                    initialCameraPosition: CameraPosition(
                        zoom: 13,
                        target:
                            widget.arguments.initialLatlng ?? LatLng(0, 0))),
                Center(
                    child: SvgPicture.asset(
                  'assets/images/img_fluent_location_48_filled.svg',
                  width: 50.w,
                  height: 50.h,
                )),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            BackButton(),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: LocationPickTextField(
                                  focusNode: focusNode,
                                  onSelected: controller.onSelected,
                                  onSearch: controller.onSearch),
                            ),
                            SizedBox(
                              width: 24.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: BlocSelector<MapLocationPickerCubit,
                        MapLocationPickerState, String>(
                      selector: (state) {
                        return state.address.fullAddress;
                      },
                      builder: (context, address) {
                        return LocationBottomSheet(
                          address: address,
                          onTapContinue: () async {
                            final googleMapController =
                                await this.googleMapController.future;
                            final latLng = await googleMapController
                                .getLatLng(context.getScreenCoordinate());
                            Navigator.of(context).pop(MapLocationPickerResult(
                                address: address, latLng: latLng));
                          },
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
