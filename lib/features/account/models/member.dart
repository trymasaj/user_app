class Member {
  final String name, image, phone, gender;
  bool isSelected;

  Member(
      {required this.name,
      required this.image,
      required this.gender,
      required this.phone,
      this.isSelected = false});
}
