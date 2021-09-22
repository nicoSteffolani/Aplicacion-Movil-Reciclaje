import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleSignInApi extends StatelessWidget {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
