import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/main/tabs/adoption/widgets/adoption_card.dart';
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
        return Container(
          color: theme.iconTheme.color!.withOpacity(0.05),
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                toolbarHeight: kToolbarHeight + 25,
                backgroundColor: theme.primaryColor,
                shadowColor: theme.primaryColor,
                elevation: 10,
                bottom: _CategoriesBar(
                  length: viewModel.sortingCategories.length,
                ),
                actions: [
                  IconButton(
                    splashRadius: 25,
                    onPressed: () => viewModel.goToSearchScreen(),
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const _AdoptionsList(),
            ],
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
      return SliverPadding(
        padding: EdgeInsets.only(top: height * 0.3),
        sliver: SliverToBoxAdapter(
          child: Text(
            text.emptyAnimalTypeCategory,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
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
          childCount: adoptionCount,
        ),
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

class _CategoriesBar extends StatelessWidget with PreferredSizeWidget {
  const _CategoriesBar({
    Key? key,
    required this.length,
  }) : super(key: key);

  final int length;

  @override
  Widget build(BuildContext context) {
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
            Expanded(
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
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
