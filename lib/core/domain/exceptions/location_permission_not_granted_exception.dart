import 'package:masaj/core/domain/exceptions/app_exception.dart';

class LocationPermissionNotGrantedException extends AppException {
  LocationPermissionNotGrantedException(
      {super.message, super.stackTrace, super.exception});
}
