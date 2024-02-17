import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_sliver_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_with_gradiant.dart';
import 'package:masaj/features/home/presentation/widget/search_field.dart';
import 'package:masaj/features/home/presentation/widget/tehrapists_widget.dart';

class ProvidersTab extends StatefulWidget {
  const ProvidersTab({super.key});

  static const routeName = '/ProvidersTabPage';

  @override
  State<ProvidersTab> createState() => _ProvidersTabState();
}

class _ProvidersTabState extends State<ProvidersTab>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  final tabs = ['all', 'past', 'favorites'];

  int current = 0;

  bool isSelected(int index) => current == index;

  Widget buildBorderWidget(int index, Widget child) => Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            gradient: isSelected(index) ? null : AppColors.GRADIENT_COLOR,
            borderRadius: BorderRadius.circular(30),
            color: isSelected(index)
                ? const Color(0xffD9D9D9)
                : Colors.transparent),
        alignment: Alignment.center,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: current,
      length: tabs.length,
      child: CustomAppPage(
        child: Scaffold(
          body: CustomScrollView(controller: _scrollController, slivers: [
            const CustomSliverAppBar(
              title: 'providers',
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            // tabs every tab is 30 border radius
            // create a list of tabs
            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(
                // bgColor: MyColors.scaffoldBackgroundColorMain,
                borderRadius: 15,
                tabBar: TabBar(
                    labelPadding: const EdgeInsets.all(5),
                    isScrollable: false,
                    onTap: (value) {
                      setState(() {
                        current = value;
                      });
                    },
                    indicatorColor: Colors.transparent,
                    // labelColor: Colors.black,
                    // unselectedLabelColor: Colors.grey,
                    tabs: [
                      ...List.generate(
                          tabs.length,
                          (index) => Tab(

                                  // height: 40,
                                  child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    gradient: AppColors.GRADIENT_Fill_COLOR,
                                    // gradiant border

                                    border: isSelected(index)
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
                                child: isSelected(index)
                                    ? TextWithGradiant(
                                        text: tabs[index],
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : CustomText(
                                        text: tabs[index],
                                        fontSize: 12,
                                        color: const Color(0xff181B28),
                                        fontWeight: FontWeight.w600,
                                      ),
                              ))),
                    ]),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            const SearchField(),

            // Tab Bar View
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const TherapistWidget(
                              withFiv: true,
                            ));
                      }),
                  ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const TherapistWidget(
                              withFiv: true,
                            ));
                      }),
                  ListView.builder(itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const TherapistWidget(
                          withFiv: true,
                        ));
                  }),
                ],
              ),
            )
          ]),
        ),
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
