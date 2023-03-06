import 'package:pet_adoption/authentication/registration/registration_view.dart';
import 'package:pet_adoption/main/main_view.dart';
import 'package:pet_adoption/main/tabs/profile/themes/themes_view.dart';
import 'package:pet_adoption/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../authentication/login/login_view.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../services/image_upload_service.dart';
import '../services/theme_switcher_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(
      page: SplashView,
      initial: true,
    ),
    MaterialRoute(
      page: LoginView,
    ),
    MaterialRoute(
      page: RegistrationView,
    ),
    MaterialRoute(
      page: MainView,
    ),
    MaterialRoute(
      page: ThemesView,
    ),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: ImageUploaderService),
    LazySingleton(classType: ThemeSwitcherService),
  ],
)
class App {}
