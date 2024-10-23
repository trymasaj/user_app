
import 'package:flutter_test/flutter_test.dart';
import 'package:masaj/core/data/device/system_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/extenstions/string_extensions.dart';
import 'package:mocktail/mocktail.dart';

class MockSystemService extends Mock implements SystemService{}

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

  test('birthdate validator', ()  {

    final mockSystem = MockSystemService();
    when(()=> mockSystem.now ).thenReturn(DateTime(2010, 1, 1));
    DI.setSingleton<SystemService>(()=> mockSystem);

    expect(Validator().validateBirthDate('1/1/2000', 2)?.length ?? 0, 0);
    expect(Validator().validateBirthDate('1/1/2001', 2)?.length ?? 0, 0);
    expect(Validator().validateBirthDate('1/1/2002', 2)?.length ?? 0, 0);
    //
    expect(Validator().validateBirthDate('1/1/2009', 2)?.length ?? 0, greaterThan(0));
    expect(Validator().validateBirthDate('1/2/2008', 2)?.length ?? 0, greaterThan(0));
    expect(Validator().validateBirthDate('1/12/2009', 2)?.length ?? 0, greaterThan(0));

  });
}
