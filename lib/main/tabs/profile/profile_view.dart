import 'package:flutter/material.dart';
import 'package:pet_adoption/main/tabs/profile/profile_viewmodel.dart';
import 'package:pet_adoption/main/tabs/profile/widgets/account_widget.dart';
import 'package:pet_adoption/main/tabs/profile/widgets/profile_categories_text.dart';
import 'package:pet_adoption/main/tabs/profile/widgets/theme_widget.dart';
import 'package:pet_adoption/widgets/custom_button.dart';
import 'package:pet_adoption/widgets/universal_padding.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: UniversalPadding(
        child: ViewModelBuilder<ProfileViewModel>.nonReactive(
          viewModelBuilder: () => ProfileViewModel(),
          onViewModelReady: (vm) => vm.init(),
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileCategoriesText(text: text.account),
                const SizedBox(height: 15),
                const AccountWidget(),
                const Spacer(),
                ProfileCategoriesText(text: text.changeTheme),
                const SizedBox(height: 15),
                const ThemeWidget(),
                const SizedBox(height: 100),
                CustomButton(
                  text: text.logout,
                  onTap: () => viewModel.logout(),
                  isLoading: false,
                  icon: const RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.logout,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ),
    );
  }
}
