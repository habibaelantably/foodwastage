


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_States/foodStates.dart';
import 'package:foodwastage/widgets/my_drawer.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit,FoodStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          drawer: CustomDrawer(),
          body: Column(
            children: const [
              Text('Hone Screen'),
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}