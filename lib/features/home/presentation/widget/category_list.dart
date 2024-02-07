import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';
import 'package:masaj/features/services/presentation/screens/services_screen.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 140.h,
        child: BlocBuilder<ServiceCategoryCubit, ServcieCategoryState>(
          builder: (context, state) {
            if (state.status == ServcieCategoryStateStatus.loading) {
              return const CustomLoading(
                loadingStyle: LoadingStyle.ShimmerList,
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: state.serviceCategories.length,
              itemBuilder: (context, index) {
                final category = state.serviceCategories[index];
                return InkWell(
                  onTap: () {
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
                    margin: const EdgeInsets.only(right: 10),
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
                          height: 80.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: AppColors.GREY_LIGHT_COLOR_2,
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: NetworkImage(
                                category.image ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          category.name ?? '',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.FONT_COLOR),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
