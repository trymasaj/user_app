import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_sliver_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/search_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/home/presentation/widget/search_field.dart';
import 'package:masaj/features/home/presentation/widget/tehrapists_widget.dart';
import 'package:masaj/features/providers_tab/enums/taps_enum.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/providers_tab_cubit/providers_tab_cubit.dart';

class ProvidersTab extends StatefulWidget {
  const ProvidersTab({super.key});

  static const routeName = '/ProvidersTabPage';

  @override
  State<ProvidersTab> createState() => _ProvidersTabState();
}

class _ProvidersTabState extends State<ProvidersTab>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late ProvidersTabCubit _cubit;
  late TextEditingController _searchController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _cubit.loadMoreTherapists();
      }
    });
    _cubit = DI.find<ProvidersTabCubit>();
    _cubit.getTherapists();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<ProvidersTabCubit, ProvidersTabState>(
        builder: (context, state) {
          return DefaultTabController(
            initialIndex: state.selectedTab.index,
            length: TherapistTabsEnum.values.length,
            child: Scaffold(
              appBar: CustomAppBar(
                title: AppText.providers,
              ),
              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 24.w, left: 24.h, top: 24),
                  child: Column(children: [
                    TabBar(
                        labelPadding: const EdgeInsets.all(5),
                        isScrollable: false,
                        onTap: (value) {
                          if (state.selectedTab.index != value)
                            _cubit.selectTab(TherapistTabsEnum.values[value]);
                        },
                        indicatorColor: Colors.transparent,
                        tabs: List.generate(TherapistTabsEnum.values.length,
                            (index) {
                          return Tab(
                              height: 36.h,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: state.selectedTab.index == index
                                        ? AppColors.GRADIENT_Fill_COLOR
                                        : null,
                                    border: state.selectedTab.index == index
                                        ? GradientBoxBorder(
                                            gradient: AppColors.GRADIENT_COLOR,
                                            width: 1,
                                          )
                                        : Border.all(
                                            color: const Color(0xffD9D9D9),
                                            width: 1),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                alignment: Alignment.center,
                                child: state.selectedTab.index == index
                                    ? TextWithGradiant(
                                        text: TherapistTabsEnum
                                            .values[index].name,
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : CustomText(
                                        text: TherapistTabsEnum
                                            .values[index].name,
                                        fontSize: 12,
                                        color: const Color(0xff181B28),
                                        fontWeight: FontWeight.w600,
                                      ),
                              ));
                        })),

                    SizedBox(
                      height: 20.h,
                    ),

                    // const SearchField(),
                    SizedBox(
                      height: 50.h,
                      child: SearchTextFormField(
                        contentPaddig: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        onChanged: (value) {
                          _cubit.search(value);
                        },
                        currentController: _searchController,
                        currentFocusNode: FocusNode(),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ), // Tab Bar View
                    if (
                        // TODO disabled for now
                        // state.therapistsList.isEmpty &&
                        state.isLoading)
                      const Expanded(
                        child: CustomLoading(
                          loadingStyle: LoadingStyle.ShimmerList,
                        ),
                      )
                    else if (state.therapistsList.isEmpty)
                      Expanded(
                        child: EmptyPageMessage(
                          heightRatio: 0.65,
                          onRefresh: () async {
                            _cubit.getTherapists(
                              refresh: true,
                            );
                          },
                          svgImage: 'empty',
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: state.isLoadingMore
                                ? state.therapistsList.length + 1
                                : state.therapistsList.length,
                            itemBuilder: (context, index) {
                              if (index == state.therapistsList.length) {
                                return const CustomLoading();
                              }
                              return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: TherapistWidget(
                                    withFiv: true,
                                    therapist: state.therapistsList[index],
                                  ));
                            }),
                      )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final double? maxHeight;
  final double? minHeight;

  TabBarDelegate(
      {required this.tabBar,
      this.bgColor = Colors.white,
      this.borderRadius,
      this.maxHeight,
      this.minHeight});

  final TabBar tabBar;
  final Color bgColor;
  final double? borderRadius;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0))),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => maxHeight ?? tabBar.preferredSize.height;

  @override
  double get minExtent => minHeight ?? tabBar.preferredSize.height;

  @override
  bool shouldRebuild(TabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

class WidgetDelegate extends SliverPersistentHeaderDelegate {
  WidgetDelegate(
      {required this.widget, this.bgColor = Colors.white, this.height = 50});

  final Widget widget;
  final Color bgColor;
  final double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: bgColor,
      child: widget,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(WidgetDelegate oldDelegate) {
    return widget != oldDelegate.widget;
  }
}
