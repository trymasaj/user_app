enum Gender {
  Male,
  Female;

  int get id => index + 1;

  @override
  String toString() => name;
}
