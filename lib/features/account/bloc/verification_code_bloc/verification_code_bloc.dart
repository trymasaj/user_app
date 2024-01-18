import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:sms_autofill/sms_autofill.dart';

part 'verification_code_state.dart';

/// A bloc that manages the state of a VerificationCode according to the event that is dispatched to it.
class VerificationCodeBloc extends BaseCubit<VerificationCodeState>
    with CodeAutoFill {
  VerificationCodeBloc(super.initialState);

  @override
  void codeUpdated() {
    _changeOTP(super.code!);
  }

  void _changeOTP(
    String otp,
  ) {
    emit(state.copyWith(otp: otp));
  }

  Future<void> _onInitialize() async {
    super.listenForCode();
  }
}
