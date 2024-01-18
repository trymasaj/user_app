import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/providers_tab/data/repositories/providers_tab_repository.dart';

part 'providers_tab_state.dart';

class ProvidersTabCubit extends BaseCubit<ProvidersTabState> {
  ProvidersTabCubit({
    required ProvidersTabRepository providersTabRepository,
  })  : _providersTabRepository = providersTabRepository,
        super(const ProvidersTabState(status: ProvidersTabStateStatus.initial));

  final ProvidersTabRepository _providersTabRepository;
}
