import 'package:firebase_auth/firebase_auth.dart';

import './auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceImpl implements AuthService {
  User? user;

  @override
  Future<void> signIn() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> logout() async {
    await Future.wait([
      FirebaseAuth.instance.signOut(),
      GoogleSignIn().disconnect(),
    ]);
  }
}
