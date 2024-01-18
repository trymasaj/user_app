enum UserType {
  admin,
  user;

  int get id => index + 1;

  @override
  String toString() => name;
}
