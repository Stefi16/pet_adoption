import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/error_text.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/enums.dart';
import '../add_new_adoption_viewmodel.dart';
import 'choose_tpye_text.dart';

class ChosenAnimalTypeWidget extends ViewModelWidget<AddNewAdoptionViewModel> {
  const ChosenAnimalTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    const animalTypes = AnimalType.values;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            ChooseTypeText(
              text: text.animalType,
              hasError: viewModel.hasAnimalTypeError,
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: viewModel.hasAnimalTypeError
                      ? theme.colorScheme.error
                      : theme.primaryColor,
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
                      alignment: Alignment.center,
                      value: currentType,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            currentType.getAnimalTypeImageName(),
                            width: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            currentType.getAnimalTypeName(),
                            style: TextStyle(
                              color: theme.iconTheme.color,
                            ),
                          ),
                        ],
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
        ),
        if (viewModel.hasAnimalTypeError)
          ErrorText(
            text: text.animalTypeError,
            noPadding: true,
          ),
      ],
    );
  }
}
