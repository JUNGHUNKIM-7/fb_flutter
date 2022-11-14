import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:newdemo/model/sign_form/sign_form.dart';

import '../stream/stream_controller.dart';

class AuthMain {
  final CombinedController combinedController;
  final FirebaseAuth ins = FirebaseAuth.instance;
  Stream<User?> get userExistStream => ins.authStateChanges();
  User? get currUser => ins.currentUser;

  late Sign? body;

  AuthMain._({required this.combinedController}) {
    combinedController.loginFormValues.listen((Map<String, String>? m) async {
      if (m != null && m.isNotEmpty) {
        body = Sign.fromJson(m);
        return;
      }
      body = null;
    });
  }

  factory AuthMain.getInstance(
          {required CombinedController combinedController}) =>
      AuthMain._(combinedController: combinedController);

  Future<void> bodyNullOrNot(Sign? body, AsyncCallback f) async {
    if (body != null && body.email.isNotEmpty && body.password.isNotEmpty) {
      await f();
    } else {
      throw FirebaseAuthException(
          code: "500", message: "signUp body is null now");
    }
  }

  Future<void> signUp() async {
    await bodyNullOrNot(
      body,
      () async => await ins
          .createUserWithEmailAndPassword(
            email: body!.email,
            password: body!.password,
          )
          .whenComplete(() => body = null),
    );
  }

  Future<void> signIn() async {
    await bodyNullOrNot(
      body,
      () async => await ins
          .signInWithEmailAndPassword(
            email: body!.email,
            password: body!.password,
          )
          .whenComplete(() => body = null),
    );
  }

  Future<void> signOut() async {
    await ins.signOut();
  }
}
