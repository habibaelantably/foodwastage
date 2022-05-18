import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/components/my_drawer.dart';
import '../shared/cubit/Food_Cubit/food_cubit.dart';
import '../shared/cubit/Food_Cubit/food_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FoodLayout extends StatelessWidget {
  const FoodLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = FoodCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.currentIndex == 0
                ? AppLocalizations.of(context)!.layoutAppBarTitleHome
                : cubit.currentIndex == 1
                    ? AppLocalizations.of(context)!.layoutAppBarTitleMap
                    : cubit.currentIndex == 2
                        ? AppLocalizations.of(context)!.layoutAppBarTitleDonate
                        : cubit.currentIndex == 3
                            ? AppLocalizations.of(context)!
                                .layoutAppBarTitleFavorites
                            : AppLocalizations.of(context)!.chatButton),
          ),
          drawer: const CustomDrawer(),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: AppLocalizations.of(context)!.layoutAppBarTitleHome),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.location_on_outlined),
                  label: AppLocalizations.of(context)!.layoutAppBarTitleMap),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.upload_file),
                  label: AppLocalizations.of(context)!.layoutAppBarTitleDonate),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  label:
                      AppLocalizations.of(context)!.layoutAppBarTitleFavorites),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.message),
                  label: AppLocalizations.of(context)!.chatButton),
            ],
          ),
        );
      },
    );
  }
}
