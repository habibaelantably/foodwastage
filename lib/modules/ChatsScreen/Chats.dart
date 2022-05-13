
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_States/foodStates.dart';

class ChatsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit,FoodStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Column(
            children: const [
              Text('Chats')
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}