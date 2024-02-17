import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_rating_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/home/presentation/widget/category_list.dart';
import 'package:masaj/features/providers_tab/presentation/pages/book_with_provider_sreen.dart';
import 'package:masaj/features/providers_tab/presentation/widgets/fav_icon_widget.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';

class ProviderDetailsScreen extends StatefulWidget {
  static const routeName = '/ProviderDetailsScreen';

  const ProviderDetailsScreen({super.key});

  // builder
  static MaterialPageRoute builder(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => const ProviderDetailsScreen(),
    );
  }

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
  late ScrollController _scrollController;

  Widget _buildHeader() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            _buildImage(),
            SizedBox(
              height: 4.h,
            ),
            const CustomText(
              text: 'Dr. Mahmoud',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              text: 'Sports massage specialist',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.FONT_LIGHT.withOpacity(.7),
            ),
            // row of countery flag and country name
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountryFlag.fromCountryCode('kw', height: 15, width: 15),
                SizedBox(
                  width: 5.w,
                ),
                const CustomText(
                  text: 'Kuwaiti',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.PlaceholderColor,
                ),
              ],
            ),
            // share button #F6F6F6
            SizedBox(
              height: 6.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/share.svg',
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  CustomText(
                    text: 'Share',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.FONT_LIGHT.withOpacity(.7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80.h,
          height: 80.h,
          margin: EdgeInsets.only(top: 24.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: CustomCachedNetworkImageProvider(
                  'https://t3.ftcdn.net/jpg/02/95/51/80/240_F_295518052_aO5d9CqRhPnjlNDTRDjKLZHNftqfsxzI.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // review icon
        Positioned(
          bottom: -(19.h / 2),
          left: 40.h - 19,
          width: 38.w,
          height: 19.h,
          child: Container(
            // alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: const Color(0xffECECEC),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/start.svg',
                  width: 10.w,
                  height: 10.h,
                ),
                const SizedBox(
                  width: 2,
                ),
                const CustomText(
                  text: '4.5',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAbout() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            const Row(
              children: [
                CustomText(
                  text: 'About',
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff1D212C),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            CustomText(
              text:
                  'A sports massage therapist is a professional who uses massage techniques to treat and care for athletes who are suffering injuries or pain. They work with their clients on rehabilitation processes, aiming to reduce pain.',
              fontFamily: 'DM Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.FONT_LIGHT.withOpacity(.7),
            ),
          ],
        ),
      ),
    );
  }

  late ServiceCategoryCubit serviceCategoryCubit;
  @override
  void initState() {
    serviceCategoryCubit = Injector().serviceCategoryCubit;
    serviceCategoryCubit.getServiceCategories();
    _scrollController = ScrollController();
    super.initState();
  }

  Widget _buildServiceCategories() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            const Row(
              children: [
                CustomText(
                  text: 'Services',
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff1D212C),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            CategoriesList(
              serviceCategoryCubit: serviceCategoryCubit,
              onPressed: (category) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => Injector().serviceCubit,
                              child: BookWithTherapistScreen(
                                  arguments: BookWithTherapistScreenArguments(
                                selectedServiceCategory: category,
                                allServiceCategories: serviceCategoryCubit
                                    .state.serviceCategories,
                              )),
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTitle() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Reviews ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1D212C),
                      ),
                      children: [
                        TextSpan(
                          text: '(3)',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.FONT_LIGHT.withOpacity(.7),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            // separated list of reviews
          ],
        ),
      ),
    );
  }

  Widget _buildReviews() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      // #1D212C
                      text: 'Osama Ahmed',
                      color: Color(0xff1D212C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),

                  // 20/01/2022
                  CustomText(
                      // #1D212C
                      text: '20/01/2022',
                      color: AppColors.PlaceholderColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              ),
              Row(
                children: [
                  CustomRatingBar(
                    itemCount: 5,
                    itemSize: 14,
                  ),
                ],
              ),
              CustomText(
                text:
                    'Dr. Mahmoud is a very professional therapist, he helped me a lot with my back pain.',
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.FONT_LIGHT.withOpacity(.7),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 14.h, top: 14.h),
            color: const Color(0xff1D212C).withOpacity(.5),
            height: .5.h,
          );
        },
        itemCount: 65,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          margin: EdgeInsets.only(bottom: 24.h),
          width: double.infinity,
          height: 60,
          color: Colors.white,
          child: DefaultButton(
            label: 'Book with DR. Mahmoud',
            onPressed: () {},
          )),
      appBar: const CustomAppBar(
        elevation: 0,
        title: '',
        actions: [
          FavIconWidget(
            isFav: false,
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildHeader(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 8.h,
            ),
          ),
          _buildAbout(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 32.h,
            ),
          ),
          _buildServiceCategories(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 32.h,
            ),
          ),
          _buildReviewsTitle(),
          _buildReviews()
        ],
      ),
    );
  }
}
