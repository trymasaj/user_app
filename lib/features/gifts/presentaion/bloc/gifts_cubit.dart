import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/gifts/data/model/gift_model.dart';
import 'package:masaj/features/gifts/data/repo/gifts_repo.dart';
part 'gifts_state.dart';

class GiftsCubit extends BaseCubit<GiftsState> {
  GiftsCubit({
    required GiftsRepository giftsRepository,
  })  : _giftsRepository = giftsRepository,
        super(const GiftsState());

  final GiftsRepository _giftsRepository;

  Future<void> refresh() async {
    await getGiftCards();
  }

  Future<void> getGiftCards() async {
    emit(state.copyWith(status: GiftsStateStatus.loading));
    try {
      final giftCards = await _giftsRepository.getGitsCards();
      emit(state.copyWith(
          status: GiftsStateStatus.loaded, giftCards: giftCards));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: GiftsStateStatus.error, errorMessage: e.toString()));
    }
  }
}
