import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/add_new_adoption_viewmodel.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/widgets/choose_tpye_text.dart';
import 'package:pet_adoption/widgets/dialogs/widgets/dialog_buttons_row.dart';
import 'package:pet_adoption/widgets/universal_padding.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../utils/calculations.dart';

class ChooseAgeDialog extends StatefulWidget {
  const ChooseAgeDialog({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  State<ChooseAgeDialog> createState() => _ChooseAgeDialogState();
}

class _ChooseAgeDialogState extends State<ChooseAgeDialog> {
  int? chosenMonths;
  int? chosenYears;

  @override
  Widget build(BuildContext context) {
    final months = positiveIntegers.take(13);
    final years = positiveIntegers.take(31);
    final text = AppLocalizations.of(context)!;

    return Dialog(
      child: UniversalPadding(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChooseTypeText(text: text.chooseAge),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DropDownButton(
                  chosenValue: chosenYears,
                  values: years.toList(),
                  firstLetterOfAge: text.years[0],
                  onChanged: (newItem) {
                    if (newItem != null) {
                      setState(
                        () {
                          chosenYears = newItem;
                        },
                      );
                    }
                  },
                ),
                const SizedBox(width: 20),
                _DropDownButton(
                  chosenValue: chosenMonths,
                  values: months.toList(),
                  firstLetterOfAge: text.months[0],
                  onChanged: (newItem) {
                    if (newItem != null) {
                      setState(() {
                        chosenMonths = newItem;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            DialogButtonsRow(
              onConfirm: () {
                if (chosenMonths == null || chosenYears == null) {
                  return;
                }

                widget.completer(
                  DialogResponse(
                    confirmed: true,
                    data: {
                      keyYears: chosenYears,
                      keyMonths: chosenMonths,
                    },
                  ),
                );
              },
              onCancel: () => widget.completer(
                DialogResponse(
                  confirmed: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropDownButton extends StatelessWidget {
  const _DropDownButton({
    Key? key,
    required this.chosenValue,
    required this.values,
    required this.firstLetterOfAge,
    required this.onChanged,
  }) : super(key: key);

  final int? chosenValue;
  final List<int> values;
  final String firstLetterOfAge;
  final Function(int? value) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: 72,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.primaryColor,
          width: 2,
        ),
      ),
      child: DropdownButton<int>(
        icon: const RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        ),
        underline: const SizedBox.shrink(),
        value: chosenValue,
        menuMaxHeight: height * 0.4,
        items: List.generate(
          values.length,
          (index) {
            final String currentText =
                '${values.elementAt(index)} $firstLetterOfAge.';

            return DropdownMenuItem(
              value: values.elementAt(index),
              child: Center(
                child: Text(
                  currentText,
                  style: TextStyle(
                    color: theme.iconTheme.color,
                  ),
                ),
              ),
            );
          },
        ),
        onChanged: onChanged,
      ),
    );
  }
}
