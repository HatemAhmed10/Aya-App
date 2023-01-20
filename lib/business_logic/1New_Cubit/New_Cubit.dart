import 'dart:convert';
import 'package:bus/business_logic/1New_Cubit/New_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCubit extends Cubit<NewStates> {
  NewCubit() : super(NewInitialState());

  static NewCubit get(context) => BlocProvider.of(context);
}
