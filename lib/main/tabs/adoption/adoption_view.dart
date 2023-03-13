import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/utils/enums.dart';
import 'package:pet_adoption/utils/extensions.dart';
import 'package:stacked/stacked.dart';

import 'adoption_viewmodel.dart';

class AdoptionView extends StatelessWidget {
  const AdoptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<AdoptionViewModel>.nonReactive(
      viewModelBuilder: () => AdoptionViewModel(),
      builder: (context, viewModel, child) {
        const animalTypes = AnimalType.values;

        return Container(
          color: theme.iconTheme.color!.withOpacity(0.05),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  itemCount: animalTypes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final currentType = animalTypes.elementAt(index);
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 5 : 0,
                        right: 5,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(
                            color: theme.primaryColor,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Image.asset(
                              currentType.getAnimalTypeImageName(),
                              color: theme.primaryColorDark,
                              width: 25,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              currentType.getAnimalTypeName(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: GridView.builder(
                    itemCount: viewModel.allAdoptions.length,
                    itemBuilder: (context, index) {
                      final adoption = viewModel.allAdoptions.elementAt(index);

                      return Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: theme.primaryColor,
                          ),
                        ),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: adoption.photoUrl ?? '',
                                  fit: BoxFit.fill,
                                  errorWidget: (context, _, __) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            theme.primaryColor.withOpacity(0.5),
                                        border: Border.all(
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.pets_rounded,
                                        size: 100,
                                        color: theme.primaryColorDark,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(20),
                                    ),
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                  height: 65,
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        adoption.animalName,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: theme.iconTheme.color,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: theme.primaryColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 5,
                                          ),
                                          child: Text(
                                            '${adoption.genderType.getAnimalGenderName()}, ${adoption.animalAge.getAnimalAgeText().removeWhiteSpaces()}',
                                            style: TextStyle(
                                              color: theme.iconTheme.color,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
