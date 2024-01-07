import 'package:equatable/equatable.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:masaj/core/abstract/base_cubit.dart';

part 'verification_code_state.dart';


/// A bloc that manages the state of a VerificationCode according to the event that is dispatched to it.
class VerificationCodeBloc extends BaseCubit<VerificationCodeState>
    with CodeAutoFill {
  VerificationCodeBloc(VerificationCodeState initialState)
      : super(initialState) {}

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
