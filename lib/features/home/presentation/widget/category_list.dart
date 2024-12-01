import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/presentation/screens/services_screen.dart';
class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    this.isSliver = false,
    this.serviceCategoryCubit,
    this.onPressed,
    this.inHomePage = false,
  });
  final bool isSliver;
  final bool inHomePage;
  final ServiceCategoryCubit? serviceCategoryCubit;
  final Function(ServiceCategory category)? onPressed;

  Widget buildList() {
    return BlocBuilder<ServiceCategoryCubit, ServiceCategoryState>(
      builder: (context, state) {
        if (state.status == ServiceCategoryStateStatus.loading) {
          return SizedBox(
            height:160.h,
            child: const CustomLoading(
              loadingStyle: LoadingStyle.ShimmerList,
            ),
          );
        }
        return state.serviceCategories.isNotEmpty? SizedBox(
          height:162,
          child: ListView.builder(
            padding: EdgeInsets.only(left:inHomePage ? 20:0,top:20,right:inHomePage ? 20:0),
            scrollDirection: Axis.horizontal,
            itemCount: state.serviceCategories.length,
            itemBuilder: (context, index) {
              final category = state.serviceCategories[index];
              return InkWell(
                onTap: onPressed != null
                    ? () {
                        onPressed!(category);
                      }
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ServicesScreen(
                                    screenArguments: ServicesScreenArguments(
                                        selectedServiceCategory: category,
                                        allServiceCategories:
                                            state.serviceCategories))));
                      },
                child: Container(
                  margin:  EdgeInsets.only(right:  context.locale.languageCode == 'ar' ? 0 :10, left:context.locale.languageCode == 'ar' ? 10 :0),
                  width: 110.w,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.GREY_LIGHT_COLOR_2,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // image
                      Container(
                        height: 82.h,
                        width: 83.w,
                        decoration: BoxDecoration(
                          color: AppColors.GREY_LIGHT_COLOR_2,
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: NetworkImage(
                              category.imageUrl ?? '',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        category.name ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.fSize,
                            fontWeight: FontWeight.w400,
                            color: AppColors.FONT_COLOR),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ) : const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return isSliver
            ? SliverToBoxAdapter(
                child: buildList(),
              )
            : buildList();
      },
    );
  }
}
