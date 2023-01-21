import 'package:bus/business_logic/1Home_Cubit/Home_Cubit.dart';
import 'package:bus/business_logic/1Home_Cubit/Home_State.dart';
import 'package:bus/main.dart';
import 'package:bus/presentation/screens/3Login_Design/Login_Screen.dart';
import 'package:bus/presentation/screens/4Post_Design/2AddPost_Design/AddPost_Screen.dart';
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
      create: (context) => HomeCubit()..getPosts(),
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
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text(cubit.ListOfPosts[index].title.toString());
              },
              itemCount: cubit.ListOfPosts.length,
            )),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigateTo(context, AddPost_Screen());
                },
                child: Icon(Icons.add)),
          );
        },
      ),
    );
  }
}
