import 'package:bus/business_logic/1New_Cubit/New_Cubit.dart';
import 'package:bus/business_logic/1New_Cubit/New_State.dart';
import 'package:bus/presentation/screens/0Splash_Screen/splash_view.dart';
import 'package:bus/presentation/screens/3Login_Design/Login_Screen.dart';
import 'package:bus/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus/shared/components/components.dart';
import 'package:bus/shared/styles/assets_manager.dart';
import 'package:bus/shared/styles/colors.dart';

class Page1_Screen extends StatefulWidget {
  const Page1_Screen({super.key});

  @override
  State<Page1_Screen> createState() => _Page1_ScreenState();
}

class _Page1_ScreenState extends State<Page1_Screen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewCubit(),
      child: BlocBuilder<NewCubit, NewStates>(
        builder: (context, state) {
          NewCubit cubit = NewCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text("Start Page in Project"),
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
                      widget: defaultText(text: " Fundamentals Design Screen1"),
                      colorButton: Colors.blue),
                  defaultSizedBox(Height: 30),
                  defaultButton2(
                      function: (() {}),
                      widget: defaultText(text: " Advanced Design Screen1"),
                      colorButton: Colors.blue)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
