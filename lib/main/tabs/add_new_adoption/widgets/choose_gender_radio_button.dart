import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/enums.dart';
import '../add_new_adoption_viewmodel.dart';
import 'choose_tpye_text.dart';
import 'custom_radio_button.dart';

class ChosenGenderRadioButton extends ViewModelWidget<AddNewAdoptionViewModel> {
  const ChosenGenderRadioButton({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    final bool? isFemale = viewModel.chosenGender?.isFemale();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomRadioButton<AnimalGender>(
          type: AnimalGender.female,
          onChanged: (newValue) => viewModel.chooseGender(newValue),
          text: text.female,
          color: isFemale != true ? theme.iconTheme.color! : theme.primaryColor,
          chosenType: viewModel.chosenGender,
        ),
        CustomRadioButton<AnimalGender>(
          type: AnimalGender.male,
          onChanged: (newValue) => viewModel.chooseGender(newValue),
          text: text.male,
          color:
              isFemale != false ? theme.iconTheme.color! : theme.primaryColor,
          chosenType: viewModel.chosenGender,
        ),
      ],
    );
  }
}
