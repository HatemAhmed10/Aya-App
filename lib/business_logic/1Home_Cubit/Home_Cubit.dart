import 'dart:convert';
import 'package:bus/business_logic/1Home_Cubit/Home_State.dart';
import 'package:bus/main.dart';
import 'package:bus/shared/components/components.dart';
import 'package:bus/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(NewInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  bool? isDark = CacheHelper.getData(key: 'isDark');

  // bool isDark = false;

  void changeAppMode({required bool fromShared}) {
    if (isDark == null) {
      isDark = false;
    }
    if (fromShared == true) {
      isDark = true;
      CacheHelper.putBoolean(key: 'isDark', value: isDark!).then((value) {
        // FlutterRestart.restartApp();

        emit(AppChangeModeState());
      });
    } else {
      isDark = false;
      CacheHelper.putBoolean(key: 'isDark', value: isDark!).then((value) {
        // FlutterRestart.restartApp();
        emit(AppChangeModeState());
      });
    }
  }
}
