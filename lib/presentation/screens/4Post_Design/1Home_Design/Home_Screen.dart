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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: defaultContainer(
                      boxDecoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      Widget: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                cubit.ListOfPosts[index].title.toString(),
                                textAlign: TextAlign.right,
                              ),
                              subtitle: Text(
                                cubit.ListOfPosts[index].subTitle.toString(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: TextButton(
                                onPressed: () {
                                  cubit.change_read_more();
                                  print(cubit.read_more.toString());
                                },
                                child: cubit.read_more
                                    ? Container(
                                        child: TextButton(
                                          onPressed: () {
                                            cubit.change_read_more();
                                          },
                                          child: Text(
                                            cubit.ListOfPosts[index].desc
                                                .toString(),
                                            maxLines: cubit.read_more ? 500 : 1,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                  onPressed: () {
                                                    cubit.change_read_more();
                                                  },
                                                  child: Text(
                                                    "المزيد",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey),
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                cubit.ListOfPosts[index].desc
                                                    .toString(),
                                                maxLines:
                                                    cubit.read_more ? 500 : 1,
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                            defaultSizedBox(Height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: defaultContainer(
                                    Widget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "12",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cubit.change_love_color();
                                            },
                                            color: cubit.love,
                                            icon: Icon(Icons.favorite)),
                                      ],
                                    ),
                                  ),
                                ),
                                defaultSizedBox(Width: 10),
                                Expanded(
                                  child: defaultContainer(
                                    Widget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "34",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.comment)),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
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
