import 'package:flutter/cupertino.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/book_service/data/models/booking_model/booking_model.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';

class CheckoutState {}

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutState());

  late BookingCubit bookingCubit;

  init(BuildContext context) {
    bookingCubit = context.read<BookingCubit>();

    getBooking();
  }

  Future<void> getBooking() async {
    await bookingCubit.getBookingDetails();
  }


  bool isPaymentMethodsEnabled(BuildContext context){
      BookingCubit bookingCubit = context.read();
      WalletBloc walletCubit = context.read();
      BookingModel bookingModel = bookingCubit.state.bookingModel!;

      return ((walletCubit.state.walletBalance?.balance ?? 0).toDouble() < (bookingModel.grandTotal??0 - (bookingModel.discountedAmount ?? 0)).toDouble());

  }

}
