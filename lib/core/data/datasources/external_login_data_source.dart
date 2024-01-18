import 'package:masaj/core/domain/exceptions/social_media_login_canceled_exception.dart';

import 'package:masaj/core/data/adapters/user_adapter.dart';
import 'package:masaj/features/auth/data/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:masaj/core/data/constants/api_end_point.dart';

abstract class ExternalLoginDataSource {
  Future<User> login();
  Future<void> logOut();
}

class GoogleExternalLoginDataSourceImpl implements ExternalLoginDataSource {
  final _googleSignIn = GoogleSignIn(
    clientId:
        '35517194287-ht1iejcvg775nefmmedap7mlfkga68h6.apps.googleusercontent.com',
    scopes: ['email'],
  );

  @override
  Future<User> login() async {
    if (await _googleSignIn.isSignedIn()) await logOut();
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw SocialLoginCanceledException(message: "User didn't login");
    }
    final userAdapter = UserAdapter();
    final user = await userAdapter.adapt(googleUser);
    return user;
  }

  @override
  Future<void> logOut() async {
    if (await _googleSignIn.isSignedIn()) _googleSignIn.signOut();
  }
}

class AppleExternalLoginDataSourceImpl implements ExternalLoginDataSource {
  @override
  Future<User> login() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'sa.sela.saudieventsweb',
          redirectUri: Uri.parse(ApiEndPoint.APPLE_REDIRECT_URL),
        ),
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final userAdapter = UserAdapter();
      final user = await userAdapter.adapt(appleCredential);
      return user;
    } on SignInWithAppleAuthorizationException catch (_) {
      throw SocialLoginCanceledException(message:"User didn't login");
    }
  }

  @override
  Future<void> logOut() async {
    //Apple not enabled logout
    //throw UnimplementedError();
  }
}
