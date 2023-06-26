import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_adoption/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: ViewModelBuilder<SplashViewModel>.nonReactive(
        viewModelBuilder: () => SplashViewModel(),
        onViewModelReady: (vm) => vm.init(),
        builder: (context, viewModel, child) => Center(
          child: SizedBox(
            height: 300,
            child: Lottie.asset('assets/animations/loading_dog.json'),
          ),
        ),
      ),
    );
  }
}
