import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_oauth/firebase_ui_oauth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:vgs_flutter/firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    signInWithMicrosoft();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  //Future<UserCredential?> signInWithMicrosoft() async {
  Future<void> signInWithMicrosoft() async {
    final microsoftProvider = MicrosoftAuthProvider();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    if (kIsWeb) {
      await FirebaseAuth.instance.signInWithPopup(microsoftProvider);
    } else {
      await FirebaseAuth.instance.signInWithProvider(microsoftProvider);
    }

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}
