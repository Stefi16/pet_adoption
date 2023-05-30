// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i11;
import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/login/login_view.dart' as _i3;
import 'package:pet_adoption/authentication/registration/registration_view.dart'
    as _i4;
import 'package:pet_adoption/main/chat/all_chats/all_chats_view.dart' as _i10;
import 'package:pet_adoption/main/chat/chat_view.dart' as _i9;
import 'package:pet_adoption/main/main_view.dart' as _i5;
import 'package:pet_adoption/main/search/search_view.dart' as _i8;
import 'package:pet_adoption/main/tabs/adoption/adoption_details/adoption_details_view.dart'
    as _i7;
import 'package:pet_adoption/main/tabs/profile/themes/themes_view.dart' as _i6;
import 'package:pet_adoption/models/animal_adoption.dart' as _i12;
import 'package:pet_adoption/models/app_user.dart' as _i13;
import 'package:pet_adoption/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i14;

class Routes {
  static const splashView = '/';

  static const loginView = '/login-view';

  static const registrationView = '/registration-view';

  static const mainView = '/main-view';

  static const themesView = '/themes-view';

  static const adoptionDetailsView = '/adoption-details-view';

  static const searchView = '/search-view';

  static const chatView = '/chat-view';

  static const allChatsView = '/all-chats-view';

  static const all = <String>{
    splashView,
    loginView,
    registrationView,
    mainView,
    themesView,
    adoptionDetailsView,
    searchView,
    chatView,
    allChatsView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.registrationView,
      page: _i4.RegistrationView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i5.MainView,
    ),
    _i1.RouteDef(
      Routes.themesView,
      page: _i6.ThemesView,
    ),
    _i1.RouteDef(
      Routes.adoptionDetailsView,
      page: _i7.AdoptionDetailsView,
    ),
    _i1.RouteDef(
      Routes.searchView,
      page: _i8.SearchView,
    ),
    _i1.RouteDef(
      Routes.chatView,
      page: _i9.ChatView,
    ),
    _i1.RouteDef(
      Routes.allChatsView,
      page: _i10.AllChatsView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
        maintainState: false,
      );
    },
    _i3.LoginView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
        maintainState: false,
      );
    },
    _i4.RegistrationView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.RegistrationView(),
        settings: data,
        maintainState: false,
      );
    },
    _i5.MainView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.MainView(),
        settings: data,
        maintainState: false,
      );
    },
    _i6.ThemesView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ThemesView(),
        settings: data,
        maintainState: false,
      );
    },
    _i7.AdoptionDetailsView: (data) {
      final args = data.getArgs<AdoptionDetailsViewArguments>(nullOk: false);
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.AdoptionDetailsView(key: args.key, adoption: args.adoption),
        settings: data,
        maintainState: false,
      );
    },
    _i8.SearchView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.SearchView(),
        settings: data,
        maintainState: false,
      );
    },
    _i9.ChatView: (data) {
      final args = data.getArgs<ChatViewArguments>(nullOk: false);
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.ChatView(
            key: args.key,
            animalAdoption: args.animalAdoption,
            currentUser: args.currentUser,
            userPostedAdoption: args.userPostedAdoption),
        settings: data,
        maintainState: false,
      );
    },
    _i10.AllChatsView: (data) {
      return _i11.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.AllChatsView(),
        settings: data,
        maintainState: false,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AdoptionDetailsViewArguments {
  const AdoptionDetailsViewArguments({
    this.key,
    required this.adoption,
  });

  final _i11.Key? key;

  final _i12.AnimalAdoption adoption;

  @override
  String toString() {
    return '{"key": "$key", "adoption": "$adoption"}';
  }
}

class ChatViewArguments {
  const ChatViewArguments({
    this.key,
    required this.animalAdoption,
    required this.currentUser,
    required this.userPostedAdoption,
  });

  final _i11.Key? key;

  final _i12.AnimalAdoption animalAdoption;

  final _i13.AppUser currentUser;

  final _i13.AppUser userPostedAdoption;

  @override
  String toString() {
    return '{"key": "$key", "animalAdoption": "$animalAdoption", "currentUser": "$currentUser", "userPostedAdoption": "$userPostedAdoption"}';
  }
}

extension NavigatorStateExtension on _i14.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegistrationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registrationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToThemesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.themesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAdoptionDetailsView({
    _i11.Key? key,
    required _i12.AnimalAdoption adoption,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.adoptionDetailsView,
        arguments: AdoptionDetailsViewArguments(key: key, adoption: adoption),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.searchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatView({
    _i11.Key? key,
    required _i12.AnimalAdoption animalAdoption,
    required _i13.AppUser currentUser,
    required _i13.AppUser userPostedAdoption,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(
            key: key,
            animalAdoption: animalAdoption,
            currentUser: currentUser,
            userPostedAdoption: userPostedAdoption),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllChatsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allChatsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegistrationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registrationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithThemesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.themesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAdoptionDetailsView({
    _i11.Key? key,
    required _i12.AnimalAdoption adoption,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.adoptionDetailsView,
        arguments: AdoptionDetailsViewArguments(key: key, adoption: adoption),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.searchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatView({
    _i11.Key? key,
    required _i12.AnimalAdoption animalAdoption,
    required _i13.AppUser currentUser,
    required _i13.AppUser userPostedAdoption,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(
            key: key,
            animalAdoption: animalAdoption,
            currentUser: currentUser,
            userPostedAdoption: userPostedAdoption),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllChatsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allChatsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
