import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SortingGenderTypes {
  all,
  male,
  female,
}

class SortingSheet extends StatefulWidget {
  const SortingSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final SheetRequest request;
  final Function(SheetResponse) completer;

  @override
  State<SortingSheet> createState() => _SortingSheetState();
}

class _SortingSheetState extends State<SortingSheet> {
  SortingGenderTypes? chosenType;

  void _chooseSortType(SortingGenderTypes type) {
    setState(
      () {
        chosenType = type;
      },
    );

    widget.completer(
      SheetResponse(
        confirmed: true,
        data: chosenType,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    chosenType = widget.request.data as SortingGenderTypes?;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: theme.scaffoldBackgroundColor,
      ),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    '${text.chooseGender}:',
                    style: TextStyle(
                      fontSize: 20,
                      color: theme.iconTheme.color,
                    ),
                  ),
                ),
                ...List.generate(
                  SortingGenderTypes.values.length,
                  (index) {
                    final currentType =
                        SortingGenderTypes.values.elementAt(index);
                    return Column(
                      children: [
                        Divider(
                          height: 2,
                          thickness: 2,
                          color: theme.iconTheme.color!.withOpacity(0.05),
                        ),
                        InkWell(
                          onTap: () => _chooseSortType(currentType),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaIcon(
                                  currentType.getAnimalGenderIcon(),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  currentType.getSortingAnimalGenderName(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: theme.iconTheme.color,
                                  ),
                                ),
                                if (currentType == chosenType) ...[
                                  const Spacer(),
                                  const Icon(Icons.check),
                                ]
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => widget.completer(
                    SheetResponse(
                      confirmed: false,
                    ),
                  ),
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
