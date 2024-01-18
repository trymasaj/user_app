import 'package:masaj/core/domain/exceptions/app_exception.dart';

class SocialLoginCanceledException extends AppException {
  SocialLoginCanceledException(
      {super.message, super.stackTrace, super.exception});
}
