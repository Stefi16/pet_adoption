import 'package:pet_adoption/widgets/sorting_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

enum BottomSheetType { chooseGender }

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.chooseGender: (context, sheetRequest, completer) =>
        SortingSheet(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
