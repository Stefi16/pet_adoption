import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/add_new_adoption_viewmodel.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/error_text.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/calculations.dart';
import '../../../../utils/common_logic.dart';
import 'choose_tpye_text.dart';

class ChooseAgeWidget extends ViewModelWidget<AddNewAdoptionViewModel> {
  const ChooseAgeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            visualDensity: getMinimumDensity(),
          ),
          onPressed: () async {
            Map<String, int?>? result = {};

            if (Platform.isIOS) {
              result = await _showCupertinoModalPicker(context);
            } else {
              final dialogResult = await viewModel.showAgeDialog();

              result = dialogResult?.data as Map<String, int?>?;
            }

            if (result == null && viewModel.ageResult != null) {
              return;
            }

            viewModel.setYearsAndMonths(result);
          },
          child: Row(
            children: [
              ChooseTypeText(
                text: viewModel.ageResult.getAnimalAgeText(true),
                noDots: true,
                hasError: viewModel.hasAgeError,
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.edit,
                size: 18,
                color: viewModel.hasAgeError
                    ? theme.colorScheme.error
                    : theme.primaryColor,
              ),
            ],
          ),
        ),
        if (viewModel.hasAgeError)
          ErrorText(
            text: text.ageError,
            noPadding: true,
          ),
      ],
    );
  }
}

Future<Map<String, int?>?> _showCupertinoModalPicker(
  BuildContext context,
) async {
  int? chosenMonths;
  int? chosenYears;

  return await showModalBottomSheet<Map<String, int?>?>(
    context: context,
    builder: (newContext) {
      final months = positiveIntegers.take(13);
      final years = positiveIntegers.take(31);
      final text = AppLocalizations.of(context)!;

      final theme = Theme.of(context);

      return Container(
        color: theme.scaffoldBackgroundColor,
        height: 215,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: CupertinoPicker(
                    magnification: 1.1,
                    squeeze: 1.2,
                    itemExtent: 20,
                    onSelectedItemChanged: (item) {
                      chosenYears = item;
                    },
                    children: List.generate(
                      years.length,
                      (index) {
                        final String currentText =
                            '${years.elementAt(index)} ${text.years[0]}.';

                        return Center(
                          child: Text(currentText),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: CupertinoPicker(
                    magnification: 1.1,
                    squeeze: 1.2,
                    itemExtent: 20,
                    onSelectedItemChanged: (item) {
                      chosenMonths = item;
                    },
                    children: List.generate(
                      months.length,
                      (index) {
                        final String currentText =
                            '${months.elementAt(index)} ${text.months[0]}.';

                        return Center(
                          child: Text(currentText),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  if (chosenYears == null && chosenMonths == null) {
                    return;
                  }

                  Navigator.pop(
                    context,
                    {
                      keyYears: chosenYears,
                      keyMonths: chosenMonths,
                    },
                  );
                },
                child: ChooseTypeText(
                  text: text.done,
                  noDots: true,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
