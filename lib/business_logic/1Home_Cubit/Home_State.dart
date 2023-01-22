abstract class HomeStates {}

class NewInitialState extends HomeStates {}

class AppChangeModeState extends HomeStates {}

class AddPostSuccessState extends HomeStates {}

class AddPostErrorState extends HomeStates {
  final String error;

  AddPostErrorState(this.error);
}

class GetPostsSuccessState extends HomeStates {}

class AppChangeReadMoreState extends HomeStates {}

class AppChangeLoveColorState extends HomeStates {}
