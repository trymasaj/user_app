import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../data/models/topics_model.dart';

import '../../../../di/injector.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';

import '../blocs/about_us_cubit/about_us_cubit.dart';

class AboutUsPage extends StatelessWidget {
  static const routeName = '/AboutUsPage';
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().aboutUsCubit..getAboutUsData(),
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          body: _buildAboutUsContent(context),
        ),
      ),
    );
  }

  Widget _buildAboutUsContent(BuildContext context) {
    return BlocConsumer<AboutUsCubit, AboutUsState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
      },
      builder: (context, state) {
        if (state.isInitial || state.isLoading)
          return const Expanded(
            child: CustomLoading(
              loadingStyle: LoadingStyle.Default,
            ),
          );

        return _buildAboutUsDetails(context, aboutUs: state.aboutUsData!);
      },
    );
  }

  Widget _buildAboutUsDetails(
    BuildContext context, {
    required Topic aboutUs,
  }) {
    final imageHeight = MediaQuery.of(context).size.width;
    const marginValue = 8.0;

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => context.read<AboutUsCubit>().refresh(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: marginValue),
          children: [
            _buildAboutUsImage(marginValue, imageHeight, aboutUs.picture!),
            _buildAboutUsText(context, aboutUs.name, aboutUs.content),
          ],
        ),
      ),
    );
  }

  Container _buildAboutUsImage(
      double marginValue, double imageHeight, String image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginValue),
      height: imageHeight - (marginValue * 2),
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: CustomCachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAboutUsText(BuildContext context, String? name, String? data) {
    final cubit = context.read<AboutUsCubit>();
    if (data?.isNotEmpty != true)
      return EmptyPageMessage(
        message: 'about_us_is_empty',
        onRefresh: cubit.refresh,
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Text(
            name ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: AppColors.PRIMARY_COLOR),
          ),
        ),
        Html(data: data),
      ],
    );
  }
}
