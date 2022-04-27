


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/components/reusable_components.dart';
import 'package:foodwastage/modules/MapsScreen/Maps.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_States/foodStates.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit,FoodStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Column(
            children: [
              Text('Hone Screen'),
              ElevatedButton(onPressed: (){
                NavigateTo(context, MapScreen());
              }, child: Text('Hi'))
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}