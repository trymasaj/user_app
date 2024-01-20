import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/gen/assets.gen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // search app bar
            SearchBarWidget(searchController: _searchController),
            // space
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),

            // search results of services
            if (_searchController.text.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.FONT_COLOR,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              const ServicesResults()
            ],
            if (_searchController.text.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Providers',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.FONT_COLOR,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              const ProvidersResults()
            ],
            // search results
            // recent searches
            if (_searchController.text.isEmpty) ...[
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'recent_searches',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.FONT_COLOR,
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              // list of recent searches
              const RecenetHostory(),
            ]
          ],
        ),
      ),
    );
  }
}

class ServicesResults extends StatelessWidget {
  const ServicesResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // image container
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.GREY_LIGHT_COLOR_2,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.images.imgGroup8.path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              // text
              const Text(
                'Massage',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.FONT_COLOR,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProvidersResults extends StatelessWidget {
  const ProvidersResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // image container
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.GREY_LIGHT_COLOR_2,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.images.imgGroup8.path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              // text
              const Text(
                'Fahd',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.FONT_COLOR,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RecenetHostory extends StatelessWidget {
  const RecenetHostory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // search item
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    // icon
                    Container(
                      margin: EdgeInsets.only(
                          right: context.isAr ? 0 : 10,
                          left: context.isAr ? 10 : 0),
                      child: SvgPicture.asset(
                        Assets.images.imgSolarHistoryOutline,
                        color: AppColors.ACCENT_COLOR,
                      ),
                    ),
                    // text
                    const Expanded(
                      child: Text(
                        'Massage',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.FONT_COLOR,
                        ),
                      ),
                    ),
                    // close icon
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          Assets.images.imgCloseOnprimary,
                          color: AppColors.PlaceholderColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // divider
            ],
          ),
        );
      },
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      backgroundColor: Colors.white,
      pinned: true,
      expandedHeight: kToolbarHeight * 1.1,
      elevation: 0,
      centerTitle: false,
      leadingWidth: 55,

      // leading: const SizedBox(),

      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[200],
            height: 1,
          )),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: EdgeInsets.only(
              left: context.isAr ? 0 : 20, right: context.isAr ? 20 : 0),
          child: context.isAr
              ? SvgPicture.asset(
                  Assets.images.imgArrowRight,
                  color: AppColors.ACCENT_COLOR,
                  height: 30,
                  width: 30,
                )
              : SvgPicture.asset(
                  height: 30,
                  width: 30,
                  Assets.images.imgArrowLeft,
                  color: AppColors.ACCENT_COLOR,
                  // height: 20,
                  // width: 20,
                ),
        ),
      ),

      title: Container(
        margin: EdgeInsets.only(
            left: context.isAr ? 24 : 0, right: context.isAr ? 0 : 24),
        // width: MediaQuery.of(context).size.width,
        // alignment: Alignment.center,
        child: TextField(
          controller: _searchController,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.FONT_COLOR,
          ),
          decoration: InputDecoration(
            hintText: 'search'.tr(),
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.PlaceholderColor,
            ),

            // border radius is 8
            // border: InputBorder.none,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            fillColor: AppColors.ExtraLight,
            filled: true,

            suffixIconConstraints: const BoxConstraints(
              maxHeight: 30,
              maxWidth: 30,
            ),
            suffixIcon: Container(
              margin: EdgeInsets.only(
                  left: context.isAr ? 10 : 0, right: context.isAr ? 0 : 10),
              child: _searchController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        _searchController.clear();
                      },
                      child: SvgPicture.asset(
                        Assets.images.imgCloseOnprimary,
                        color: AppColors.PlaceholderColor,
                      ),
                    )
                  : SvgPicture.asset(
                      Assets.images.imgSearch,
                      color: AppColors.ACCENT_COLOR,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
