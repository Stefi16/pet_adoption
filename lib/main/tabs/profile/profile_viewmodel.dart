import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pet_adoption/services/auth_service.dart';
import 'package:pet_adoption/services/image_upload_service.dart';
import 'package:pet_adoption/utils/setup_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/app_user.dart';
import '../../../services/database_service.dart';
import '../../../services/theme_switcher_service.dart';

class ProfileViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final ThemeSwitcherService _themeSwitcherService =
      locator<ThemeSwitcherService>();
  final ImageUploaderService _imageUploaderService =
      locator<ImageUploaderService>();

  late final AppUser _currentUser;

  void init() {
    _currentUser = _databaseService.getCurrentUser();
  }

  String getCurrentUserEmail() => _currentUser.email;

  String getCurrentUserUsername() => _currentUser.username ?? '';

  String getCurrentUserPhone() => _currentUser.phone ?? '';

  String getPhotoUrl() {
    return _currentUser.picture ?? '';
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set _setIsLoading(bool isLoading) {
    if (_isLoading != isLoading) {
      _isLoading = isLoading;
      notifyListeners();
    }
  }

  void uploadPhoto(BuildContext context) async {
    final ImageUploadData result =
        await _imageUploaderService.showImagePickerModal(context);

    if (result.imageBytes.isEmpty || result.imageName.isEmpty) {
      return;
    }

    final compressedImage = await _imageUploaderService.compressBytes(
      result.imageBytes,
    );

    final String imageUrl = await _databaseService.uploadImage(
      compressedImage,
      _currentUser.id,
    );

    _currentUser.picture = imageUrl;
    await _databaseService.addUser(_currentUser);
    notifyListeners();
  }

  void editUsername() async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.changeUsername,
      barrierDismissible: true,
    );

    if (result?.confirmed != true) {
      return;
    }

    final String username = result!.data as String;
    _currentUser.username = username;
    await _databaseService.addUser(_currentUser);
    notifyListeners();
  }

  void toggleMode(bool isDarkMode) async {
    await _themeSwitcherService.setDarkTheme(!isDarkMode);
  }

  bool isDarkMode(BuildContext context) =>
      _themeSwitcherService.getIsDarkMode(context);

  void goToThemesScreen() => _navigationService.navigateTo(Routes.themesView);

  void logout() async {
    if (_isLoading) {
      return;
    }

    _setIsLoading = true;
    final success = await _authService.signOut();

    if (success) {
      await _themeSwitcherService.resetTheme();
      _navigationService.clearStackAndShow(Routes.loginView);
    }

    _setIsLoading = false;
  }

  String getDateJoined() {
    final joinedDate = _currentUser.dateJoined;
    return DateFormat('dd.MM.yyyy').format(joinedDate);
  }

  void editPhone() async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.changePhone,
      barrierDismissible: true,
    );

    if (result?.confirmed != true) {
      return;
    }

    final String phone = result!.data as String;
    _currentUser.phone = phone;
    await _databaseService.addUser(_currentUser);
    notifyListeners();
  }
}
