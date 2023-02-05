import 'package:pet_adoption/authentication/registration/registration_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../authentication/login/login_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(
      page: LoginView,
      initial: true,
    ),
    MaterialRoute(
      page: RegistrationView,
    ),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
  ],
)
class App {}
