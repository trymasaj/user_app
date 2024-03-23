enum AvailableTherapistTabEnum {
  anyAvailable(
      hint: 'select_available_therapist',
      icon: 'assets/images/new.svg',
      selectedIcon: 'assets/images/new_gr.svg'),
  newTherapist(
      hint: 'try_new_therapist',
      icon: 'assets/images/try_new.svg',
      selectedIcon: 'assets/images/try_new_gr.svg'),
  selectTherapist(
      hint: 'piack_a_therapist',
      icon: 'assets/images/pick.svg',
      selectedIcon: 'assets/images/pick_grr.svg');

  final String hint;
  final String icon;
  final String selectedIcon;
  const AvailableTherapistTabEnum(
      {required this.hint, required this.icon, required this.selectedIcon});
}
