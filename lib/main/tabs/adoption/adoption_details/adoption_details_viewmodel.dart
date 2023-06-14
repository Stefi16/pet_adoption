import 'package:pet_adoption/app/app.router.dart';
import 'package:pet_adoption/main/tabs/adoption/base_adoption_viewmodel.dart';
import 'package:pet_adoption/models/animal_adoption.dart';
import 'package:pet_adoption/models/app_user.dart';
import 'package:pet_adoption/services/database_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/app.locator.dart';
import '../../../../utils/setup_dialog.dart';

class AdoptionDetailsViewModel extends BaseAdoptionViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final DialogService _dialogService = locator<DialogService>();

  late final AppUser _currentUser;
  late final AppUser _userPostedAdoption;
  late AnimalAdoption _adoption;
  AnimalAdoption getAdoption() => _adoption;

  AdoptionDetailsViewModel(AnimalAdoption adoption) {
    _adoption = adoption;
  }

  @override
  void init() {
    super.init();
    _currentUser = _databaseService.getCurrentUser();
    _userPostedAdoption = _databaseService.getUserById(_adoption.userId);
  }

  void goBack() {
    _navigationService.back();
  }

  String getPhotoUrl() {
    final url = _userPostedAdoption.picture ?? '';

    return url;
  }

  String getUsername() => _userPostedAdoption.username ?? '';
  String getEmail() => _userPostedAdoption.email;

  bool shouldShowPhoneButton() {
    final isPhoneNumberPresent = (_userPostedAdoption.phone ?? '').isNotEmpty;
    final hasTheUserPostedTheAdoption = hasTheSameUserPostedTheAdoption();

    return isPhoneNumberPresent && !hasTheUserPostedTheAdoption;
  }

  void onPhoneNumberTap() {
    final phone = 'tel${_userPostedAdoption.phone}';
    final url = Uri(scheme: phone);

    canLaunchUrl(url).then(
      (canLaunch) async {
        if (canLaunch) {
          await launchUrl(url);
        } else {
          final text = AppLocalizations.of(
            StackedService.navigatorKey!.currentContext!,
          )!;

          _snackbarService.showSnackbar(
            title: text.error,
            message: text.errorWhileLaunchingPhoneNumber,
          );
        }
      },
    );
  }

  void openDescriptionPopUp({
    required String title,
  }) {
    _dialogService.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.basic,
      title: title,
      description: _adoption.description,
    );
  }

  bool hasTheSameUserPostedTheAdoption() {
    return _adoption.userId == _currentUser.id;
  }

  void deleteAdoption() async {
    final success = await _databaseService.deleteAdoption(_adoption.adoptionId);

    if (success) {
      _navigationService.back();
    }
  }

  void goToChatScreen() {
    _navigationService.navigateTo(
      Routes.chatView,
      arguments: ChatViewArguments(
        animalAdoption: _adoption,
        currentUser: _currentUser,
        userPostedAdoption: _userPostedAdoption,
      ),
    );
  }

  @override
  void refreshChildren() {
    final refreshedAdoption = allAdoptions
        .where((adoption) => adoption.adoptionId == _adoption.adoptionId);

    if (refreshedAdoption.isEmpty) {
      _navigationService.back();
    } else {
      _adoption = refreshedAdoption.first;
      notifyListeners();
    }
  }
}
