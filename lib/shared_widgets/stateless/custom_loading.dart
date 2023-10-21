import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum LoadingStyle {
  Default,
  ShimmerList,
  ShimmerGrid,
  Pagination,
  None,
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    LoadingStyle loadingStyle = LoadingStyle.Default,
    bool useColumn = false,
    Color? color,
    Color? baseColor,
    Color? highlightColor,
  })  : _loadingStyle = loadingStyle,
        _useColumn = useColumn,
        _color = color,
        _baseColor = baseColor,
        _highlightColor = highlightColor;

  final LoadingStyle _loadingStyle;
  final bool _useColumn;
  final Color? _color;
  final Color? _baseColor;
  final Color? _highlightColor;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    switch (_loadingStyle) {
      case LoadingStyle.Default:
        child = _buildDefaultLoading();
        break;
      case LoadingStyle.ShimmerList:
        child = _buildShimmerListLoading();
        break;
      case LoadingStyle.ShimmerGrid:
        child = _buildShimmerGridLoading();
        break;
      case LoadingStyle.Pagination:
        child = _buildPaginationLoading();
        break;
      case LoadingStyle.None:
        child = const SizedBox();
        break;
      default:
        throw Exception('Unknown loading style');
    }
    return Padding(
      padding: _loadingStyle == LoadingStyle.Pagination
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(16.0),
      child: child,
    );
  }

  Widget _buildDefaultLoading() =>
      Center(child: CircularProgressIndicator(color: _color));

  Widget _buildPaginationLoading() => Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 12.5,
          height: 12.5,
          child: FittedBox(child: CircularProgressIndicator(color: _color)),
        ),
      );

  Widget _buildShimmerListLoading() => Shimmer.fromColors(
        baseColor: _baseColor ?? Colors.grey[300]!.withOpacity(0.3),
        highlightColor: _highlightColor ?? Colors.grey[100]!.withOpacity(0.3),
        enabled: true,
        child: _useColumn
            ? Column(
                children:
                    List.generate(15, (index) => const _ListItemShimmer()),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (_, __) => const _ListItemShimmer(),
                itemCount: 15,
              ),
      );

  Widget _buildShimmerGridLoading() => Shimmer.fromColors(
        baseColor: _baseColor ?? Colors.grey[300]!.withOpacity(0.3),
        highlightColor: _highlightColor ?? Colors.grey[100]!.withOpacity(0.3),
        enabled: true,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 3,
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                Container(
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                Container(
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          itemCount: 9,
        ),
      );
}

class _ListItemShimmer extends StatelessWidget {
  const _ListItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 140.0,
            height: 140.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 14.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                Container(
                  width: double.infinity,
                  height: 14.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                Container(
                  width: 40.0,
                  height: 14.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                ),
                Container(
                  width: 40.0,
                  height: 14.0,
                  color: Colors.white,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                Container(
                  width: double.infinity,
                  height: 14.0,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
