import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/authentication/widgets/app_auth_logo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/main/main_viewmodel.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/add_new_adoption_view.dart';
import 'package:pet_adoption/main/tabs/adoption/adoption_view.dart';
import 'package:pet_adoption/main/tabs/profile/profile_view.dart';
import 'package:pet_adoption/utils/common_logic.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, viewModel, child) => Container(
        color: viewModel.isDarkMode(context)
            ? theme.scaffoldBackgroundColor
            : theme.primaryColor,
        child: Scaffold(
          resizeToAvoidBottomInset: viewModel.currentTabIndex != 2,
          appBar: AppBar(
            title: Row(
              children: const [
                AppAuthLogo(
                  removeBottomPadding: true,
                ),
              ],
            ),
            centerTitle: false,
            backgroundColor: theme.primaryColor,
            actions: [
              IconButton(
                splashRadius: 25,
                visualDensity: getMinimumDensity(),
                onPressed: () => viewModel.goToChatsScreen(),
                icon: FaIcon(
                  FontAwesomeIcons.comments,
                  size: 23,
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
              IconButton(
                splashRadius: 25,
                visualDensity: getMinimumDensity(),
                onPressed: () => viewModel.goToSearchScreen(),
                icon: Icon(
                  Icons.search_rounded,
                  size: 30,
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
          body: const _CurrentTab(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) => viewModel.changeTab(index),
            currentIndex: viewModel.currentTabIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.pets_outlined,
                ),
                label: text.adopt,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.add_circle_outline,
                ),
                activeIcon: const Icon(
                  Icons.add_circle,
                ),
                label: text.add,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.person_2_outlined,
                ),
                activeIcon: const Icon(
                  Icons.person_2,
                ),
                label: text.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrentTab extends ViewModelWidget<MainViewModel> {
  const _CurrentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    switch (viewModel.currentTabIndex) {
      case 0:
        return const AdoptionView();
      case 1:
        return const AddNewAdoptionView();
      case 2:
        return const ProfileView();
      default:
        return const AdoptionView();
    }
  }
}
