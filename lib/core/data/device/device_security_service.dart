import 'package:root_check/root_check.dart';

abstract class DeviceSecurityService {
  Future<bool> isRooted();
}

class DeviceSecurityServiceImpl implements DeviceSecurityService {
  @override
  Future<bool> isRooted() async {
    return await RootCheck.isRooted ?? true;
  }
}
