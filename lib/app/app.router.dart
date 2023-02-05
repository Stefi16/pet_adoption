// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../authentication/login/login_view.dart';
import '../authentication/registration/registration_view.dart';

class Routes {
  static const String loginView = '/';
  static const String registrationView = '/registration-view';
  static const all = <String>{
    loginView,
    registrationView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registrationView, page: RegistrationView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    RegistrationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RegistrationView(),
        settings: data,
      );
    },
  };
}
