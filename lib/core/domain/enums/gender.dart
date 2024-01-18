enum Gender {
  male,
  female;

  int get id => index + 1;

  @override
  String toString() => name;
}
