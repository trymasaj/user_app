
import 'package:flutter_test/flutter_test.dart';
import 'package:masaj/core/extenstions/string_extensions.dart';

void main() {
  test('string.isLetters()', ()  {
    expect('asdfghj'.onlyLetters(), true);
    expect('أحمد'.onlyLetters(), true);
    expect('ASDFGDFGD'.onlyLetters(), true);
    //
    expect('asdfg٦'.onlyLetters(), false);
    expect('asdfg3'.onlyLetters(), false);
    expect('asdfghj_'.onlyLetters(), false);
    expect('asdfg_hj'.onlyLetters(), false);
  });
}
