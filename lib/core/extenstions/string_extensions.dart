extension StringExtensions on String {
  // String get tr => this.tr();


  /// returns true if the input contains only letters in any lang,
  /// and doesn't contain numbers or special chars
  bool onlyLetters(){
    return RegExp(r'^[\p{L}]+$', unicode: true).hasMatch(this);
  }

}
