import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/main/tabs/adoption/widgets/favourite_button_widget.dart';
import 'package:pet_adoption/models/animal_adoption.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/widgets/custom_button.dart';
import 'package:pet_adoption/widgets/profile_photo.dart';
import 'package:stacked/stacked.dart';

import 'adoption_details_viewmodel.dart';

const double _photoSize = 80;

class AdoptionDetailsView extends StatelessWidget {
  const AdoptionDetailsView({
    Key? key,
    required this.adoption,
  }) : super(key: key);

  final AnimalAdoption adoption;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: ViewModelBuilder<AdoptionDetailsViewModel>.reactive(
          viewModelBuilder: () => AdoptionDetailsViewModel(adoption),
          onViewModelReady: (vm) => vm.init(),
          builder: (context, viewModel, child) {
            final username = viewModel.getUsername();
            final email = viewModel.getEmail();
            final adoption = viewModel.getAdoption();

            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: adoption.photoUrl ?? '',
                  height: height * 0.59,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IntrinsicHeight(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: width,
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      adoption.animalName,
                                      style: TextStyle(
                                        color: theme.iconTheme.color,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.place_outlined,
                                          color: theme.primaryColor,
                                          size: 30,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${adoption.city}, ${adoption.country}',
                                          style: TextStyle(
                                            color: theme.iconTheme.color,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Stack(
                                    children: [
                                      Material(
                                        elevation: 10,
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 35,
                                          child: _FavouriteButtonWidget(
                                            adoption: adoption,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _AnimalCategoryInfoContainer(
                                  image: adoption.genderType
                                      .getAnimalGenderBackground(),
                                  infoType: text.gender,
                                  tooltipMessage:
                                      adoption.genderType.getAnimalGenderName(),
                                  child: Icon(
                                    adoption.genderType.getAnimalGenderIcon(),
                                    size: 30,
                                  ),
                                ),
                                _AnimalCategoryInfoContainer(
                                  image:
                                      'assets/backgrounds/age_pet_background.png',
                                  infoType: text.animalType,
                                  tooltipMessage:
                                      adoption.animalType.getAnimalTypeName(),
                                  child: Image.asset(
                                    adoption.animalType
                                        .getAnimalTypeImageName(),
                                    color: theme.iconTheme.color,
                                    width: 25,
                                  ),
                                ),
                                _AnimalCategoryInfoContainer(
                                  image:
                                      'assets/backgrounds/type_pet_background.png',
                                  infoType: text.age,
                                  child: Text(
                                    adoption.animalAge.getAnimalAgeText(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: theme.iconTheme.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: theme.iconTheme.color!,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      _photoSize,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      _photoSize,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: viewModel.getPhotoUrl(),
                                      progressIndicatorBuilder:
                                          (context, url, progress) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        );
                                      },
                                      width: _photoSize,
                                      height: _photoSize,
                                      fit: BoxFit.fill,
                                      errorWidget: (_, __, ___) => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: theme.primaryColorDark,
                                        ),
                                        child: Center(
                                          child: Text(
                                            username.isEmpty
                                                ? email[0].toUpperCase()
                                                : username[0].toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: width * 0.37,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        username.isEmpty ? email : username,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: theme.iconTheme.color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${text.owner} ${adoption.animalName.capitalizeFirstLetter()}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: theme.iconTheme.color,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                if (!viewModel
                                    .hasTheSameUserPostedTheAdoption())
                                  _RoundedButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.solidComments,
                                      color: theme.iconTheme.color,
                                    ),
                                    onTap: () => viewModel.goToChatScreen(),
                                    buttonColor:
                                        theme.primaryColor.withOpacity(0.3),
                                  ),
                                const SizedBox(width: 5),
                                if (viewModel.shouldShowPhoneButton())
                                  _RoundedButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.phoneVolume,
                                      color: theme.iconTheme.color,
                                    ),
                                    onTap: () => viewModel.onPhoneNumberTap(),
                                    buttonColor:
                                        theme.primaryColor.withOpacity(0.3),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: text.description,
                              onTap: () => viewModel.openDescriptionPopUp(
                                title: text.description,
                              ),
                              isLoading: false,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 50),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: _RoundedButton(
                      onTap: () => viewModel.goBack(),
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: theme.primaryColorDark,
                      ),
                    ),
                  ),
                ),
                if (viewModel.hasTheSameUserPostedTheAdoption())
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 50),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: _RoundedButton(
                        onTap: () => viewModel.deleteAdoption(),
                        icon: FaIcon(
                          FontAwesomeIcons.trashCan,
                          color: theme.primaryColorDark,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RoundedButton extends StatelessWidget {
  const _RoundedButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.buttonColor,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onTap;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: buttonColor ?? theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 0.5,
              color: buttonColor == null
                  ? theme.iconTheme.color!
                  : Colors.transparent,
            ),
          ),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}

class _AnimalCategoryInfoContainer extends StatelessWidget {
  const _AnimalCategoryInfoContainer({
    Key? key,
    required this.image,
    required this.infoType,
    this.tooltipMessage = '',
    required this.child,
  }) : super(key: key);

  final String image;
  final String infoType;
  final String tooltipMessage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Container(
      height: (width / 4.5),
      width: (width / 3.8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          opacity: 0.8,
          fit: BoxFit.fill,
          image: AssetImage(
            image,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            infoType,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: theme.iconTheme.color,
            ),
          ),
          const SizedBox(height: 10),
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: tooltipMessage,
            child: child,
          ),
        ],
      ),
    );
  }
}

class _FavouriteButtonWidget extends ViewModelWidget<AdoptionDetailsViewModel> {
  const _FavouriteButtonWidget({
    Key? key,
    required this.adoption,
  }) : super(key: key);

  final AnimalAdoption adoption;
  @override
  Widget build(BuildContext context, AdoptionDetailsViewModel viewModel) {
    return FavouriteButtonWidget(
      isFavourite: viewModel.isFavourite(adoption),
      onTap: () => viewModel.toggleFavourites(adoption),
    );
  }
}
