import 'package:flutter/material.dart';
import 'package:pet_adoption/main/tabs/add_new_adoption/add_new_adoption_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UploadPhotoWidget extends ViewModelWidget<AddNewAdoptionViewModel> {
  const UploadPhotoWidget({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, AddNewAdoptionViewModel viewModel) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final text = AppLocalizations.of(context)!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => viewModel.uploadPhoto(context),
      child: Container(
        width: screenWidth * 0.3,
        height: screenWidth * 0.3,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.iconTheme.color!.withOpacity(0.3),
          ),
        ),
        child: true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets_rounded,
                    size: screenWidth * 0.16,
                    color: theme.iconTheme.color!.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      text.uploadPhoto,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.iconTheme.color!.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                  fit: BoxFit.fill,
                ),
              ),
      ),
    );
  }
}
