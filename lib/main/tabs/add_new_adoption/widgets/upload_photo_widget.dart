import 'package:flutter/material.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/add_new_adoption_viewmodel.dart';
import 'package:stacked/stacked.dart';

class UploadPhotoWidget extends ViewModelWidget<AddNewAdoptionViewModel> {
  const UploadPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final photoSize = screenWidth * 0.3;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => viewModel.uploadPhoto(context),
      child: Container(
        width: photoSize,
        height: photoSize,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(photoSize),
          border: Border.all(
            color: theme.primaryColor.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: viewModel.chosenPhoto == null
            ? Icon(
                Icons.pets_rounded,
                size: screenWidth * 0.16,
                color: theme.iconTheme.color!.withOpacity(0.3),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(photoSize),
                child: Image.memory(
                  viewModel.chosenPhoto!,
                  fit: BoxFit.fill,
                ),
              ),
      ),
    );
  }
}
