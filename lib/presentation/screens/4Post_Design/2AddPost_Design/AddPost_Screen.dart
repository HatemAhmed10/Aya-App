import 'package:bus/business_logic/1Home_Cubit/Home_Cubit.dart';
import 'package:bus/business_logic/1Home_Cubit/Home_State.dart';
import 'package:bus/presentation/screens/4Post_Design/1Home_Design/Home_Screen.dart';
import 'package:bus/shared/components/components.dart';
import 'package:bus/shared/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddPost_Screen extends StatefulWidget {
  const AddPost_Screen({super.key});

  @override
  State<AddPost_Screen> createState() => _AddPost_ScreenState();
}

class _AddPost_ScreenState extends State<AddPost_Screen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController PostTitle = TextEditingController();
    TextEditingController PostSubTitle = TextEditingController();
    TextEditingController Postdesc = TextEditingController();
    TextEditingController Postdate = TextEditingController();

    DateTime now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy');
    String actualDate = formatterDate.format(now);
    Postdate.text = actualDate.toString();
    Timestamp nowDate = Timestamp.now();

    return BlocProvider(
        create: (context) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: defaultFormField(
                        controller: PostTitle,
                        type: TextInputType.text,
                        validate: () {},
                        label: "العنوان",
                        prefix: Icons.title),
                  ),
                ),
                defaultSizedBox(Height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: defaultFormField(
                        controller: PostSubTitle,
                        type: TextInputType.text,
                        validate: () {},
                        label: "العنوان الاكبر",
                        prefix: Icons.title),
                  ),
                ),
                defaultSizedBox(Height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: defaultFormField(
                        controller: Postdesc,
                        type: TextInputType.text,
                        validate: () {},
                        label: "الوصف",
                        prefix: Icons.title),
                  ),
                ),
                defaultSizedBox(Height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: defaultFormField(
                        controller: Postdate,
                        type: TextInputType.datetime,
                        validate: () {},
                        label: "التاريخ",
                        prefix: Icons.dataset),
                  ),
                ),
                Expanded(
                  child: defaultButton2(
                      function: () {
                        cubit.AddPost(
                            Title: PostTitle.text,
                            SubTitle: PostSubTitle.text,
                            Desc: Postdesc.text,
                            Date: nowDate);
                        navigateAndFinish(context, Home_Screen());
                      },
                      colorButton: ColorManager.primary,
                      colorText: Colors.red,
                      widget: defaultText(text: "اضافه بوست ")),
                ),
              ],
            ),
          );
        }));
  }
}
