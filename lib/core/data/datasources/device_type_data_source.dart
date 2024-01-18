import 'dart:io';

import 'package:injectable/injectable.dart';

abstract class DeviceTypeDataSource {
  int getDeviceType();
}
@LazySingleton(as: DeviceTypeDataSource)
class DeviceTypeDataSourceImpl implements DeviceTypeDataSource {
  @override
  int getDeviceType() {
    final deviceType = Platform.isIOS ? 1 : 2;
    return deviceType;
  }
}
