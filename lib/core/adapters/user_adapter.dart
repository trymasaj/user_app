import '../enums/provider_enum.dart';

import '../../features/auth/data/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserAdapter {
  Future<User> adapt(user) {
    if (user is GoogleSignInAccount)
      return _adaptGoogleAccount(user);
    else
      return _adaptAppleAccount(user);
  }

  Future<User> _adaptGoogleAccount(GoogleSignInAccount user) async {
    final userFullName = user.displayName;

    final auth = await user.authentication;

    return User(
      fullName: userFullName,
      email: user.email,
      idToken: auth.idToken,
      googleAccessToken: auth.accessToken,
      provider: ProviderEnum.Google.value,
    );
  }

  Future<User> _adaptAppleAccount(AuthorizationCredentialAppleID user) async {
    final firstName = user.givenName;
    final lastName = user.familyName;
    final email = user.email;
    final idToken = user.authorizationCode;
    return User(
      fullName: "$firstName $lastName",
      email: email,
      idToken: idToken,
      provider: ProviderEnum.Apple.value,
    );
  }
}
