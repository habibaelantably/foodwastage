import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      builder: (BuildContext context, state) {
        return BuildCondition(
          condition: FoodCubit.get(context).postsList.isNotEmpty &&
              FoodCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => postBuilder(
                    viewPost: true,
                    postModel: FoodCubit.get(context).postsList[index],
                    context: context,
                    isInHistory: false),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20.0,
                    ),
                itemCount: FoodCubit.get(context).postsList.length),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
