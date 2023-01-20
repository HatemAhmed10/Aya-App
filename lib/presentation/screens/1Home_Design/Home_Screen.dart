import 'package:bus/business_logic/1Home_Cubit/Home_Cubit.dart';
import 'package:bus/business_logic/1Home_Cubit/Home_State.dart';
import 'package:bus/main.dart';
import 'package:bus/presentation/screens/3Login_Design/Login_Screen.dart';
import 'package:bus/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus/shared/components/components.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    bool dark = false;
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          if (cubit.isDark != null) {
            dark = cubit.isDark!;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              actions: [
                Switch(
                    value: dark,
                    onChanged: (val) {
                      print(val.toString());
                      cubit.changeAppMode(fromShared: val);
                      main();
                    }),
                IconButton(
                    onPressed: () {
                      CacheHelper.removeData(
                        key: 'uId',
                      ).then((value) {
                        navigateAndFinish(
                          context,
                          SocialLoginScreen(),
                        );
                      });
                    },
                    icon: Icon(Icons.logout)),
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Text("Log Out"),
                  defaultSizedBox(Height: 20),
                  defaultButton2(
                      function: (() {
                        CacheHelper.removeData(
                          key: 'uId',
                        ).then((value) {
                          navigateAndFinish(
                            context,
                            SocialLoginScreen(),
                          );
                        });
                      }),
                      widget: defaultText(text: "Log Out"),
                      colorButton: Colors.blue),
                  defaultSizedBox(Height: 30),
                  defaultButton2(
                      function: (() {}),
                      widget: defaultText(text: " Advanced Design Screen1"),
                      colorButton: Colors.blue),
                  defaultText(text: cubit.isDark.toString()),
                  defaultButton2(
                      function: (() {
                        cubit.changeAppMode(fromShared: true);
                      }),
                      widget: defaultText(text: "IsDark")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
