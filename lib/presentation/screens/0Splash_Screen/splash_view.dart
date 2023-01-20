import 'dart:async';
import 'package:bus/presentation/screens/2Register_Design/RegisterScreen.dart';
import 'package:bus/presentation/screens/3Login_Design/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:bus/presentation/screens/1New_Design/Page1_Screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/assets_manager.dart';
import '../../../shared/styles/colors.dart';

class SplashView extends StatefulWidget {
  Widget startWidget;

  SplashView({
    required this.startWidget,
  });

  // const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState(startWidget: startWidget);
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  Widget? startWidget;

  _SplashViewState({
    required this.startWidget,
  });

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    navigateAndFinish(context, startWidget);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
