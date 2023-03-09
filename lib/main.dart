import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_adoption/main_app_viewmodel.dart';
import 'package:pet_adoption/services/theme_switcher_service.dart';
import 'package:pet_adoption/utils/setup_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _setupStackedServices();
  await _setAppOrientation();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainAppViewModel>.reactive(
      onViewModelReady: (vm) => vm.init(),
      viewModelBuilder: () => MainAppViewModel(),
      builder: (context, viewModel, child) => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('bg'),
        supportedLocales: const [
          Locale('bg'),
          Locale('en'),
        ],
        theme: FlexThemeData.light(
          scheme: viewModel.getProperColorTheme(),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        darkTheme: FlexThemeData.dark(
          scheme: viewModel.getProperColorTheme(),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        themeMode: viewModel.getCurrentThemeMode(),
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
      ),
    );
  }
}

Future<void> _setAppOrientation() async {
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}

Future<void> _setupStackedServices() async {
  await setupLocator();
  setupDialogUi();
  await locator<ThemeSwitcherService>().init();
}
