import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:masaj/core/data/device/file_picker_helper.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';

Future<FilePickerHelper?> showImageTypeBottomSheet(
  BuildContext context,
) {
  return showCupertinoModalPopup<FilePickerHelper>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: Text('gallery'.tr()),
          onPressed: () =>
              NavigatorHelper.of(context).pop(FilePickerHelper.gallery()),
        ),
        CupertinoActionSheetAction(
          child: Text('camera'.tr()),
          onPressed: () =>
              NavigatorHelper.of(context).pop(FilePickerHelper.camera()),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: NavigatorHelper.of(context).pop,
        child: Text('cancel'.tr()),
      ),
    ),
  );
}