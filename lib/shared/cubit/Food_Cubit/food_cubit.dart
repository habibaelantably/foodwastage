import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/AddPostScreen/AddPost.dart';
import '../../../modules/ChatsScreen/Chats.dart';
import '../../../modules/FavoritesScreen/Favorites.dart';
import '../../../modules/HomeScreen/Home.dart';
import '../../../modules/MapsScreen/Maps.dart';
import '../Food_States/foodStates.dart';

class FoodCubit extends Cubit<FoodStates>
{
  FoodCubit() : super(InitialFoodStates());

  static FoodCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> screens=
  [
     HomeScreen(),
    MapsScreen(),
    AddPosts(),
     FavoritesScreen(),
    ChatsScreen()
  ];
  List<String> titles=
  [
    'Home',
    'Maps',
    'Donate',
    'favorites',
    'Chats'
  ];

  void changeBottomNav(int index)
  {
    if(index==2) {
      emit(DonateFoodState());
    }else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }


  }
}