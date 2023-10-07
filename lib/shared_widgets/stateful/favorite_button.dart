import 'dart:async';

import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    required FutureOr<bool> Function(bool) onFavTap,
    bool? initial,
  })  : _initial = initial ?? false,
        _onFavTap = onFavTap,
        super(key: key);

  final bool _initial;
  final FutureOr<bool> Function(bool) _onFavTap;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;
  bool _isLoading = false;

  @override
  void initState() {
    _isFavorite = widget._initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.favorite,
          size: context.sizeHelper(
            mobileLarge: 24.0,
            tabletLarge: 35.0,
            desktopSmall: 45.0,
          ),
          color: _isFavorite ? Colors.red : Colors.white,
        ),
      ),
      onTap: _isLoading
          ? () {}
          : () {
              _isFavorite = !_isFavorite;
              final futureOf = widget._onFavTap(_isFavorite);
              if (futureOf is Future) {
                _startLoading();
                (futureOf as Future).then(
                  (success) {
                    if (!success) {
                      _isFavorite = !_isFavorite;
                      if (mounted) setState(() {});
                    }
                  },
                ).whenComplete(_stopLoading);
              }
            },
    );
  }

  void _startLoading() {
    _isLoading = true;
    if (mounted) setState(() {});
  }

  void _stopLoading() {
    _isLoading = false;
    if (mounted) setState(() {});
  }
}
