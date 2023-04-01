import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/widgets/custom_textfield.dart';
import 'package:pet_adoption/main/search/search_viewmodel.dart';
import 'package:pet_adoption/utils/common_logic.dart';
import 'package:pet_adoption/widgets/keyboard_unfocuser.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../tabs/adoption/widgets/adoption_card.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => SearchViewModel(),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, viewModel, child) {
        return KeyboardUnfocuser(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              titleSpacing: 0,
              leading: IconButton(
                visualDensity: getMinimumDensity(),
                splashRadius: 20,
                onPressed: () => viewModel.goBack(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
              ),
              centerTitle: false,
              title: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: SizedBox(height: 40, child: _SearchTextField()),
              ),
            ),
            body: const _SearchBody(),
          ),
        );
      },
    );
  }
}

class _SearchBody extends ViewModelWidget<SearchViewModel> {
  const _SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (viewModel.shouldShowDescription) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            text.searchDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemBuilder: (context, index) {
          final adoption = viewModel.searchResults.elementAt(index);

          return AdoptionCard(
            onCardTap: () => viewModel.goToAdoptionDetailsPage(
              adoption,
            ),
            onFavouritesTap: () => viewModel.toggleFavourites(adoption),
            adoption: adoption,
            isFavourite: viewModel.isFavourite(adoption),
          );
        },
        itemCount: viewModel.searchResults.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}

class _SearchTextField extends ViewModelWidget<SearchViewModel> {
  const _SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    final theme = Theme.of(context);

    return CustomTextField(
      onChanged: viewModel.onChange,
      prefixIcon: const Icon(Icons.search_rounded),
      controller: viewModel.searchTextController,
      textColor: theme.primaryColor,
      focusNode: viewModel.searchFieldFocusNode,
      label: '',
      hasError: false,
      suffixIcon: viewModel.showClearIcon
          ? GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => viewModel.clearText(),
              child: Icon(
                Icons.close,
                color: theme.primaryColor,
              ),
            )
          : null,
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }
}
