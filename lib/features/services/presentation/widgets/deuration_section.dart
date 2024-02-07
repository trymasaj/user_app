import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/domain/enums/focus_area_enum.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateful/full_screen_video.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_chip.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/focus_area/presentation/pages/focus_area_page.dart';
import 'package:masaj/features/services/application/service_details_cubit/service_details_cubit.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/gen/assets.gen.dart';
import 'package:video_player/video_player.dart';

class DurationsSection extends StatelessWidget {
  const DurationsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              // title then the description
              const Row(
                children: [
                  CustomText(
                    text: 'durations',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),

              SizedBox(
                height: 90.h,
                child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.service?.serviceDurations!.length ?? 0,
                  itemBuilder: (context, index) {
                    final duration = state.service?.serviceDurations![index];
                    return Container(
                      margin: EdgeInsets.only(right: 8.w),
                      child: DurationContainer(
                        duration: duration!,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        );
      },
    );
  }
}

class DurationContainer extends StatelessWidget {
  const DurationContainer({
    super.key,
    required this.duration,
  });
  final ServiceDurationModel duration;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppContainerWithGradinatBorder(
          width: 103.w,
          height: 80.h,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWithGradiant(
                text: duration.formattedString,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              TextWithGradiant(
                text: duration.unit,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              TextWithGradiant(
                text: '(${duration.price} KWD)',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )
            ],
          ),
        ),
        if (duration.isPromoted)
          Positioned(
            top: -16.h,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 33.w,
                ),
                width: 10.w,
                // graidnt CCA3B7 and EDA674
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFCCA3B7),
                      Color(0xFFEDA674),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                alignment: Alignment.center,
                child: const CustomText(
                  text: 'popular',
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
      ],
    );
  }
}
