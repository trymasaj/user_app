import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/dialogs/image_picker_bottom_sheet.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/search_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/home/presentation/pages/search_screen.dart';
import 'package:masaj/features/home/presentation/widget/search_field.dart';
import 'package:masaj/features/services/application/service_cubit/service_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_query_model.dart';
import 'package:masaj/features/services/presentation/screens/search_services.dart';
import 'package:masaj/features/services/presentation/screens/serice_details_screen.dart';
import 'package:masaj/features/services/presentation/widgets/gradiant_slider.dart';
import 'package:masaj/gen/assets.gen.dart';

class FilterWidgetSheet extends StatefulWidget {
  const FilterWidgetSheet({super.key, required this.serviceCubit});
  final ServiceCubit serviceCubit;
  @override
  State<FilterWidgetSheet> createState() => _FilterWidgetSheetState();
}

class _FilterWidgetSheetState extends State<FilterWidgetSheet> {
  double _starterValue = 0;
  double _endValue = 1000;
  late RangeValues values;
  late TextEditingController _fromController;
  late TextEditingController _toController;
  late FocusNode _fromFocusNode;
  late FocusNode _toFocusNode;
  int divisions = 1000;

  @override
  void initState() {
    _fromController = TextEditingController();
    _toController = TextEditingController();
    _fromFocusNode = FocusNode();
    _toFocusNode = FocusNode();
    double? priceFrom = widget.serviceCubit.state.priceFrom;
    double? priceTo = widget.serviceCubit.state.priceTo;
    setState(() {
      _endValue = widget.serviceCubit.state.maxPrice;
      _starterValue = widget.serviceCubit.state.minPrice;
    });

    values = RangeValues(
      priceFrom ?? _starterValue,
      priceTo ?? _endValue,
    );

    _fromController.text = values.start.toString();
    _toController.text = values.end.toString();

    _fromController.addListener(_starterListener);
    _toController.addListener(_endListener);

    super.initState();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _fromFocusNode.dispose();
    _toFocusNode.dispose();
    super.dispose();
  }

  // _fromController listener
  // _toController listener
  void _starterListener() {
    if (_fromController.text.isNotEmpty) {
      final value = num.parse(_fromController.text).toDouble();

      if (value >= _starterValue && value <= _endValue) {
        setState(() {
          values = RangeValues(value, values.end);
        });
      }
    }
  }
  // from formatter

  void _endListener() {
    if (_toController.text.isNotEmpty) {
      final value = num.parse(_toController.text).toDouble();

      if (value > _endValue) {
        setState(() {
          _endValue = value;
          values = RangeValues(values.start, _endValue);
          divisions = _endValue.toInt();
        });
        return;
      }

      // 'values.start <= values.end'
      if (value >= _starterValue &&
          value <= _endValue &&
          values.start <= value) {
        setState(() {
          values = RangeValues(values.start, value);
        });
      }
    }
  }
  // onchange listener

  void onChangeSlider(RangeValues newValues) {
    _fromController.text = newValues.start.toString();
    _toController.text = newValues.end.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.serviceCubit,
      child: Builder(builder: (context) {
        return Container(
          height: 680.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                // botton in THE bottom
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'filter'.tr(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1D212C),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              widget.serviceCubit.getServices(
                                clearPrice: true,
                                refresh: true,
                              );

                              Navigator.pop(context);
                            },
                            child: Text(
                              'clear'.tr(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1D212C),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      // divider #D9D9D9
                      Container(
                        height: 1,
                        color: const Color(0xffD9D9D9),
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        children: [
                          Text(
                            'price'.tr(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1D212C),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      // from and to text fields
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              autofocus: false,
                              inputFormatters: [
                                // filtering the input to not allow inpuut more than the _endValue
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'),
                                ),
                              ],
                              focusNode: _fromFocusNode,
                              controller: _fromController,
                              textInputType: TextInputType.number,
                              hintText: 'from'.tr(),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: CustomTextFormField(
                              autofocus: false,
                              focusNode: _toFocusNode,
                              controller: _toController,
                              textInputType: TextInputType.number,
                              hintText: 'to'.tr(),
                            ),
                          ),
                        ],
                      ),
                      // price range
                      SizedBox(height: 20.h),
                      // slider range
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 5.0,
                          overlayShape:
                              const RoundSliderOverlayShape(overlayRadius: 0.0),
                          // Define the gradient for the track
                          trackShape: const GradientRectSliderTrackShape(
                              gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green],
                          )),
                          // Define the gradient for the thumb
                          thumbShape: GradientRoundSliderThumbShape(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.blue,
                                Color.fromARGB(255, 10, 51, 12)
                              ],
                            ),
                            enabledThumbRadius: 12.0,
                          ),
                        ),
                        child: RangeSlider(
                          divisions: divisions,
                          values: values,
                          min: _starterValue,
                          max: _endValue,
                          onChanged: onChangeSlider,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: DefaultButton(
                      onPressed: () {
                        Navigator.pop(context, values);

                        widget.serviceCubit.getServices(
                            refresh: true,
                            priceFrom: values.start,
                            maxPrice: _endValue,
                            minPrice: _starterValue,
                            priceTo: values.end);
                      },
                      label: 'apply'.tr()),
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}
