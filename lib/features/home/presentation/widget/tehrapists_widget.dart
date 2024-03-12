import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';
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
  @override
  void initState() {
    _cubit = Injector().homeTherapistsCubit;
    _cubit.getRecommendedTherapists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocProvider(
        create: (context) => _cubit,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionTitle(title: 'book_with_therapists'.tr()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: BlocConsumer<HomeTherapistsCubit, HomeTherapistsState>(
                  listener: (context, state) {
                    // Fluttertoast.showToast(msg: 'No Update');
                  },
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const CustomLoading(
                        loadingStyle: LoadingStyle.ShimmerList,
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.therapists.length,
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
  });
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool withFiv;
  final Therapist? therapist;

  @override
  Widget build(BuildContext context) {
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
                        for (var i = 0; i < (therapist?.rank ?? 5); i++)
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
