import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app/app.locator.dart';

class AuthService {
  final SnackbarService _snackbarService = locator<SnackbarService>();

  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  String? get currentUserId => _firebaseAuth.currentUser?.uid;
  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential?> registerUser(
    String email,
    String password,
  ) async {
    try {
      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredentials;
    } catch (e) {
      final text = AppLocalizations.of(
        StackedService.navigatorKey!.currentContext!,
      )!;

      if (e is SocketException) {
        _snackbarService.showSnackbar(
          message: text.noInternetError,
          title: text.error,
        );
      } else {
        _snackbarService.showSnackbar(
          message: text.registrationError,
          title: text.error,
        );
      }
    }
  }

  Future<bool> loginUser(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      final text = AppLocalizations.of(
        StackedService.navigatorKey!.currentContext!,
      )!;

      if (e is SocketException) {
        _snackbarService.showSnackbar(
          message: text.noInternetError,
          title: text.error,
        );
      } else {
        _snackbarService.showSnackbar(
          message: text.loginError,
          title: text.error,
        );
      }
    }

    return false;
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();

      return true;
    } catch (e) {
      final text = AppLocalizations.of(
        StackedService.navigatorKey!.currentContext!,
      )!;

      if (e is SocketException) {
        _snackbarService.showSnackbar(
          message: text.noInternetError,
          title: text.error,
        );
      } else {
        _snackbarService.showSnackbar(
          message: text.logoutError,
          title: text.error,
        );
      }
    }

    return false;
  }
}
