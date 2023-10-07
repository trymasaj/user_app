
import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/settings_tab_repository.dart';
part 'settings_tab_state.dart';

class SettingsTabCubit extends BaseCubit<SettingsTabState> {
  SettingsTabCubit({
    required SettingsTabRepository settingsTabRepository,
  })  : _settingsTabRepository = settingsTabRepository,
        super(const SettingsTabState(status: SettingsTabStateStatus.initial));

  final SettingsTabRepository _settingsTabRepository;
  

  
    }
  

