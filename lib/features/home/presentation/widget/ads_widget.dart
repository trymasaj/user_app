import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/features/home/data/models/banner.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/presentation/pages/provider_details_screen.dart';
import 'package:masaj/features/services/presentation/screens/serice_details_screen.dart';

class Ads extends StatefulWidget {
  const Ads({
    super.key,
    required this.banners,
  });
  final List<BannerModel> banners;
  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  late CarouselSliderController _carouselController;
  int current = 0;

  @override
  void initState() {
    _carouselController = CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 142,
            viewportFraction: 0.93,
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
          ),
          items: List.generate(widget.banners.length, (index) {
            final banner = widget.banners[index];
            return GestureDetector(
              onTap: () {
                if (banner.isService && banner.serviceId != null) {
                  Navigator.of(context).pushNamed(
                    ServiceDetailsScreen.routeName,
                    arguments: ServiceDetailsScreenArguments(
                        id: banner.serviceId ?? 1),
                  );
                }
                if (banner.isTherapist && banner.therapistId != null) {
                  Navigator.of(context).pushNamed(
                    ProviderDetailsScreen.routeName,
                    arguments: ProviderDetailsScreenNavArguements(
                      therapist: Therapist(therapistId: banner.therapistId),
                    ),
                  );
                }
                if (banner.isSection && banner.sectionId != null) {}
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Stack(
                  children: [
                    Container(

                      decoration: BoxDecoration(


                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: CustomCachedNetworkImageProvider(
                            // is arabic
                            context.isAr
                                ? banner.imageUrlAr ?? ''
                                : banner.imageUrlEn ?? '',
                          ),
                          fit: BoxFit.cover,
                        ),

                      ),

                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // const Positioned(
                    //   bottom: 0,
                    //   left: 10,
                    //   top: 0,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         'Masaj is for',
                    //         style: TextStyle(
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.w400,
                    //             color: Colors.white),
                    //       ),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       Text(
                    //         'Male,Female and \nCouples',
                    //         maxLines: 3,
                    //         style: TextStyle(
                    //             height: 1.2,
                    //             fontSize: 25,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.white),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(
          height: 10,
        ),
        // indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.banners.length,
            (index) => GestureDetector(
              onTap: () {
                _carouselController.animateToPage(index);
              },
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: current == index
                      ? AppColors.ACCENT_COLOR
                      : AppColors.GREY_LIGHT_COLOR_2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
