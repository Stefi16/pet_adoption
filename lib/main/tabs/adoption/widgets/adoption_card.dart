import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/main/tabs/adoption/widgets/favourite_button_widget.dart';
import 'package:pet_adoption/models/animal_adoption.dart';
import 'package:pet_adoption/utils/extensions.dart';

import '../../../../utils/enums.dart';

class AdoptionCard extends StatelessWidget {
  const AdoptionCard({
    Key? key,
    required this.onCardTap,
    required this.adoption,
    required this.isFavourite,
    required this.onFavouritesTap,
  }) : super(key: key);

  final VoidCallback onCardTap;
  final AnimalAdoption adoption;
  final bool isFavourite;
  final VoidCallback onFavouritesTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onCardTap,
      child: Container(
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
                  fit: BoxFit.cover,
                  errorWidget: (context, _, __) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: theme.primaryColor.withOpacity(0.5),
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
                  height: 56,
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            adoption.animalName,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: theme.iconTheme.color,
                            ),
                          ),
                          const SizedBox(width: 3),
                          if (adoption.genderType == AnimalGender.male)
                            const Icon(
                              Icons.male,
                              color: Colors.blue,
                              size: 20,
                            )
                          else
                            const Icon(
                              Icons.female,
                              color: Colors.pinkAccent,
                              size: 20,
                            )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                            ),
                            child: Text(
                              adoption.animalAge.getAnimalAgeText(),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: theme.iconTheme.color,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: FavouriteButtonWidget(
                              isFavourite: isFavourite,
                              onTap: onFavouritesTap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
