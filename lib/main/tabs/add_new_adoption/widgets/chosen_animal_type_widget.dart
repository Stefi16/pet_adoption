import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/enums.dart';
import '../add_new_adoption_viewmodel.dart';
import 'choose_tpye_text.dart';

class ChosenAnimalTypeWidget extends ViewModelWidget<AddNewAdoptionViewModel> {
  const ChosenAnimalTypeWidget({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    const animalTypes = AnimalType.values;

    return Row(
      children: [
        ChooseTypeText(
          text: text.animalType,
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: theme.primaryColor,
            ),
          ),
          child: DropdownButton<AnimalType>(
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            value: viewModel.chosenType,
            underline: const SizedBox.shrink(),
            items: List.generate(
              animalTypes.length,
              (index) {
                final currentType = animalTypes.elementAt(index);
                return DropdownMenuItem(
                  value: currentType,
                  child: Text(
                    viewModel.getAnimalTypeName(currentType),
                    style: TextStyle(
                      color: theme.iconTheme.color,
                    ),
                  ),
                );
              },
            ),
            onChanged: (type) {
              viewModel.chooseType(type);
            },
          ),
        ),
      ],
    );
  }
}
