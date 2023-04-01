import 'package:pet_adoption/widgets/dialogs/basic_dialog.dart';
import 'package:pet_adoption/widgets/dialogs/choose_age_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../widgets/dialogs/add_profile_details_dialog.dart';

enum DialogType { changeUsername, chooseAge, changePhone, basic }

void setupDialogUi() {
  final DialogService dialogService = locator<DialogService>();

  final builders = {
    DialogType.changeUsername: (context, sheetRequest, completer) =>
        AddProfileDetailsDialog(request: sheetRequest, completer: completer),
    DialogType.chooseAge: (context, sheetRequest, completer) =>
        ChooseAgeDialog(request: sheetRequest, completer: completer),
    DialogType.changePhone: (context, sheetRequest, completer) =>
        AddProfileDetailsDialog(
          request: sheetRequest,
          completer: completer,
          isPhoneDialog: true,
        ),
    DialogType.basic: (context, sheetRequest, completer) =>
        BasicDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
