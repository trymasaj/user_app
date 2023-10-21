import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../blocs/favorites_cubit/favorites_cubit.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/stateless/favorite_item_card.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

class FavoritesPage extends StatefulWidget {
  static const routeName = '/FavoritesPage';
  const FavoritesPage({
    super.key,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    final favCubit = context.read<FavoritesCubit>();
    favCubit.loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeTop: true,
      safeBottom: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildAppBar(context),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const TitleText(text: 'favorites'),
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: 40.0,
        ),
        onPressed: NavigatorHelper.of(context).pop,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final height = (screenWidth * 0.4) - 16.0;
    final favCubit = context.read<FavoritesCubit>();

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.isInitial || state.isLoading)
          return const CustomLoading(
            loadingStyle: LoadingStyle.ShimmerList,
          );
        if (state.favoritesList?.isNotEmpty == true)
          return LazyLoadScrollView(
            onEndOfPage: favCubit.loadMoreFavorites,
            isLoading: favCubit.state.isLoadingMore,
            child: RefreshIndicator(
              onRefresh: favCubit.refresh,
              color: AppColors.ACCENT_COLOR,
              child: ListView.builder(
                itemCount: state.favoritesList!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.favoritesList!.length)
                    return _buildPaginationLoading();
                  var item = state.favoritesList![index];
                  return FavoriteItemCard(
                    event: item,
                    height: height,
                    onTap: () => null,
                    onDeleteTap: () => favCubit.removeFromFav(
                      item.id!,
                      index,
                    ),
                  );
                },
              ),
            ),
          );
        else
          return const EmptyPageMessage(
            message: 'you_have_no_favorites_yet',
            svgImage: 'no_points',
          );
      },
    );
  }

  Widget _buildPaginationLoading() {
    return Builder(
      builder: (context) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: context.watch<FavoritesCubit>().state.isLoadingMore
            ? const CustomLoading(loadingStyle: LoadingStyle.Pagination)
            : const SizedBox(),
      ),
    );
  }
}
