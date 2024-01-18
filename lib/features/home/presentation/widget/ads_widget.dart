import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/gen/assets.gen.dart';

class Ads extends StatefulWidget {
  const Ads({
    super.key,
  });

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  late CarouselController _carouselController;
  int current = 0;

  @override
  void initState() {
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 142,
            viewportFraction: .8,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            // aspectRatio: 3.0,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
          ),
          items: List.generate(
              4,
              (index) => Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(
                              Assets.lib.res.assets.imgGroup8.path,
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
                      const Positioned(
                        bottom: 0,
                        left: 10,
                        top: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Masaj is for',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Male,Female and \nCouples',
                              maxLines: 3,
                              style: TextStyle(
                                  height: 1.2,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
        ),
        const SizedBox(
          height: 10,
        ),
        // indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
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
    ));
  }
}
