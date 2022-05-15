import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/widgets/my_drawer.dart';

import '../shared/cubit/Food_Cubit/food_cubit.dart';
import '../shared/cubit/Food_Cubit/food_states.dart';

// ignore: camel_case_types
class foodLayout extends StatelessWidget {
  const foodLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (BuildContext context, state) {
        // if(state is DonateFoodState)
        // {
        //   NavigateTo(context, AddPosts());
        // }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = FoodCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          drawer: const CustomDrawer(),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined), label: 'maps'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload_file), label: 'Donate'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: 'Chats'),
            ],
          ),
        );
      },
    );
  }
}
