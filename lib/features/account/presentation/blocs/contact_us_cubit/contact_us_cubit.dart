import 'dart:developer';

import '../../../../../core/abstract/base_cubit.dart';

import '../../../../../core/exceptions/redundant_request_exception.dart';

import '../../../data/models/contact_us_message_model.dart';

import 'package:meta/meta.dart';

import '../../../data/repositories/account_repository.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends BaseCubit<ContactUsState> {
  ContactUsCubit(
    this._accountRepository,
  ) : super(const ContactUsState());

  final AccountRepository _accountRepository;

  Future<void> sendContactUsMessage(ContactUsMessage data) async {
    try {
      emit(state.copyWith(status: ContactUsStateStatus.loading));
      await _accountRepository.sendContactUsMessage((data));
      emit(state.copyWith(status: ContactUsStateStatus.success));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: ContactUsStateStatus.error, errorMessage: e.toString()));
    }
  }
}
