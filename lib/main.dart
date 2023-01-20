import 'package:bus/business_logic/1Home_Cubit/Home_Cubit.dart';
import 'package:bus/business_logic/1Home_Cubit/Home_State.dart';
import 'package:bus/presentation/screens/1Home_Design/Home_Screen.dart';
import 'package:bus/presentation/screens/3Login_Design/Login_Screen.dart';
import 'package:bus/shared/network/local/cache_helper.dart';
import 'package:bus/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:bus/presentation/screens/0Splash_Screen/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  Widget widget;
  var uId = CacheHelper.getData(key: 'uId');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  if (isDark == null) {
    isDark = false;
  }

  print(isDark.toString());

  if (uId == null) {
    widget = SocialLoginScreen();
  } else {
    widget = Home_Screen();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  bool isDark;

  MyApp({
    required this.startWidget,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        // cubit.isDark = isDark;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          // home: SplashView(
          //   startWidget: startWidget,
          // ),
          home: Home_Screen(),
        );
      }),
    );
  }
}
