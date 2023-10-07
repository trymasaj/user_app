import '../../../../../core/enums/topic_type.dart';
import '../../../data/repositories/account_repository.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../data/models/topics_model.dart';

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
