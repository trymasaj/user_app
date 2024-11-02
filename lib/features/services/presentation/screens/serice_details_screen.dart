import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
// import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/core/domain/enums/focus_area_enum.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateful/full_screen_video.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/default_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/focus_area/presentation/pages/focus_area_page.dart';
import 'package:masaj/features/members/presentaion/pages/select_members.dart';
import 'package:masaj/features/membership/presentaion/pages/memberships_screen.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/services/application/service_details_cubit/service_details_cubit.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/presentation/widgets/deuration_section.dart';

class ServiceDetailsScreenArguments {
  final int id;
  final Therapist? therapist;
  final int? durationId;
  ServiceDetailsScreenArguments({
    required this.id,
    this.therapist,
    this.durationId,
  });
}

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key, required this.arguments});

  final ServiceDetailsScreenArguments arguments;
  static const routeName = '/ServiceDetailsScreen';
  static MaterialPageRoute router<T>(ServiceDetailsScreenArguments arguments) {
    return MaterialPageRoute<T>(
      builder: (_) => builder(
        arguments,
      ),
    );
  }

  static Widget builder(ServiceDetailsScreenArguments arguments) {
    return BlocProvider(
      create: (context) => DI.find<ServiceDetailsCubit>(),
      child: ServiceDetailsScreen(
        arguments: arguments,
      ),
    );
  }

  // get the state
  static ServiceDetailsScreenState of(BuildContext context) {
    return context.findAncestorStateOfType<ServiceDetailsScreenState>()!;
  }

  @override
  State<ServiceDetailsScreen> createState() => ServiceDetailsScreenState();
}

class ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  late final ServiceDetailsCubit _serviceDetailsCubit;
  late TextEditingController focusAreaTextField;
  late ValueNotifier<Map<FocusAreas, bool>?> selectedFocusPoints;
  List<ServiceAddonModel> selectedAddons = [];

  final selectedDurationNotifier = ValueNotifier<ServiceDurationModel?>(null);

  void toggleSelectDuration(ServiceDurationModel duration) {
    if (selectedDurationNotifier.value?.serviceDurationId ==
        duration.serviceDurationId) {
      selectedDurationNotifier.value = null;
    } else {
      selectedDurationNotifier.value = duration;
    }
  }

  void addAddon(ServiceAddonModel addon) {
    setState(() {
      selectedAddons.add(addon);
    });
  }

  void removeAddons(ServiceAddonModel addon) {
    setState(() {
      selectedAddons.remove(addon);
    });
  }

  bool isAddonSelected(ServiceAddonModel addon) {
    return selectedAddons.map((e) => e.addonId).contains(addon.addonId);
  }

  double get totalDuration {
    double total = 0;
    if (selectedDurationNotifier.value != null) {
      total += selectedDurationNotifier.value!.durationInMinutesInt;
    }
    for (var addon in selectedAddons) {
      total += addon.durationInMinutesInt;
    }
    return total;
  }

  double discountPercentage = .1;

  double getPriceAfterDiscount() {
    final discountValue = totalPrice() * discountPercentage;

    return totalPrice() - discountValue;
  }

  double totalPrice() {
    double total = 0;
    if (selectedDurationNotifier.value != null) {
      // check if has discount
      final price = (selectedDurationNotifier.value!.hasDiscount &&
              selectedDurationNotifier.value!.discountedPrice != null)
          ? selectedDurationNotifier.value!.discountedPrice
          : selectedDurationNotifier.value!.price;

      total += price ?? 0;
    }
    for (var addon in selectedAddons) {
      total += addon.price;
    }
    return total;
  }

  void checkFromTherapist() {
    if (widget.arguments.therapist != null) {
      context
          .read<BookingCubit>()
          .setSelectedTherapist(widget.arguments.therapist);
    } else {
      context.read<BookingCubit>().clearTherapist();
    }
  }

  @override
  void initState() {
    _serviceDetailsCubit = context.read<ServiceDetailsCubit>();
    _serviceDetailsCubit.getServiceDetails(widget.arguments.id);
    focusAreaTextField = TextEditingController();
    selectedFocusPoints = ValueNotifier(null);
    checkFromTherapist();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceDetailsCubit, ServiceDetailsState>(
      listenWhen: (previous, current) =>
          previous.service != current.service ||
          previous.service?.serviceDurations !=
              current.service?.serviceDurations,
      listener: (context, state) {
        // after geting the service details if the widget.arguments.durationId is not null then select the duration
        if (widget.arguments.durationId != null) {
          final duration = (state.service?.serviceDurations ?? [])
              .where((element) =>
                  element.serviceDurationId == widget.arguments.durationId)
              .firstOrNull;
          selectedDurationNotifier.value = duration;
        }
      },
      child: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
        builder: (context, state) {
          return Scaffold(
            bottomSheet: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              width: double.infinity,
              height: 100.h,
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
                  ValueListenableBuilder(
                      valueListenable: selectedDurationNotifier,
                      builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: '${AppText.lbl_kwd(args: [
                                    totalPrice().toString()
                                  ])} ${AppText.lbl_nonmember}',
                              fontSize: 14,
                              color: const Color(0xff1D212C),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: AppText.percentage_off(args: [
                                      (discountPercentage * 100).toString()
                                    ]),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.ERROR_COLOR,
                                    )),
                                TextSpan(
                                    text: ' ${AppText.lbl_kwd(args: [
                                          getPriceAfterDiscount()
                                              .toStringAsFixed(2)
                                        ])} ${AppText.lbl_member}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          AppColors.FONT_LIGHT.withOpacity(.7),
                                    )),
                              ]),
                            ),
                            InkWell(
                              onTap: () {
                                final isGuest =
                                    context.read<AuthCubit>().state.isGuest;
                                if (isGuest) return showGuestSnackBar(context);
                                NavigatorHelper.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MembershipPlansScreen()));
                              },
                              child: CustomText(
                                text: AppText.msg_how_to_become_a,
                                color: AppColors.PlaceholderColor,
                                fontSize: 11,
                              ),
                            )
                          ],
                        );
                      }),
                  DefaultButton(
                    label: AppText.continue_,
                    onPressed: () async {
                      final isGuest = context.read<AuthCubit>().state.isGuest;
                      if (!isGuest)
                        await onContinuePressed(context);
                      else
                        showGuestSnackBar(context);
                    },
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
                              BlocBuilder<ServiceDetailsCubit,
                                  ServiceDetailsState>(
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
                                        Expanded(
                                          child: CustomText(
                                            text: state.service?.description ??
                                                '',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.FONT_LIGHT,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    // Benefits
                                    Row(
                                      children: [
                                        CustomText(
                                          text: AppText.benefits,
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
                                              margin:
                                                  EdgeInsets.only(right: 8.w),
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
                                    if (state.service?.videos.isNotEmpty ??
                                        false)
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              CustomText(
                                                text: AppText.lbl_videos,
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
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: 2,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          GestureDetector(
                                                            onTap: () {
                                                              NavigatorHelper.of(
                                                                      context)
                                                                  .push(
                                                                MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      FullScreenVideoPlayer(
                                                                    url: state
                                                                            .service
                                                                            ?.videos[index] ??
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
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              8.w),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                ),
                                                                const Positioned(
                                                                  top: 0,
                                                                  left: 0,
                                                                  right: 0,
                                                                  bottom: 0,
                                                                  child: Center(
                                                                      child:
                                                                          Icon(
                                                                    Icons
                                                                        .play_arrow,
                                                                    color: Colors
                                                                        .white,
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
                                        selectedFocusPoints:
                                            selectedFocusPoints,
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
                              ValueListenableBuilder(
                                  valueListenable: selectedDurationNotifier,
                                  builder: (context, value, child) {
                                    return TotalSection(
                                      selectedAddons: selectedAddons,
                                      totalDuration: totalDuration.toString(),
                                      selectedDuration: value,
                                      totalPrice:
                                          totalPrice().toStringAsFixed(2),
                                    );
                                  }),

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
        },
      ),
    );
  }

  Future<void> onContinuePressed(BuildContext context) async {
    checkIfGuest(context);
    if (selectedDurationNotifier.value == null) {
      //close the keyboard
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        closeIconColor: Colors.white,
        showCloseIcon: true,
        content: Text(
          AppText.please_select_a_duration,
        ),
      ));
      return;
    }
    var bookingCubit = context.read<BookingCubit>();
    final serviceBookModel = createServiceBookingModel();

    var success = await bookingCubit.addBookingService(serviceBookModel);
    if(!success){
      showSnackBar(context, message: AppText.msg_something_went_wrong);
      return;
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectMembersScreen()));
    // AdjustTracker.trackDurationSelected(
    //     serviceName: _serviceDetailsCubit.state.service!.title ?? '',
    //     duration:
    //         selectedDurationNotifier.value?.durationInMinutesInt?.toString() ??
    //             '');
  }

  ServiceBookModel createServiceBookingModel() {
    var serviceDetailsCubit = context.read<ServiceDetailsCubit>();

    return ServiceBookModel(
        serviceId: serviceDetailsCubit.state.service!.serviceId,
        durationId: selectedDurationNotifier.value?.serviceDurationId,
        addonIds: selectedAddons.map((e) => e.addonId).toList(),
        focusAreas:
            selectedFocusPoints.value?.keys.map((e) => e.index).toList() ?? []);
  }

  Future<void> checkIfGuest(BuildContext context) async {
    final authCubit = context.read<AuthCubit>();
    if (authCubit.state.isGuest)
      Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (_) => true);
  }
}

class TotalSection extends StatelessWidget {
  TotalSection(
      {super.key,
      required this.totalPrice,
      this.selectedDuration,
      required this.selectedAddons,
      this.totalDuration});
  final List<ServiceAddonModel> selectedAddons;
  final String totalPrice;
  final String? totalDuration;
  // int totalDuration = 0;
  final ServiceDurationModel? selectedDuration;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (context, state) {
        // state.service?.serviceDurations?.forEach((element) {
        //   totalDuration += int.tryParse(element.durationInMinutes) ?? 0;
        // });
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(
                height: 24.h,
              ),
              // title then the description
              Row(
                children: [
                  CustomText(
                    text: AppText.total_duration_service,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              if (selectedDuration != null || selectedAddons.isNotEmpty) ...[
                Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      CustomText(
                        text: state.service!.title ?? '',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.FONT_LIGHT.withOpacity(.7),
                      ),
                      const Spacer(),
                      CustomText(
                        text: AppText.min_count(args: [
                          selectedDuration?.durationInMinutes?.toString() ?? ''
                        ]),
                        // '${selectedDuration!.formattedString} ${selectedDuration?.unit}',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.PlaceholderColor,
                      ),
                    ],
                  ),
                ),
                ...selectedAddons.map((addon) => Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: Row(
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
                          CustomText(
                            text: '(${AppText.price_in_kd(args: [
                                  addon.price.toString()
                                ])}, ${AppText.min_count(args: [
                                  addon.durationInMinutes
                                ])})',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.PlaceholderColor,
                          ),
                        ],
                      ),
                    )),
              ] else
                Row(
                  children: [
                    CustomText(
                      text: AppText.no_duration_selected,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.FONT_LIGHT.withOpacity(.7),
                    ),
                    const Spacer(),
                    CustomText(
                      text: AppText.min_count(args: ['0']),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.PlaceholderColor,
                    ),
                  ],
                )
              ,
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
                  CustomText(
                    text: AppText.total_duration,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  CustomText(
                    text: AppText.min_count(args: [totalDuration ?? '0']),
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
              Row(
                children: [
                  CustomText(
                    text: AppText.add_on_s,
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
                            text: '(${AppText.price_in_kd(args: [
                                  addon.price.toString()
                                ])}, ${AppText.min_count(args: [
                                  addon.durationInMinutes
                                ])})',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.PlaceholderColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          // checkbox
                          Checkbox.adaptive(
                              // when the value is false the fill color is white
                              activeColor: AppColors.PRIMARY_COLOR,
                              value: ServiceDetailsScreen.of(context)
                                  .isAddonSelected(addon),
                              onChanged: (value) {
                                if (value == true) {
                                  ServiceDetailsScreen.of(context)
                                      .addAddon(addon);
                                } else {
                                  ServiceDetailsScreen.of(context)
                                      .removeAddons(addon);
                                }
                              }),
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
              Row(
                children: [
                  CustomText(
                    text: AppText.focus_area,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: AppText.focus_area_msg,
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
                  CustomText(
                    text: AppText.any_focus_area_today,
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
                    child: TextWithGradiant(
                        fontWeight: FontWeight.w500,
                        text: AppText.select_area,
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
                hint: AppText.select_focus_area,
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
  late final CarouselSliderController _carouselController;
  @override
  void initState() {
    _carouselController = CarouselSliderController();
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
              ),
              child: _buildBackButton(context),
            ),
          ),
        ),
      ],
    );
  }
}
