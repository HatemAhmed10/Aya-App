import 'dart:convert';
import 'dart:ui';
import 'package:bus/business_logic/1Home_Cubit/Home_State.dart';
import 'package:bus/data/models/3AddPost_Model/Posts_Model.dart';
import 'package:bus/main.dart';
import 'package:bus/shared/components/components.dart';
import 'package:bus/shared/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(NewInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  Color love = Colors.black;
  void change_love_color() {
    if (love == Colors.black) {
      love = Colors.red;
      emit(AppChangeLoveColorState());
    } else {
      love = Colors.black;
      emit(AppChangeLoveColorState());
    }
  }

  bool read_more = false;
  void change_read_more() {
    if (read_more == false) {
      read_more = true;
      emit(AppChangeReadMoreState());
    } else {
      read_more = false;
      emit(AppChangeReadMoreState());
    }
  }

/////////////////////////////////////////////////////////////////////////
  ///  Get Data Of Bus
  List<PostModel> ListOfPosts = [];
  void getPosts() {
    print("Dad66");
    FirebaseFirestore.instance
        .collection('DataBase')
        .doc("Table")
        .collection('Posts')
        // .where("dateTime", isEqualTo: DataTime)
        // .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      ListOfPosts = [];
      event.docs.forEach((element) {
        ListOfPosts.add(PostModel.fromJson(element.data()));
      });
      print(ListOfPosts[0].desc.toString());

      emit(GetPostsSuccessState());
    });
  }

///////////////////////////////////////////////////////////////////////
  /// post Data
  ///
  void AddPost({
    required String Title,
    required String SubTitle,
    required String Desc,
    required Timestamp Date,
  }) {
    var FId = FirebaseFirestore.instance
        .collection('DataBase')
        .doc('Table')
        .collection('Posts')
        .doc();

    PostModel model = PostModel(
      Id: FId.id,
      title: Title,
      subTitle: SubTitle,
      desc: Desc,
      date: Date,
      imageUrl: "سيشسيشسيشس",
    );

    FirebaseFirestore.instance
        .collection('DataBase')
        .doc("Table")
        .collection("Posts")
        .doc(FId.id)
        .set(model.toMap())
        .then((value) {
      emit(AddPostSuccessState());
    }).catchError((error) {
      emit(AddPostErrorState(error));
    });
  }

  ////////////////////////////////////////////////////////////////

//------------------------------------------------------------
  bool? isDark = CacheHelper.getData(key: 'isDark');
  void changeAppMode({required bool fromShared}) {
    if (isDark == null) {
      isDark = false;
    }
    if (fromShared == true) {
      isDark = true;
      CacheHelper.putBoolean(key: 'isDark', value: isDark!).then((value) {
        emit(AppChangeModeState());
      });
    } else {
      isDark = false;
      CacheHelper.putBoolean(key: 'isDark', value: isDark!).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
