import 'package:bus/presentation/screens/1New_Design/Page1_Screen.dart';
import 'package:bus/presentation/screens/3Login_Design/Login_Screen.dart';
import 'package:bus/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:bus/presentation/screens/0Splash_Screen/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  Widget widget;
  var uId = CacheHelper.getData(key: 'uId');

  if (uId == null) {
    widget = SocialLoginScreen();
  } else {
    widget = Page1_Screen();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(
        startWidget: startWidget,
      ),
    );
  }
}
