import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/clients/cache_manager.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/extensions/extensions.dart';
import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/search_text_form_field.dart';
import 'package:masaj/features/home/presentation/bloc/home_search_cubit/home_search_cubit.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/presentation/pages/provider_details_screen.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/presentation/screens/serice_details_screen.dart';
import 'package:masaj/gen/assets.gen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  // builder
  static Widget builder() {
    return BlocProvider<HomeSearchCubit>(
      create: (context) => DI.find<HomeSearchCubit>(),
      child: const SearchScreen(),
    );
  }

  static Route router() {
    return MaterialPageRoute<void>(
      builder: (_) => builder(),
    );
  }

  // route name
  static const routeName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  List<Widget> buildServices(
    List<ServiceModel> services,
  ) {
    return [
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // TODO: translate
                "Services",//AppText.services,
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
      // if ((state.result?.services ?? []).isNotEmpty)
      ServicesResults(
        services: services,
        onServiceTap: () async {
          await context
              .read<HomeSearchCubit>()
              .saveSearchKeyWord(_searchController.text);
          AdjustTracker.trackSearchService(_searchController.text);
        },
      )
    ];
  }

  List<Widget> buildProviders(
    List<Therapist> therapists,
  ) {
    return [
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppText.providers,
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
      // if ((state.result?.therapists ?? []).isNotEmpty)
      ProvidersResults(
          therapists: therapists,
          onProviderTap: () async {
            await context
                .read<HomeSearchCubit>()
                .saveSearchKeyWord(_searchController.text);
          })
    ];
  }

  Widget buildLoading() {
    return const SliverToBoxAdapter(
      child: CustomLoading(
        loadingStyle: LoadingStyle.ShimmerList,
      ),
    );
  }

  List<Widget> buildRecentlyViews(
    List<String> keys,
  ) {
    if (keys.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(60),
            child: const EmptyPageMessage(
              svgImage: 'empty',
            ),
          ),
        )
      ];
    }
    return [
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppText.recent_searches,
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
      RecenetHostory(
        keys: keys,
        searchController: _searchController,
      ),
    ];
  }
  // List<Widget> buildRecentlyViews(
  //   List<SearchResultModel> services,
  // ) {
  //   if (services.isEmpty) {
  //     return [
  //       SliverToBoxAdapter(
  //         child: Container(
  //           padding: const EdgeInsets.all(60),
  //           child: const EmptyPageMessage(
  //             svgImage: 'empty',
  //           ),
  //         ),
  //       )
  //     ];
  //   }
  //   return [
  //     SliverToBoxAdapter(
  //       child: Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 20),
  //         child: const Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             CustomText(
  //               text: 'recent_searches',
  //               fontSize: 14,
  //               fontWeight: FontWeight.w400,
  //               color: AppColors.FONT_COLOR,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     const SliverToBoxAdapter(
  //       child: SizedBox(
  //         height: 10,
  //       ),
  //     ),
  //     // list of recent searches
  //     RecenetHostory(
  //       services: services,
  //     ),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeSearchCubit, HomeSearchCubitState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 6.h,
                )),
                // search app bar
                SliverToBoxAdapter(
                  child: SearchBarWidget(
                      searchFocusNode: _searchFocusNode,
                      searchController: _searchController),
                ),
                // space
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                if ((state.result?.services ?? []).isNotEmpty)
                  ...buildServices(
                    state.result?.services ?? [],
                  ),
                if ((state.result?.therapists ?? []).isNotEmpty)
                  ...buildProviders(
                    state.result?.therapists ?? [],
                  ),
                if ((state.result?.services ?? []).isEmpty &&
                    (state.result?.therapists ?? []).isEmpty &&
                    state.isLoading)
                  buildLoading(),
                if ((state.result?.services ?? []).isEmpty &&
                    (state.result?.therapists ?? []).isEmpty &&
                    _searchController.text.isNotEmpty &&
                    state.isLoaded)
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(60),
                      child: const EmptyPageMessage(
                        svgImage: 'empty',
                      ),
                    ),
                  ),

                if (state.isEmptyResult && _searchController.text.isEmpty)
                  ...buildRecentlyViews(
                    state.recentSearchKeywords,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ServicesResults extends StatelessWidget {
  const ServicesResults({
    super.key,
    required this.services,
    this.onServiceTap,
  });
  final List<ServiceModel> services;
  // onServiceTap future function
  // future or not

  final FutureOr<void> Function()? onServiceTap;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: () async {
            if (onServiceTap != null) {
              // if on service is future
              await onServiceTap!();
            }

            await context
                .read<HomeSearchCubit>()
                .saveRecentSearchResult(SearchResultModel(
                  id: service.serviceId,
                  name: service.title,
                  type: SearchResultModelEnum.Service,
                ));
            // save recent search key

            Future.delayed(
                const Duration(milliseconds: 0),
                () => NavigatorHelper.of(context).pushNamed(
                    ServiceDetailsScreen.routeName,
                    arguments:
                        ServiceDetailsScreenArguments(id: service.serviceId)));
          },
          child: Container(
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
                      image: CustomCachedNetworkImageProvider(
                        service.mainImage ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // text
                Text(
                  service.title ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.FONT_COLOR,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProvidersResults extends StatelessWidget {
  const ProvidersResults({
    super.key,
    required this.therapists,
    this.onProviderTap,
  });
  final List<Therapist> therapists;
  final FutureOr<void> Function()? onProviderTap;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: therapists.length,
      itemBuilder: (context, index) {
        final therapist = therapists[index];
        return GestureDetector(
          onTap: () async {
            if (onProviderTap != null) {
              // if on service is future
              await onProviderTap!();
            }
            await context
                .read<HomeSearchCubit>()
                .saveRecentSearchResult(SearchResultModel(
                  id: therapist.therapistId,
                  name: therapist.fullName,
                  type: SearchResultModelEnum.Therapist,
                ));
            Future.delayed(
                const Duration(milliseconds: 0),
                () => NavigatorHelper.of(context)
                    .pushNamed(ProviderDetailsScreen.routeName,
                        arguments: ProviderDetailsScreenNavArguements(
                          therapist: therapist,
                        )));
          },
          child: Container(
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
                      image: CustomCachedNetworkImageProvider(
                        therapist.profileImage ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // text
                Text(
                  therapist.fullName ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.FONT_COLOR,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class RecenetHostory extends StatelessWidget {
//   const RecenetHostory({
//     super.key,
//     required this.services,
//   });
//   final List<SearchResultModel> services;

//   @override
//   Widget build(BuildContext context) {
//     return SliverList.builder(
//       itemCount: services.length,
//       itemBuilder: (context, index) {
//         final service = services[index];
//         return GestureDetector(
//           onTap: () async {
//             if (service.isService)
//               NavigatorHelper.of(context).pushNamed(
//                   ServiceDetailsScreen.routeName,
//                   arguments: ServiceDetailsScreenArguments(id: service.id!));
//             else if (service.isTherapist)
//               NavigatorHelper.of(context)
//                   .pushNamed(ProviderDetailsScreen.routeName,
//                       arguments: ProviderDetailsScreenNavArguements(
//                         therapist: Therapist(therapistId: service.id),
//                       ));
//           },
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 // search item
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Row(
//                     children: [
//                       // icon
//                       Container(
//                         margin: EdgeInsets.only(
//                             right: context.isAr ? 0 : 10,
//                             left: context.isAr ? 10 : 0),
//                         child: SvgPicture.asset(
//                           Assets.images.imgSolarHistoryOutline,
//                           color: AppColors.ACCENT_COLOR,
//                         ),
//                       ),
//                       // text
//                       Expanded(
//                         child: Text(
//                           service.name ?? '',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.FONT_COLOR,
//                           ),
//                         ),
//                       ),
//                       // close icon
//                       GestureDetector(
//                         onTap: () {
//                           context
//                               .read<HomeSearchCubit>()
//                               .removeRecentSearchResult(service);
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(left: 10),
//                           child: SvgPicture.asset(
//                             Assets.images.imgCloseOnprimary,
//                             color: AppColors.PlaceholderColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // divider
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
class RecenetHostory extends StatelessWidget {
  const RecenetHostory({
    super.key,
    required this.keys,
    required this.searchController,
  });
  final List<String> keys;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final service = keys[index];
        return GestureDetector(
          onTap: () async {
            searchController.text = service;
            await context.read<HomeSearchCubit>().search(service);
            // if (service.isService)
            //   NavigatorHelper.of(context).pushNamed(
            //       ServiceDetailsScreen.routeName,
            //       arguments: ServiceDetailsScreenArguments(id: service.id!));
            // else if (service.isTherapist)
            //   NavigatorHelper.of(context)
            //       .pushNamed(ProviderDetailsScreen.routeName,
            //           arguments: ProviderDetailsScreenNavArguements(
            //             therapist: Therapist(therapistId: service.id),
            //           ));
          },
          child: Container(
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
                      Expanded(
                        child: Text(
                          service ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.FONT_COLOR,
                          ),
                        ),
                      ),
                      // close icon
                      GestureDetector(
                        onTap: () {
                          context
                              .read<HomeSearchCubit>()
                              .removeSearchKeyWord(service);
                        },
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
    required FocusNode searchFocusNode,
  })  : _searchController = searchController,
        _searchFocusNode = searchFocusNode;

  final TextEditingController _searchController;
  final FocusNode _searchFocusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
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
                    Assets.images.imgArrowLeft,
                    color: AppColors.ACCENT_COLOR,
                    // height: 20,
                    // width: 20,
                  ),
          ),
        ),
        Expanded(
          child: BasicTextFiled(
            margin: EdgeInsets.only(
                left: context.isAr ? 24.w : 5.w,
                right: context.isAr ? 5.w : 24.w),
            isSearch: true,
            hintText: AppText.search,
            currentFocusNode: _searchFocusNode,
            currentController: _searchController,
            onChanged: (value) {
              context.read<HomeSearchCubit>().search(value);
            },
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.FONT_COLOR,
            ),
            hintColor: AppColors.PlaceholderColor,
            fillColor: AppColors.ExtraLight,
            borderColor: Colors.transparent,
            decoration: InputDecoration(
              hintText: AppText.search,
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
              focusedBorder: OutlineInputBorder(
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
                          context.read<HomeSearchCubit>().search('');
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
        )
      ],
    );
    SliverAppBar(
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
        child: BasicTextFiled(
          isSearch: true,
          hintText: AppText.search,
          currentFocusNode: _searchFocusNode,
          currentController: _searchController,
          onChanged: (value) {
            context.read<HomeSearchCubit>().search(value);
          },
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.FONT_COLOR,
          ),
          hintColor: AppColors.PlaceholderColor,
          fillColor: AppColors.ExtraLight,
          borderColor: Colors.transparent,
          decoration: InputDecoration(
            hintText: AppText.search,
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
                        context.read<HomeSearchCubit>().search('');
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
