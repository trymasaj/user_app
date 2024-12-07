import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_rating_bar.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/widgets/therapist_info_card.dart';
import 'package:masaj/features/home/presentation/pages/home_tab.dart';
import 'package:masaj/features/home/presentation/widget/tehrapists_widget.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/services/application/service_cubit/service_cubit.dart';
import 'package:masaj/features/services/data/models/service_category_model.dart';
import 'package:masaj/features/services/presentation/screens/services_screen.dart';

class BookWithTherapistScreenArguments {
  final ServiceCategory? selectedServiceCategory;
  final List<ServiceCategory> allServiceCategories;
  final Therapist therapist;
  BookWithTherapistScreenArguments({
    this.selectedServiceCategory,
    required this.allServiceCategories,
    required this.therapist,
  });
}

class BookWithTherapistScreen extends StatefulWidget {
  final BookWithTherapistScreenArguments? arguments;

  const BookWithTherapistScreen({super.key, this.arguments});
  static const routeName = '/BookWithTherapistScreen';

  @override
  State<BookWithTherapistScreen> createState() =>
      _BookWithTherapistScreenState();
}

class _BookWithTherapistScreenState extends State<BookWithTherapistScreen> {
  late ScrollController _scrollController;
  late ServiceCubit serviceCubit;
  late Therapist therapist;
  @override
  void initState() {
    _scrollController = ScrollController();
    therapist = widget.arguments!.therapist;
    serviceCubit = context.read<ServiceCubit>();
    if (widget.arguments != null)
      serviceCubit.setServiceCategory(
          selectedServiceCategory: widget.arguments!.selectedServiceCategory,
          allServicesCategories: widget.arguments!.allServiceCategories);

    serviceCubit.setTherapistId(
      widget.arguments!.therapist.therapistId ?? 0,
    );

    serviceCubit.loadServices();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        serviceCubit.loadMoreServices();
      }
    });
    super.initState();
  }

  Widget _buildTherapustCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Row(
        children: [
          Container(
            height: 66,
            width: 66,
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
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                therapist.fullName ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.FONT_COLOR,
                ),
              ),
              // Sports massage specialist
              Text(
                therapist.title ?? '',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.FONT_LIGHT.withOpacity(.7),
                ),
              ),
             /* SizedBox(
                height: 5.h,
              ),
              CustomRatingBar(
                itemCount: ((therapist.rank?.toInt() ?? 0) > 5 ? 5 :(therapist.rank?.toInt() ?? 0)),
                itemSize: 10.5,
              )*/
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: AppText.book_with_therapist,
        ),
        body: Column(
          children: [
            _buildTherapustCard(),
            Container(
              height: 4,
              width: double.infinity,
              color: AppColors.GREY_LIGHT_COLOR_2,
            ),
            SizedBox(
              height: 20.h,
            ),
            const ServicesTabs(),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
                child: SevicesGridView(
              serviceCubit: serviceCubit,
              scrollController: _scrollController,
              therapist: therapist,
            ))
            // search field
          ],
        ));
  }
}
