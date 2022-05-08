
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_States/foodStates.dart';

class FavoritesScreen extends StatelessWidget
{
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit,FoodStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return  Scaffold(
          body: Column(
            children: const [
              Text('favorites')
            ],
          ),
        );
      },

    );
  }

}