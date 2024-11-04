import 'package:masaj/core/app_text.dart';

typedef AvailableTherapistTabItem = ({int index, String hint, String icon, String selectedIcon});

List<AvailableTherapistTabItem> get availableTherapistsTabItems => [
      (index: 0, hint: AppText.select_available_therapist, icon: 'assets/images/new.svg', selectedIcon: 'assets/images/new_gr.svg'),
      (index: 1, hint: AppText.try_new_therapist, icon: 'assets/images/try_new.svg', selectedIcon: 'assets/images/try_new_gr.svg'),
      (index: 2, hint: AppText.piack_a_therapist, icon: 'assets/images/pick.svg', selectedIcon: 'assets/images/pick_grr.svg')
    ];
