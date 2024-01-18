import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/data/models/id_name_model.dart';
import 'package:masaj/core/data/typedefs/type_defs.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:size_helper/size_helper.dart';

enum _CustomDropDownMenuType { material, adaptive }

class CustomDropDownMenu<T> extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required T? currentItem,
    required List<T> items,
    String hint = '',
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
    EdgeInsets margin = EdgeInsets.zero,
    bool isRequired = false,
    bool underLine = true,
    required FutureValueChanged<T?>? onChanged,
    required String Function(T item) getStringFromItem,
    bool Function(T item)? isDisabled,
    bool Function(T item)? isComingSoon,
  })  : _currentItem = currentItem,
        _items = items,
        _hint = hint,
        _padding = padding,
        _margin = margin,
        _isRequired = isRequired,
        _underline = underLine,
        _dropDownAdaptiveType = _CustomDropDownMenuType.material,
        _onChanged = onChanged,
        _getStringFromItem = getStringFromItem,
        _isDisabled = isDisabled,
        _isComingSoon = isComingSoon;

  const CustomDropDownMenu.adaptive({
    super.key,
    required T? currentItem,
    required List<T> items,
    String hint = '',
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
    EdgeInsets margin = EdgeInsets.zero,
    bool isRequired = false,
    bool underLine = true,
    required FutureValueChanged<T?>? onChanged,
    required String Function(T item) getStringFromItem,
    bool Function(T item)? isDisabled,
    bool Function(T item)? isComingSoon,
  })  : _currentItem = currentItem,
        _items = items,
        _hint = hint,
        _padding = padding,
        _margin = margin,
        _isRequired = isRequired,
        _underline = underLine,
        _dropDownAdaptiveType = _CustomDropDownMenuType.adaptive,
        _onChanged = onChanged,
        _getStringFromItem = getStringFromItem,
        _isDisabled = isDisabled,
        _isComingSoon = isComingSoon;

  final T? _currentItem;
  final List<T> _items;
  final String _hint;
  final EdgeInsets _padding;
  final EdgeInsets _margin;
  final bool _isRequired;
  final bool _underline;
  final _CustomDropDownMenuType _dropDownAdaptiveType;
  final FutureValueChanged<T?>? _onChanged;
  final String Function(T item) _getStringFromItem;
  final bool Function(T item)? _isDisabled;
  final bool Function(T item)? _isComingSoon;

  @override
  State<CustomDropDownMenu<T>> createState() => _CustomDropDownMenuState<T>();
}

class _CustomDropDownMenuState<T> extends State<CustomDropDownMenu<T>> {
  bool _isBusy = false;
  T? _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget._currentItem;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget._dropDownAdaptiveType) {
      case _CustomDropDownMenuType.material:
        return _buildMaterialDropDown(context);

      case _CustomDropDownMenuType.adaptive:
        {
          final ThemeData theme = Theme.of(context);
          switch (theme.platform) {
            case TargetPlatform.android:
            case TargetPlatform.fuchsia:
            case TargetPlatform.linux:
            case TargetPlatform.windows:
              return _buildMaterialDropDown(context);
            case TargetPlatform.iOS:
            case TargetPlatform.macOS:
              return _buildCupertinoDropDown(context);
          }
        }
    }
  }

  Widget _buildMaterialDropDown(BuildContext context) {
    return Padding(
      padding: widget._margin,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.ACCENT_COLOR,
        ),
        child: DropdownButtonFormField<T>(
          isExpanded: true,
          hint: _buildHintText(context),
          decoration: InputDecoration(
            contentPadding: widget._padding,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            counterText: '',
            border: InputBorder.none,
            disabledBorder: widget._underline
                ? const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  )
                : null,
          ),
          icon: _isBusy
              ? const FittedBox(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : _currentItem == null || widget._isRequired
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    )
                  : InkWell(
                      borderRadius: BorderRadius.circular(10),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onTap: () => widget._onChanged != null
                          ? setState(
                              () => widget._onChanged!(_currentItem = null))
                          : null,
                    ),
          value: _currentItem,
          items: widget._items.map(_buildDropDownMenuItem(context)).toList(),
          validator: widget._isRequired ? Validator().validateEmptyValue : null,
          onChanged: _isBusy
              ? null
              : (value) {
                  if (widget._onChanged == null) return;
                  var futureOr = widget._onChanged!(_currentItem = value);
                  if (futureOr is Future) {
                    _setButtonToBusy();
                    futureOr.whenComplete(_setButtonToReady);
                  }
                },
          onTap: FocusScope.of(context).requestFocus,
        ),
      ),
    );
  }

  Widget _buildHintText(BuildContext context) {
    return Text(
      widget._hint + (widget._isRequired ? '*' : ''),
      style: context
          .sizeHelper(
            mobileLarge:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 10.0),
            tabletSmall:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12.0),
            tabletNormal:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12.0),
            desktopSmall:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.0),
          )
          .copyWith(color: AppColors.GREY_LIGHT_COLOR),
    );
  }

  DropdownMenuItem<T> Function(T) _buildDropDownMenuItem(
    BuildContext context,
  ) =>
      (item) {
        final isEnabled =
            !(widget._isDisabled ?? _isDisabledDefaultCallback)(item);
        final isComingSoon =
            (widget._isComingSoon ?? _isComingSoonDefaultCallback)(item);
        return CustomDropDownMenuItem<T>(
          value: item,
          enabled: isEnabled,
          itemColor: isEnabled ? null : AppColors.GREY_NORMAL_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget._getStringFromItem(item),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: context.sizeHelper(
                        tabletLarge: 16.0,
                        desktopSmall: 22.0,
                      )),
                ),
              ),
              if (isComingSoon)
                Text(
                  'coming_soon'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
            ],
          ),
        );
      };

  bool _isDisabledDefaultCallback(T item) {
    final condition = !T.toString().contains((IdNameModel).toString());
    if (condition) return false;

    return (item as IdNameModel?)?.disabled ?? false;
  }

  bool _isComingSoonDefaultCallback(T item) {
    final condition = !T.toString().contains((IdNameModel).toString());
    if (condition) return false;

    return (item as IdNameModel?)?.comingSoon ?? false;
  }

  void _setButtonToReady() => setState(() => _isBusy = false);

  void _setButtonToBusy() => setState(() => _isBusy = true);

  Widget _buildCupertinoDropDown(BuildContext context) {
    final currentItemNotSelected = _currentItem == null;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: CupertinoButton(
        padding: widget._padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                currentItemNotSelected
                    ? widget._hint
                    : widget._getStringFromItem(_currentItem as T),
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: currentItemNotSelected
                        ? AppColors.GREY_LIGHT_COLOR
                        : Colors.white,
                    fontSize: context.sizeHelper(
                      tabletLarge: currentItemNotSelected ? 14.0 : 16.0,
                      desktopSmall: currentItemNotSelected ? 18.0 : 22.0,
                    )),
              ),
            ),
            _isBusy
                ? const FittedBox(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _currentItem == null || widget._isRequired
                    ? const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    : InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: const Icon(Icons.close, color: Colors.white),
                        onTap: () => widget._onChanged != null
                            ? setState(
                                () => widget._onChanged!(_currentItem = null))
                            : null,
                      ),
          ],
        ),
        onPressed: () async {
          FocusScope.of(context).requestFocus();

          final value = await _showCupertinoModalPopup(context);

          if (value == null) return;

          if (widget._onChanged == null) return;
          var futureOr = widget._onChanged!(_currentItem = value);
          if (futureOr is Future) {
            _setButtonToBusy();
            futureOr.whenComplete(_setButtonToReady);
          }
        },
      ),
    );
  }

  Future<T?> _showCupertinoModalPopup(BuildContext context) {
    return showCupertinoModalPopup<T?>(
      context: context,
      builder: (context) => _CupertinoModalPopupWidget(
        items: widget._items,
        currentItem: _currentItem,
        getStringFromItem: widget._getStringFromItem,
      ),
    );
  }
}

class _CupertinoModalPopupWidget<T> extends StatefulWidget {
  const _CupertinoModalPopupWidget({
    super.key,
    required List<T> items,
    required String Function(T item) getStringFromItem,
    T? currentItem,
  })  : _items = items,
        _getStringFromItem = getStringFromItem,
        _currentItem = currentItem;

  final List<T> _items;
  final T? _currentItem;
  final String Function(T item) _getStringFromItem;

  @override
  State<_CupertinoModalPopupWidget<T>> createState() =>
      _CupertinoModalPopupWidgetState<T>();
}

class _CupertinoModalPopupWidgetState<T>
    extends State<_CupertinoModalPopupWidget<T>> {
  T? _currentItem;

  @override
  void initState() {
    _currentItem = widget._currentItem ?? widget._items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: 250,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Color(0xCCFFFFFF)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              DecoratedBox(
                decoration:
                    const BoxDecoration(color: AppColors.GREY_LIGHT_COLOR),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text(
                        'cancel'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.PRIMARY_COLOR,
                            ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoButton(
                      child: Text(
                        'done'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.PRIMARY_COLOR,
                            ),
                      ),
                      onPressed: () => Navigator.of(context).pop(_currentItem),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                      initialItem: _currentItem == null
                          ? 0
                          : widget._items.indexOf(_currentItem as T)),
                  onSelectedItemChanged: (index) =>
                      setState(() => _currentItem = widget._items[index]),
                  children:
                      widget._items.map(_buildCupertinoPickerItem).toList(),
                ),
              ),
              SizedBox(height: bottomPadding)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCupertinoPickerItem(item) => Center(
        child: Text(
          widget._getStringFromItem(item),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black,
                fontSize: 22.0,
              ),
        ),
      );
}

class CustomDropDownMenuItem<T> extends DropdownMenuItem<T> {
  const CustomDropDownMenuItem({
    super.key,
    super.onTap,
    super.value,
    super.enabled,
    super.alignment,
    required super.child,
    Color? itemColor,
  }) : _itemColor = itemColor;

  final Color? _itemColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
      decoration: BoxDecoration(color: _itemColor),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: child,
    );
  }
}
