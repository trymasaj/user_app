import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';
import 'package:masaj/features/providers_tab/data/models/avilable_therapist_model.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/home_therapists_cubit/home_therapists_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/providers_tab_cubit/providers_tab_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/pages/provider_details_screen.dart';
import 'package:masaj/features/providers_tab/presentation/widgets/fav_icon_widget.dart';

class Therapists extends StatefulWidget {
  const Therapists({
    super.key,
  });

  @override
  State<Therapists> createState() => _TherapistsState();
}

class _TherapistsState extends State<Therapists> {
  late HomeTherapistsCubit _cubit;
  bool emptyState = false;
  @override
  void initState() {
    final authCubit = context.read<AuthCubit>();
    final isGuest = authCubit.state.isGuest;
    _cubit = _cubit = DI.find<HomeTherapistsCubit>();
    if (!isGuest) _cubit.getRecommendedTherapists();
    print("_TherapistsState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocProvider(
        create: (context) => _cubit,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: emptyState ? const SizedBox.shrink() : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionTitle(title: AppText.book_with_therapists),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: BlocConsumer<HomeTherapistsCubit, HomeTherapistsState>(
                  listener: (context, state) {
                    print("122222");
                    print(state);
                    print(state.therapists.isEmpty);
                    if (state.isLoaded && state.therapists.isEmpty) {
                      setState(() {
                        emptyState = true;
                      });
                    }
                  },
                  builder: (context, state) {
                    print("133333");
                    print(state.isLoaded);
                    print(state.isLoading);
                    if (state.isLoading) {
                      return const CustomLoading(
                        loadingStyle: LoadingStyle.ShimmerList,
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.therapists.isEmpty ? 0 : state.therapists.length,
                      itemBuilder: (context, index) {
                        return TherapistWidget(
                          therapist: state.therapists[index],
                          withFiv: true,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TherapistWidget extends StatelessWidget {
  const TherapistWidget({
    super.key,
    this.withFiv = false,
    this.width,
    this.padding,
    this.margin,
    this.therapist,
    this.isClckable = true,
  });
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool withFiv;
  final Therapist? therapist;
  final bool isClckable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isClckable
          ? null
          : () {
              if (therapist != null)
                NavigatorHelper.of(context).pushNamed(
                    ProviderDetailsScreen.routeName,
                    arguments: ProviderDetailsScreenNavArguements(
                        therapist: therapist!,
                        homeTherapistsCubit:
                            context.read<HomeTherapistsCubit?>(),
                        avialbleTherapistCubit:
                            context.read<AvialbleTherapistCubit?>(),
                        // ProvidersTabCubit is nullable
                        providersTabCubit: context.read<ProvidersTabCubit?>()));
            },
      child: Container(
        margin: margin ?? const EdgeInsets.only(right: 10),
        width: width ?? (withFiv ? 300 : 280),
        padding: padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.GREY_LIGHT_COLOR_2,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // image
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.GREY_LIGHT_COLOR_2,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: CustomCachedNetworkImageProvider(
                        therapist?.profileImage ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: therapist?.fullName ?? 'Therapist Name',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.FONT_COLOR,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    // start from
                    CustomText(
                        text: therapist?.title ?? 'Therapist Title',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.PlaceholderColor),

                    // rating
                    Row(
                      children: [
                        // for loop
                        for (var i = 0;
                            i < ((therapist?.rank?.toInt() ?? 0) > 5 ? 5 :(therapist?.rank?.toInt() ?? 0));
                            i++)
                          const Icon(Icons.star,
                              color: Color(0xffFFBA49), size: 15)
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // fav icon in circle
            const Spacer(),
            if (withFiv)
              FavIconWidget(
                width: 26.w,
                heaight: 26.h,
                padding: const EdgeInsets.all(6),
                isFav:
                    therapist == null ? false : therapist!.isFavourite ?? false,
              ),
          ],
        ),
      ),
    );
  }
}

class AvailableTherapistWidget extends StatelessWidget {
  const AvailableTherapistWidget({
    super.key,
    this.width,
    this.padding,
    this.margin,
    this.availableTherapistModel,
  });
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final AvailableTherapistModel? availableTherapistModel;

  @override
  Widget build(BuildContext context) {
    final therapist = availableTherapistModel?.therapist;

    return GestureDetector(
      onTap: () {
        if (therapist != null)
          NavigatorHelper.of(context).pushNamed(ProviderDetailsScreen.routeName,
              arguments: ProviderDetailsScreenNavArguements(
                  therapist: therapist!,
                  homeTherapistsCubit: context.read<HomeTherapistsCubit?>(),

                  // ProvidersTabCubit is nullable
                  providersTabCubit: context.read<ProvidersTabCubit?>()));
      },
      child: Container(
        margin: margin ?? const EdgeInsets.only(),
        width: width ?? 327.w,
        padding: padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xffD9D9D9),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Text(context.read<AvialbleTherapistCubit?>()?.state.toString() ??
            //     ''),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // image
                    Container(
                      height: 62.h,
                      width: 62.w,
                      decoration: BoxDecoration(
                        color: AppColors.GREY_LIGHT_COLOR_2,
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: CustomCachedNetworkImageProvider(
                            therapist?.profileImage ?? '',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: therapist?.fullName ?? 'Therapist Name',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.FONT_COLOR,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        // start from
                        CustomText(
                            text: therapist?.title ?? 'Therapist Title',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.PlaceholderColor),

                        // rating
                        Row(
                          children: [
                            // for loop
                            const Icon(Icons.star,
                                color: Color(0xffFFBA49), size: 15),
                            Text(
                              therapist?.rank?.toDouble().toString() ?? '0',
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(AppText.available,
                                style: TextStyle(
                                  color: AppColors.SUCCESS_COLOR,
                                  fontSize: 10,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: DefaultButton(
                        height: 40.h,
                        padding: const EdgeInsets.all(0),
                        color: Colors.white,
                        borderColor: AppColors.PRIMARY_COLOR,
                        borderWidth: 2,
                        textColor: AppColors.PRIMARY_COLOR,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        label: AppText.view_profile,
                        onPressed: () {
                          if (therapist != null)
                            NavigatorHelper.of(context).pushNamed(
                                ProviderDetailsScreen.routeName,
                                arguments: ProviderDetailsScreenNavArguements(
                                    avialbleTherapistCubit:
                                        context.read<AvialbleTherapistCubit?>(),
                                    therapist: therapist,
                                    homeTherapistsCubit:
                                        context.read<HomeTherapistsCubit?>(),
                                    // ProvidersTabCubit is nullable
                                    providersTabCubit:
                                        context.read<ProvidersTabCubit?>()));
                        })),
                SizedBox(
                  width: 5.w,
                ),
                Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: DefaultButton(
                        height: 40.h,
                        padding: const EdgeInsets.all(0),
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        label: AppText.lbl_select,
                        onPressed: () {
                          Navigator.pop(context, availableTherapistModel);
                        }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
