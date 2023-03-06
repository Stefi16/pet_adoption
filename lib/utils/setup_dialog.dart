import 'package:pet_adoption/widgets/dialogs/username_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

enum DialogType { changeUsername }

void setupDialogUi() {
  final DialogService dialogService = locator<DialogService>();

  final builders = {
    DialogType.changeUsername: (context, sheetRequest, completer) =>
        UsernameDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
