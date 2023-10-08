import 'dart:developer';

import 'package:masaj/core/abstract/base_cubit.dart';

import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/home_repository.dart';
import 'notifications_state.dart';

class NotificationsCubit extends BaseCubit<NotificationsState> {
  NotificationsCubit(this._homeRepository) : super(const NotificationsState());

  final HomeRepository _homeRepository;
  static const _pageSize = 10;

  Future<void> loadNotifications({
    bool refresh = false,
  }) async {
    try {
      emit(state.copyWith(
          status: refresh
              ? NotificationsStateStatus.refreshing
              : NotificationsStateStatus.loading));

      final newNotificationModel = await _homeRepository.getAllNotifications();

      emit(state.copyWith(
        status: NotificationsStateStatus.loaded,
        allNotification: newNotificationModel,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationsStateStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> refresh() => loadNotifications(refresh: true);

  Future<void> loadMoreNotifications() async {
    if (state.isLoadingMore) return;
    if (state.allNotification?.cursor == null) return;
    final oldNotifications = state.allNotification;
    if ((oldNotifications?.notifications ?? []).length < _pageSize) return;

    try {
      emit(state.copyWith(status: NotificationsStateStatus.loadingMore));

      final newNotificationModel = await _homeRepository.getAllNotifications(
        cursor: state.allNotification?.cursor,
      );

      emit(
        state.copyWith(
          status: NotificationsStateStatus.loaded,
          allNotification: newNotificationModel.copyWith(
            notifications: [
              ...?oldNotifications?.notifications,
              ...?newNotificationModel.notifications,
            ],
          ),
        ),
      );
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationsStateStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
