import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/search_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/services/application/service_cubit/service_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/presentation/screens/serice_details_screen.dart';
import 'package:masaj/features/services/presentation/widgets/filter_sheet_widget.dart';
import 'package:masaj/gen/assets.gen.dart';

class ServicesScreenArguments {
  final ServiceCategory? selectedServiceCategory;
  final List<ServiceCategory> allServiceCategories;

  ServicesScreenArguments(
      {this.selectedServiceCategory, required this.allServiceCategories});
}

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key, required this.screenArguments});
  final ServicesScreenArguments screenArguments;

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late ScrollController _scrollController;
  late ServiceCubit serviceCubit;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  bool searchIsFocused = false;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    _scrollController = ScrollController();
    serviceCubit = Injector().serviceCubit
      ..setServiceCategory(
          selectedServiceCategory:
              widget.screenArguments.selectedServiceCategory,
          allServicesCategories: widget.screenArguments.allServiceCategories)
      ..loadServices();
    // pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        serviceCubit.loadMoreServices();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCubit>(
      create: (context) => serviceCubit,
      child: Scaffold(
        appBar: CustomAppBar(title: 'services'.tr()),
        body: Column(
          children: [
            SizedBox(height: 24.h),
            _buildSearchAndFilterWidget(context),
            SizedBox(height: 24.h),
            _buildServiceCategoryTap(context),
            // tabs

            SizedBox(
              height: 24.h,
            ),

            Expanded(
              child: SevicesGridView(
                  serviceCubit: serviceCubit,
                  scrollController: _scrollController),
            ),

            _buildLoadingMore(context)
          ],
        ),
      ),
    );
  }

  // build loading more
  Widget _buildLoadingMore(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        if (state.isLoadingMore) {
          return SizedBox(
            height: 50.h,
            child: const CustomLoading(
              loadingStyle: LoadingStyle.Pagination,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  // build service category tap
  Widget _buildServiceCategoryTap(
    BuildContext context,
  ) {
    return ServicesTabs();
  }

  // build search and filter widget
  Widget _buildSearchAndFilterWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      height: 50.h,
      child: Row(
        children: [
          Expanded(
            child: SearchTextFormField.servicesSearchField(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              currentFocusNode: _searchFocusNode,
              currentController: _searchController,
              onChanged: (value) {
                serviceCubit.setSearchKeyword(value);
              },
            ),
          ),
          SizedBox(width: 8.w),
          Builder(builder: (context) {
            return InkWell(
              onTap: () async {
                await showModalBottomSheet<RangeValues?>(
                    isScrollControlled: true,
                    constraints: BoxConstraints(
                      minHeight: 680.h,
                      maxHeight: 680.h,
                    ),
                    enableDrag: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    builder: (context) {
                      return FilterWidgetSheet(serviceCubit: serviceCubit);
                    });
              },
              child: Container(
                height: 50.h,
                width: 50.h,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // gradiant color
                  gradient: AppColors.GRADIENT_COLOR,

                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  Assets.images.ioFilterOutline,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ServicesTabs extends StatelessWidget {
  const ServicesTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        return SizedBox(
          height: 50.h,
          child: ListView.builder(
            itemCount: state.allServiceCategories!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final serviceCategory = state.allServiceCategories![index];
              final bool isSelected =
                  serviceCategory.id == state.slectedServiceCategory!.id;

              return GestureDetector(
                onTap: () {
                  context
                      .read<ServiceCubit>()
                      .setSelectedServiceCategory(serviceCategory);
                },
                child: Container(
                  margin: // is ar
                      context.locale == const Locale('ar')
                          ? EdgeInsets.only(
                              left: 10, right: index == 0 ? 24 : 0)
                          : EdgeInsets.only(
                              right: 10, left: index == 0 ? 24 : 0),
                  height: 40,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  decoration: BoxDecoration(
                      gradient: AppColors.GRADIENT_Fill_COLOR,
                      // gradiant border

                      border: isSelected
                          ? GradientBoxBorder(
                              gradient: AppColors.GRADIENT_COLOR,
                              width: 1,
                            )
                          : Border.all(
                              color: const Color(0xffD9D9D9), width: 1),
                      borderRadius: BorderRadius.circular(43),
                      color: Colors.white),
                  alignment: Alignment.center,
                  child: isSelected
                      ? TextWithGradiant(
                          text: serviceCategory.name ?? '',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        )
                      : CustomText(
                          text: serviceCategory.name ?? '',
                          fontSize: 14,
                          color: const Color(0xff181B28),
                          fontWeight: FontWeight.w500,
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class SevicesGridView extends StatelessWidget {
  const SevicesGridView({
    super.key,
    required this.serviceCubit,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ServiceCubit serviceCubit;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {
        if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Error'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.services != null &&
            state.services!.data!.isEmpty &&
            state.isLoading) {
          return const Center(
            child: CustomLoading(
              loadingStyle: LoadingStyle.ShimmerGrid,
            ),
          );
        }
        if (state.services != null &&
            state.services!.data!.isEmpty &&
            !state.isLoading) {
          return EmptyPageMessage(
            heightRatio: 0.65,
            onRefresh: () async {
              serviceCubit.loadServices(
                refresh: true,
              );
            },
            svgImage: 'empty',
          );
        }
        return GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 9.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 158 / 188,
          ),
          itemCount: state.services?.data?.length ?? 0,
          itemBuilder: (context, index) {
            final service = state.services!.data![index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServiceDetailsScreen(
                              id: service.serviceId,
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    // border with #D9D9D9
                    border: Border.all(color: const Color(0xffD9D9D9))),
                child: Stack(
                  children: [
                    // image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 160.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CustomCachedNetworkImageProvider(
                                  service.mainImage ?? '',
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    // white container  at the bottom and floating
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 12.h),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: service.title ?? '',
                                fontSize: 12,
                                color: const Color(0xff1D212C),
                                fontWeight: FontWeight.w400,
                              ),

                              //Start from
                              CustomText(
                                text: 'start_from'.tr(),
                                fontSize: 9,
                                color: AppColors.PlaceholderColor,
                                fontWeight: FontWeight.w400,
                              ),
                              CustomText(
                                text: '${service.startingPrice} ${'KWD'.tr()}',
                                fontSize: 12,
                                color: const Color(0xff1D212C),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
