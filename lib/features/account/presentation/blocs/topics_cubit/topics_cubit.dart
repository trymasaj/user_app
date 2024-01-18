import 'package:masaj/core/domain/enums/topic_type.dart';
import 'package:masaj/features/account/data/repositories/account_repository.dart';

import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/account/data/models/topics_model.dart';

part 'topics_state.dart';

class TopicsCubit extends BaseCubit<TopicsState> {
  TopicsCubit(this._accountRepository) : super(const TopicsState());

  final AccountRepository _accountRepository;

  Future<void> getTopicsData(TopicType id, [bool refresh = false]) async {
    final Topic? topicContent;
    try {
      if (!refresh) emit(state.copyWith(status: TopicsStateStatus.loading));

      topicContent = await _accountRepository.getTopicsData(id);
      emit(state.copyWith(
        status: TopicsStateStatus.loaded,
        topicContent: topicContent,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TopicsStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refresh(TopicType id) => getTopicsData(id, true);
}
