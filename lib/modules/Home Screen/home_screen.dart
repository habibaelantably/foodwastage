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
        return Column(
          children: [
            filtersButtons(context),
            const SizedBox(
              height: 15.0,
            ),
            BuildCondition(
              condition: FoodCubit.get(context).postsList.isNotEmpty &&
                  FoodCubit.get(context).userModel != null,
              builder: (context) => Expanded(
                child: SingleChildScrollView(
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => postBuilder(
                          viewPost: true,
                          postModel: FoodCubit.get(context).isSearching
                              ? FoodCubit.get(context).searchedForPosts[index]
                              : FoodCubit.get(context).filterValue == 'All'
                                  ? FoodCubit.get(context).postsList[index]
                                  : FoodCubit.get(context).filteredPosts[index],
                          context: context,
                          isInHistory: false,
                          isInMyRequests: false),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20.0,
                          ),
                      itemCount: FoodCubit.get(context).isSearching
                          ? FoodCubit.get(context).searchedForPosts.length
                          : FoodCubit.get(context).filterValue == 'All'
                              ? FoodCubit.get(context).postsList.length
                              : FoodCubit.get(context).filteredPosts.length),
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget filtersButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        filterButton(
            filterValue: FoodCubit.get(context).filterValue,
            text: 'All',
            onPressed: () {
              FoodCubit.get(context).selectFilter('All');
              FoodCubit.get(context).filterPosts();
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            filterValue: FoodCubit.get(context).filterValue,
            text: 'Main dishes',
            onPressed: () {
              FoodCubit.get(context).selectFilter('Main dishes');
              FoodCubit.get(context).filterPosts();
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            filterValue: FoodCubit.get(context).filterValue,
            text: 'Deserts',
            onPressed: () {
              FoodCubit.get(context).selectFilter('Deserts');
              FoodCubit.get(context).filterPosts();
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            filterValue: FoodCubit.get(context).filterValue,
            text: 'Sandwiches',
            onPressed: () {
              FoodCubit.get(context).selectFilter('Sandwiches');
              FoodCubit.get(context).filterPosts();
            }),
      ],
    );
  }
}
