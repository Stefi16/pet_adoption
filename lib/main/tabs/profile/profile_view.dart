import 'package:flutter/material.dart';
import 'package:pet_adoption/main/tabs/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ViewModelBuilder<ProfileViewModel>.nonReactive(
          viewModelBuilder: () => ProfileViewModel(),
          onViewModelReady: (vm) => vm.init(),
          builder: (context, viewModel, child) {
            final username = viewModel.getCurrentUserUsername();
            final email = viewModel.getCurrentUserEmail();
            final bool isUsernamePresent = username.isNotEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Акаунт',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => viewModel.onUserCardTap(),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Text(
                              email[0].toUpperCase(),
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            children: [
                              if (isUsernamePresent) ...[
                                Text(
                                  username,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: theme.textTheme.bodyLarge!.color!,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5),
                              ],
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: isUsernamePresent ? 15 : 20,
                                  color: isUsernamePresent
                                      ? theme.textTheme.bodyLarge!.color!
                                          .withOpacity(0.7)
                                      : theme.textTheme.bodyLarge!.color!,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.primaryColorDark,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: theme.primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
