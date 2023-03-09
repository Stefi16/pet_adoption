import 'package:pet_adoption/widgets/dialogs/choose_age_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../widgets/dialogs/add_profile_details_dialog.dart';

enum DialogType { changeUsername, chooseAge, changePhone }

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
  };

  dialogService.registerCustomDialogBuilders(builders);
}
