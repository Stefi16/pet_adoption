import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/main/tabs/profile/themes/themes_viewmodel.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked/stacked.dart';

class ThemesView extends StatelessWidget {
  const ThemesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ViewModelBuilder<ThemesViewModel>.nonReactive(
      viewModelBuilder: () => ThemesViewModel(),
      builder: (context, viewModel, child) {
        final isDarkMode = viewModel.isDarkMode(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(text.themes),
            leading: IconButton(
              onPressed: () => viewModel.goBack(),
              icon: Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              itemCount: FlexScheme.values.length,
              itemBuilder: (context, index) {
                final currentValue = FlexScheme.values.elementAt(index);
                final Color getColorDependingOnMode = isDarkMode
                    ? FlexThemeData.dark(
                        scheme: currentValue,
                      ).primaryColor
                    : FlexThemeData.light(
                        scheme: currentValue,
                      ).primaryColor;

                return Material(
                  child: InkWell(
                    onTap: () => viewModel.onThemeTapped(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.iconTheme.color!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: getColorDependingOnMode,
                      ),
                      child: Center(
                        child: Text(
                          currentValue.name.capitalizeFirstLetter(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: theme.scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        );
      },
    );
  }
}
