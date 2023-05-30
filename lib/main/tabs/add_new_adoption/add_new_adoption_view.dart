import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/authentication/widgets/custom_textfield.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/choose_age_wheel.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/choose_gender_radio_button.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/chosen_animal_type_widget.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/error_text.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/upload_photo_widget.dart';
import 'package:pet_adoption/widgets/custom_button.dart';
import 'package:pet_adoption/widgets/keyboard_unfocuser.dart';
import 'package:pet_adoption/widgets/universal_padding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import 'add_new_adoption_viewmodel.dart';

const double _commonPadding = 15;

class AddNewAdoptionView extends StatelessWidget {
  const AddNewAdoptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return KeyboardUnfocuser(
      child: Container(
        height: double.maxFinite,
        color: theme.iconTheme.color!.withOpacity(0.05),
        child: SingleChildScrollView(
          child: UniversalPadding(
            child: ViewModelBuilder<AddNewAdoptionViewModel>.nonReactive(
              viewModelBuilder: () => AddNewAdoptionViewModel(),
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    const _Title(),
                    const SizedBox(height: _commonPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        UploadPhotoWidget(),
                        SizedBox(width: _commonPadding),
                        _NameTextField(),
                      ],
                    ),
                    const SizedBox(height: _commonPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        ChosenAnimalTypeWidget(),
                        ChooseAgeWidget(),
                      ],
                    ),
                    const SizedBox(height: _commonPadding),
                    CustomTextField(
                      label:
                          '${text.breed} (${text.notMandatory.toLowerCase()})',
                      hasError: false,
                      isBorderPrimaryColor: true,
                      textInputAction: TextInputAction.next,
                      controller: viewModel.breedController,
                      onEditingComplete: () =>
                          viewModel.countryFocusNode.requestFocus(),
                    ),
                    const SizedBox(height: _commonPadding),
                    const _CountryTextField(),
                    const _CityTextField(),
                    const _DescriptionTextField(),
                    const _PublishButton(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text.addAdoptionTitle,
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Tooltip(
          showDuration: const Duration(seconds: 5),
          message: text.addAdoptionDescription,
          triggerMode: TooltipTriggerMode.tap,
          child: SizedBox(
            width: 25,
            height: 25,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.question_mark,
                    color: theme.primaryColor,
                    size: 20,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NameTextField extends ViewModelWidget<AddNewAdoptionViewModel> {
  const _NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final text = AppLocalizations.of(context)!;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: [
          CustomTextField(
            label: text.name,
            hasError: viewModel.hasNameError,
            isBorderPrimaryColor: true,
            textInputAction: TextInputAction.done,
            controller: viewModel.nameController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^[a-zA-Zа-яА-Я\s-]+$'),
              ),
            ],
          ),
          const SizedBox(height: 5),
          if (viewModel.hasNameError)
            ErrorText(
              text: text.nameError,
            ),
          const ChosenGenderRadioButton(),
        ],
      ),
    );
  }
}

class _CountryTextField extends ViewModelWidget<AddNewAdoptionViewModel> {
  const _CountryTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final text = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          focusNode: viewModel.countryFocusNode,
          label: text.country,
          hasError: viewModel.hasCountryError,
          isBorderPrimaryColor: true,
          textInputAction: TextInputAction.next,
          controller: viewModel.countryController,
          onEditingComplete: () => viewModel.cityFocusNode.requestFocus(),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^[a-zA-Zа-яА-Я\s-]+$'),
            ),
          ],
        ),
        if (viewModel.hasCountryError) ErrorText(text: text.countryError),
        const SizedBox(height: _commonPadding),
      ],
    );
  }
}

class _CityTextField extends ViewModelWidget<AddNewAdoptionViewModel> {
  const _CityTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final text = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: text.city,
          focusNode: viewModel.cityFocusNode,
          hasError: viewModel.hasCityError,
          isBorderPrimaryColor: true,
          textInputAction: TextInputAction.next,
          controller: viewModel.cityController,
          onEditingComplete: () =>
              viewModel.descriptionFocusNode.requestFocus(),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^[a-zA-Zа-яА-Я\s-]+$'),
            ),
          ],
        ),
        if (viewModel.hasCityError) ErrorText(text: text.cityError),
        const SizedBox(height: _commonPadding),
      ],
    );
  }
}

class _DescriptionTextField extends ViewModelWidget<AddNewAdoptionViewModel> {
  const _DescriptionTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final text = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          focusNode: viewModel.descriptionFocusNode,
          label: text.description,
          hasError: viewModel.hasDescriptionError,
          isBorderPrimaryColor: true,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: 4,
          controller: viewModel.descriptionController,
        ),
        if (viewModel.hasDescriptionError)
          ErrorText(text: text.descriptionError),
        const SizedBox(height: _commonPadding),
      ],
    );
  }
}

class _PublishButton extends ViewModelWidget<AddNewAdoptionViewModel> {
  const _PublishButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final text = AppLocalizations.of(context)!;

    return CustomButton(
      text: text.publish,
      onTap: () => viewModel.publishAdoption(),
      isLoading: viewModel.isLoading,
    );
  }
}
