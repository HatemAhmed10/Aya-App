import 'dart:convert';
import 'package:bus/business_logic/1Home_Cubit/Home_State.dart';
import 'package:bus/data/models/3AddPost_Model/Posts_Model.dart';
import 'package:bus/main.dart';
import 'package:bus/shared/components/components.dart';
import 'package:bus/shared/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(NewInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
///////////////////////////////////////////////////////////////////////
  /// post Data
  ///
  void AddPost({
    required String Title,
    required String SubTitle,
    required String Desc,
    required DateTime Date,
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
