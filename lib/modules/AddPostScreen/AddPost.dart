
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_States/foodStates.dart';


class AddPosts extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit,FoodStates>(
      builder: (BuildContext context, state) {
        return  Scaffold(
          appBar: deafultAppBar(
              context: context,
              title: 'Donate Food'
          ),
          body: Column(
            children: const [
              Text('Donate')
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}