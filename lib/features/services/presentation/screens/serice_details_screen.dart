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
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/focus_area/presentation/pages/focus_area_page.dart';
import 'package:masaj/features/services/application/service_details_cubit/service_details_cubit.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/presentation/widgets/deuration_section.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key, required this.id});
  final int id;
  static const routeName = '/ServiceDetailsScreen';
  static MaterialPageRoute router(int id) {
    return MaterialPageRoute(
      builder: (_) => builder(
        id,
      ),
    );
  }

  static Widget builder(int id) {
    return BlocProvider(
      create: (context) => Injector().serviceDetailsCubit,
      child: ServiceDetailsScreen(
        id: id,
      ),
    );
  }

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  late final ServiceDetailsCubit _serviceDetailsCubit;
  late TextEditingController focusAreaTextField;
  late ValueNotifier<Map<FocusAreas, bool>?> selectedFocusPoints;
  @override
  void initState() {
    _serviceDetailsCubit = context.read<ServiceDetailsCubit>();
    _serviceDetailsCubit.getServiceDetails(widget.id);
    focusAreaTextField = TextEditingController();
    selectedFocusPoints = ValueNotifier(null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        width: double.infinity,
        height: 92.h,
        //box-shadow: 0px -3px 8px 0px #9DB2D621;
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // rgba(157, 178, 214, 0.13)
              color: const Color(0xff9DB2D6).withOpacity(.13),
              offset: const Offset(0, -3),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const CustomText(
                  text: '60 KWD Nonmember',
                  fontSize: 14,
                  color: Color(0xff1D212C),
                ),
                CustomText(
                  text: '54 KWD member 10% off',
                  fontSize: 12,
                  color: AppColors.FONT_LIGHT.withOpacity(.7),
                ),
                const CustomText(
                  text: 'How to become a member?',
                  color: AppColors.PlaceholderColor,
                  fontSize: 10,
                )
              ],
            ),
            DefaultButton(
              label: 'continue',
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: state.service == null
                  ? const CustomLoading(
                      loadingStyle: LoadingStyle.ShimmerGrid,
                    )
                  : Column(
                      children: [
                        BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
                          builder: (context, state) {
                            return ServiceImagesViewWidget(
                              images: state.service?.images ?? [],
                            );
                          },
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              // title then the description
                              Row(
                                children: [
                                  CustomText(
                                    text: state.service?.title ?? '',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: state.service?.description ?? '',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.FONT_LIGHT,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              // Benefits
                              const Row(
                                children: [
                                  CustomText(
                                    text: 'benefits',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              // lst of benefits
                              for (ServiceBenefitModel benefit
                                  in state.service?.serviceBenefits ?? [])
                                Container(
                                  margin: EdgeInsets.only(bottom: 8.h),
                                  child: Row(
                                    children: [
                                      // dot
                                      Container(
                                        width: 8.w,
                                        height: 8.h,
                                        margin: EdgeInsets.only(right: 8.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.FONT_LIGHT
                                              .withOpacity(.7),
                                        ),
                                      ),
                                      // benefit text
                                      CustomText(
                                        text: benefit.benefit,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.FONT_LIGHT
                                            .withOpacity(.7),
                                      ),
                                    ],
                                  ),
                                ),

                              SizedBox(
                                height: 8.h,
                              ),
                              if (state.service?.videos.isNotEmpty ?? false)
                                Column(
                                  children: [
                                    const Row(
                                      children: [
                                        CustomText(
                                          text: 'Videos',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    SizedBox(
                                        height: 140.h,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 2,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                                  onTap: () {
                                                    NavigatorHelper.of(context)
                                                        .push(
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            FullScreenVideoPlayer(
                                                          url: state.service
                                                                      ?.videos[
                                                                  index] ??
                                                              '',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 160.h,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .8,
                                                        margin: EdgeInsets.only(
                                                            right: 8.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      const Positioned(
                                                        top: 0,
                                                        left: 0,
                                                        right: 0,
                                                        bottom: 0,
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.play_arrow,
                                                          color: Colors.white,
                                                          size: 40,
                                                        )),
                                                      )
                                                    ],
                                                  ),
                                                ))),
                                    SizedBox(
                                      height: 18.h,
                                    )
                                  ],
                                ),
                              // divider
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 5.h,
                          color: const Color(0xffF6F6F6),
                        ),
                        // focus area section
                        if (state.service!.allowFocusAreas == true)
                          Column(
                            children: [
                              FocusAreaSection(
                                  selectedFocusPoints: selectedFocusPoints,
                                  controller: focusAreaTextField),
                              Container(
                                width: double.infinity,
                                height: 5.h,
                                color: const Color(0xffF6F6F6),
                              ),
                            ],
                          ),
                        // durations section
                        if (state.service!.serviceDurations!.isNotEmpty)
                          Column(
                            children: [
                              const DurationsSection(),
                              Container(
                                width: double.infinity,
                                height: 5.h,
                                color: const Color(0xffF6F6F6),
                              ),
                            ],
                          ),
                        // addons section

                        if (state.service!.serviceAddons!.isNotEmpty)
                          Column(
                            children: [
                              AddonsSection(
                                addons: state.service!.serviceAddons!,
                              ),
                              Container(
                                width: double.infinity,
                                height: 5.h,
                                color: const Color(0xffF6F6F6),
                              )
                            ],
                          ),
                        // total section
                        const TotalSection(),

                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

// TotalSection

class TotalSection extends StatelessWidget {
  const TotalSection({
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
                    text: 'total_duration_service',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              ...List.generate(state.service?.serviceDurations!.length ?? 0,
                  (index) {
                final duration = state.service?.serviceDurations![index];
                return Row(
                  children: [
                    CustomText(
                      text: state.service!.title ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.FONT_LIGHT.withOpacity(.7),
                    ),
                    const Spacer(),
                    CustomText(
                      text: '${duration!.formattedString} ${duration.unit}',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.PlaceholderColor,
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 12.h,
              ),
              // total price
              Container(
                height: 1,
                color: const Color(0xffD9D9D9),
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  const CustomText(
                    text: 'total',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  CustomText(
                    text: '60 KWD',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.FONT_LIGHT.withOpacity(.7),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

// full screen video player

class AddonsSection extends StatelessWidget {
  const AddonsSection({
    super.key,
    required this.addons,
  });
  final List<ServiceAddonModel> addons;
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
                    text: 'add_on_s',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              ...addons.map((addon) => Row(
                    children: [
                      // dot

                      // benefit text
                      CustomText(
                        text: addon.title,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.FONT_LIGHT.withOpacity(.7),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          CustomText(
                            text: '(${addon.price} KWD)',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.PlaceholderColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          // checkbox
                          Checkbox(
                              // when the value is false the fill color is white

                              fillColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              value: false,
                              onChanged: (value) {}),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 18.h,
              ),
            ],
          ),
        );
      },
    );
  }
}

//DurationsSection

class FocusAreaSection extends StatefulWidget {
  const FocusAreaSection({
    super.key,
    required this.controller,
    required this.selectedFocusPoints,
  });
  final TextEditingController controller;
  final ValueNotifier<Map<FocusAreas, bool>?> selectedFocusPoints;

  @override
  State<FocusAreaSection> createState() => _FocusAreaSectionState();
}

class _FocusAreaSectionState extends State<FocusAreaSection> {
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
                    text: 'focus_area',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              const Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: 'focus_area_msg',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.FONT_LIGHT,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              // Any focus area today?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'any_focus_area_today',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Map<FocusAreas, bool>? selectedFocusPoints =
                          await NavigatorHelper.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => FocusAreaPage(
                                  selectedFocusPoints:
                                      widget.selectedFocusPoints.value,
                                )),
                      );
                      if (selectedFocusPoints != null) {
                        widget.selectedFocusPoints.value = selectedFocusPoints;
                        widget.controller.text = selectedFocusPoints.keys
                            .where((element) => selectedFocusPoints[element]!)
                            .map((e) => e.name)
                            .join(', ');
                      }
                    },
                    child: const TextWithGradiant(
                        fontWeight: FontWeight.w500,
                        text: 'select_area',
                        fontSize: 14),
                  )
                ],
              ),

              SizedBox(
                height: 8.h,
              ),
              // text field
              DefaultTextFormField(
                currentController: widget.controller,
                readOnly: true,
                currentFocusNode: null,
                hint: 'select_focus_area',
              ),
              SizedBox(
                height: 18.h,
              ),
            ],
          ),
        );
      },
    );
  }
}

// video player widget

class ServiceImagesViewWidget extends StatefulWidget {
  const ServiceImagesViewWidget({
    super.key,
    required this.images,
  });
  final List<String> images;
  @override
  State<ServiceImagesViewWidget> createState() =>
      _ServiceImagesViewWidgetState();
}

class _ServiceImagesViewWidgetState extends State<ServiceImagesViewWidget> {
  late final CarouselController _carouselController;
  @override
  void initState() {
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentIndex = 0;
  bool isPreviousArrowActive = false;
  bool isNextArrowActive = false;
  void toggleArrows(int index) {
    isNextArrowActive = index < widget.images.length - 1;
    isPreviousArrowActive = index > 0;
  }

  // buildDotsIndiactor
  Widget buildDotsIndiactor(BuildContext context) {
    return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.images.length; i++)
              Container(
                width: 8.w,
                height: 8.h,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex != i
                      ? const Color(0xff181b28b2)
                      : const Color(0xff181b2836).withOpacity(.21),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Transform.flip(
      flipX: context.locale.countryCode == 'ar',
      child: SvgPicture.asset(
        'assets/images/back_btn.svg',
        color: const Color(0xff1D212C),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 262.h,
            autoPlay: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            // make to take the full width
            viewportFraction: 1,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
          items: [
            for (var image in widget.images)
              CustomCachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
          ],
        )
        // build arrow buttons to navigate between images
        ,

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white.withOpacity(.6), Colors.transparent],
              ),
            ),
          ),
        ),

        Positioned(
          width: MediaQuery.of(context).size.width,
          right: 0,
          bottom: (262.h / 3) - 20.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: isPreviousArrowActive
                      ? AppColors.PlaceholderColor
                      : AppColors.FONT_LIGHT,
                  onPressed: () {
                    _carouselController.previousPage();

                    toggleArrows(
                      currentIndex - 1,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: isNextArrowActive
                        ? AppColors.PlaceholderColor
                        : AppColors.FONT_LIGHT,
                  ),
                  onPressed: () {
                    _carouselController.nextPage();
                    toggleArrows(
                      currentIndex + 1,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // build the indicator
        Positioned(
          bottom: 20.h,
          left: 0,
          right: 0,
          child: buildDotsIndiactor(context),
        ),
        // back button
        Positioned(
          bottom: ((262.h / 3) * 2),
          left: context.locale.countryCode != 'ar' ? 0 : null,
          right: context.locale.countryCode != 'ar' ? null : 0,
          child: InkWell(
            onTap: NavigatorHelper.of(context).pop,
            child: Container(
              margin: EdgeInsets.only(
                left: context.locale.countryCode != 'ar' ? 14.w : 0,
                right: context.locale.countryCode == 'ar' ? 14.w : 0,
              ),
              padding: EdgeInsets.all(14.w),
              height: 44.h,
              // white background and circle shape
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,

                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(.1),
                //     blurRadius: 10,
                //     spreadRadius: 5,
                //   )
                // ],
              ),
              child: _buildBackButton(context),
            ),
          ),
        ),
      ],
    );
  }
}
