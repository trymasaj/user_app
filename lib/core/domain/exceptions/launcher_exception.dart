import 'package:masaj/core/domain/exceptions/app_exception.dart';

class LauncherException extends AppException {
  LauncherException({super.message, super.stackTrace, super.exception});
}
