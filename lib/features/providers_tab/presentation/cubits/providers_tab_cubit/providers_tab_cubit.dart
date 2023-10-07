
import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/providers_tab_repository.dart';
part 'providers_tab_state.dart';

class ProvidersTabCubit extends BaseCubit<ProvidersTabState> {
  ProvidersTabCubit({
    required ProvidersTabRepository providersTabRepository,
  })  : _providersTabRepository = providersTabRepository,
        super(const ProvidersTabState(status: ProvidersTabStateStatus.initial));

  final ProvidersTabRepository _providersTabRepository;
  

  
    }
  

