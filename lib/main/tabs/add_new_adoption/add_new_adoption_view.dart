import 'package:flutter/material.dart';
import 'package:pet_adoption/authentication/widgets/custom_textfield.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/choose_age_wheel.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/choose_gender_radio_button.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/chosen_animal_type_widget.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/upload_photo_widget.dart';
import 'package:pet_adoption/widgets/custom_button.dart';
import 'package:pet_adoption/widgets/keyboard_unfocuser.dart';
import 'package:pet_adoption/widgets/universal_padding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import 'add_new_adoption_viewmodel.dart';

class AddNewAdoptionView extends StatelessWidget {
  const AddNewAdoptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return KeyboardUnfocuser(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: UniversalPadding(
            child: ViewModelBuilder<AddNewAdoptionViewModel>.reactive(
              viewModelBuilder: () => AddNewAdoptionViewModel(),
              builder: (context, viewModel, child) => Column(
                children: [
                  const _Title(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const UploadPhotoWidget(),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: text.name,
                              hasError: viewModel.hasNameError,
                              isBorderPrimaryColor: true,
                              textInputAction: TextInputAction.done,
                              controller: viewModel.nameController,
                            ),
                            const SizedBox(height: 5),
                            // if(viewModel.hasNameError)
                            const ChosenGenderRadioButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const ChosenAnimalTypeWidget(),
                  const ChooseAgeWidget(),
                  CustomTextField(
                    label: '${text.breed} (${text.notMandatory.toLowerCase()})',
                    hasError: false,
                    isBorderPrimaryColor: true,
                    textInputAction: TextInputAction.next,
                    controller: viewModel.breedController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    label: text.country,
                    hasError: viewModel.hasCountryError,
                    isBorderPrimaryColor: true,
                    textInputAction: TextInputAction.next,
                    controller: viewModel.countryController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    label: text.city,
                    hasError: viewModel.hasCityError,
                    isBorderPrimaryColor: true,
                    textInputAction: TextInputAction.next,
                    controller: viewModel.cityController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    label: text.description,
                    hasError: viewModel.hasDescriptionError,
                    isBorderPrimaryColor: true,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 4,
                    controller: viewModel.descriptionController,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: text.publish,
                    onTap: () => viewModel.publishAdoption(),
                    isLoading: false,
                  )
                ],
              ),
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

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(
        color: theme.colorScheme.error,
        fontSize: 11,
      ),
    );
  }
}
