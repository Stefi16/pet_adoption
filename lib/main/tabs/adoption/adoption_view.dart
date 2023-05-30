import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/main/tabs/adoption/widgets/adoption_card.dart';
import 'package:pet_adoption/utils/common_logic.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'adoption_viewmodel.dart';

class AdoptionView extends StatelessWidget {
  const AdoptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<AdoptionViewModel>.nonReactive(
      onViewModelReady: (vm) => vm.init(),
      viewModelBuilder: () => AdoptionViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: theme.iconTheme.color!.withOpacity(0.05),
          body: const _AdoptionsList(),
          appBar: AppBar(
            toolbarHeight: 24,
            centerTitle: true,
            backgroundColor: theme.primaryColor,
            bottom: _CategoriesBar(
              onTap: () => viewModel.openSortingSheet(),
              length: viewModel.sortingCategories.length,
            ),
          ),
        );
      },
    );
  }
}

class _CategoriesChips extends ViewModelWidget<AdoptionViewModel> {
  const _CategoriesChips({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, AdoptionViewModel viewModel) {
    final theme = Theme.of(context);

    return TextButton(
      style: TextButton.styleFrom(
        side: BorderSide(
          color: theme.scaffoldBackgroundColor,
          width: 2,
        ),
        backgroundColor: viewModel.currentIndex == index
            ? theme.scaffoldBackgroundColor.withOpacity(0.3)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () => viewModel.changeCategory(index),
      child: Row(
        children: [
          if (index == 0)
            Icon(
              Icons.favorite,
              color: theme.scaffoldBackgroundColor,
            )
          else
            Image.asset(
              viewModel.getProperCategoryImage(index),
              color: theme.scaffoldBackgroundColor,
              width: 25,
            ),
          const SizedBox(width: 5),
          Text(
            viewModel.getProperText(index),
            style: TextStyle(
              fontSize: 15,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _AdoptionsList extends ViewModelWidget<AdoptionViewModel> {
  const _AdoptionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AdoptionViewModel viewModel) {
    final adoptionCount = viewModel.adoptions.length;
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;

    if (adoptionCount == 0) {
      return Padding(
        padding: EdgeInsets.only(top: height * 0.3),
        child: Text(
          text.emptyAnimalTypeCategory,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GridView.builder(
        itemCount: adoptionCount,
        itemBuilder: (context, index) {
          final adoption = viewModel.adoptions.elementAt(index);

          return AdoptionCard(
            onCardTap: () => viewModel.goToAdoptionDetailsPage(
              adoption,
            ),
            onFavouritesTap: () => viewModel.toggleFavourites(adoption),
            adoption: adoption,
            isFavourite: viewModel.isFavourite(adoption),
          );
        },
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

class _CategoriesBar extends ViewModelWidget<AdoptionViewModel>
    with PreferredSizeWidget {
  const _CategoriesBar({
    Key? key,
    required this.length,
    required this.onTap,
  }) : super(key: key);

  final int length;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, AdoptionViewModel viewModel) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 48,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              color: theme.scaffoldBackgroundColor.withOpacity(0.4),
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: onTap,
                  padding: EdgeInsets.zero,
                  splashRadius: 20,
                  visualDensity: getMinimumDensity(),
                  icon: FaIcon(
                    viewModel.getCurrentGenderIconData(),
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: ListView.builder(
                      itemCount: length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 5 : 0,
                            right: 5,
                          ),
                          child: _CategoriesChips(
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
