enum Gender {
  male,
  female,
  other;

  int get id => index + 1;

  @override
  String toString() => name;
}
