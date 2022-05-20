import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import '../../shared/components/reusable_components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../styles/colors.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  //to back to home directly
                  FoodCubit.get(context).currentIndex != 0
                      ? FoodCubit.get(context).changeBottomNav(0)
                      : null;

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(AppLocalizations.of(context)!.myRequestsScreenTitle),
            ),
            body: BuildCondition(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => postBuilder(
                                context: context,
                                isInHistory: false,
                                isInMyRequests: true,
                                viewPost: true,
                                postModel: FoodCubit.get(context)
                                    .myRequestsList[index],
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 20.0,
                              ),
                          itemCount:
                              FoodCubit.get(context).myRequestsList.length),
                    )
                  ],
                ),
              ),
              condition: FoodCubit.get(context).myRequestsList.isNotEmpty,
              fallback: (context) =>FoodCubit.get(context).myRequestsList.isEmpty? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.profileScreenPostsFallBack,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: defaultColor),
                  ),
                ),
              ) : const Center(child: CircularProgressIndicator())
            ));
      },
    );
  }
}
