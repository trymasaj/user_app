import 'package:masaj/core/domain/exceptions/app_exception.dart';

class ExceedFileSizeLimitException extends AppException {
  final int? fileSizeLimit;

  ExceedFileSizeLimitException(
      {super.message, this.fileSizeLimit, super.stackTrace, super.exception});
}
