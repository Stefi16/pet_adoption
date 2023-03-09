import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/add_new_adoption_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/calculations.dart';
import 'choose_tpye_text.dart';

class ChooseAgeWidget extends ViewModelWidget<AddNewAdoptionViewModel> {
  const ChooseAgeWidget({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Row(
      children: [
        ChooseTypeText(
          text: text.age,
        ),
        TextButton(
          onPressed: () async {
            Map<String, int?>? result = {};

            if (!Platform.isIOS) {
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                viewModel.getProperText(text),
                style: TextStyle(
                  color: theme.iconTheme.color!,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.edit,
                size: 18,
                color: theme.iconTheme.color!,
              ),
            ],
          ),
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
