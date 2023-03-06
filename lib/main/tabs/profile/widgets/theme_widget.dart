import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../profile_viewmodel.dart';

class ThemeWidget extends ViewModelWidget<ProfileViewModel> {
  const ThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    final isDarkMode = viewModel.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _RoundedThemeButton(
          onTap: () => viewModel.goToThemesScreen(),
          centerWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.brush,
                size: 50,
                color: theme.primaryColorDark,
              ),
              const SizedBox(height: 5),
              Text(
                text.themes,
                style: TextStyle(
                  color: theme.primaryColorDark,
                ),
              ),
            ],
          ),
        ),
        _RoundedThemeButton(
          onTap: () => viewModel.toggleMode(isDarkMode),
          centerWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IgnorePointer(
                ignoring: true,
                child: DayNightSwitcher(
                  isDarkModeEnabled: isDarkMode,
                  onStateChanged: (state) {},
                  dayBackgroundColor: theme.primaryColor,
                  nightBackgroundColor: theme.primaryColorDark,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                isDarkMode ? text.darkTheme : text.lightTheme,
                style: TextStyle(
                  color: theme.primaryColorDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoundedThemeButton extends StatelessWidget {
  const _RoundedThemeButton({
    Key? key,
    required this.centerWidget,
    required this.onTap,
  }) : super(key: key);

  final Widget centerWidget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        splashColor: theme.primaryColor.withOpacity(0.2),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: centerWidget,
          ),
        ),
      ),
    );
  }
}
