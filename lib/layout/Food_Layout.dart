import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/components/my_drawer.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';

class FoodLayout extends StatelessWidget {
  FoodLayout({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = FoodCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              title: FoodCubit.get(context).currentIndex == 0 &&
                      FoodCubit.get(context).isSearching
                  ? TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      obscureText: false,
                      cursorHeight: 2,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        hintText: 'Search...',
                        hintStyle:
                            TextStyle(fontSize: 11.0, color: Colors.grey[700]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide().copyWith(width: 0)),
                      ),
                      onTap: () {
                        FoodCubit.get(context)
                            .startSearch(context, searchController);
                      },
                      onFieldSubmitted: (value) {
                        FoodCubit.get(context)
                            .addSearchedForItemsToSearchedList(value);
                      },
                    )
                  : Text(cubit.currentIndex == 0
                      ? AppLocalizations.of(context)!.layoutAppBarTitleHome
                      : cubit.currentIndex == 1
                          ? AppLocalizations.of(context)!.layoutAppBarTitleMap
                          : cubit.currentIndex == 2
                              ? AppLocalizations.of(context)!
                                  .layoutAppBarTitleDonate
                              : cubit.currentIndex == 3
                                  ? AppLocalizations.of(context)!
                                      .layoutAppBarTitleFavorites
                                  : AppLocalizations.of(context)!.chatButton),
              actions: [
                FoodCubit.get(context).currentIndex == 0
                    ? IconButton(
                        icon: FoodCubit.get(context).isSearching
                            ? const Icon(Icons.clear)
                            : const Icon(Icons.search),
                        onPressed: () {
                          FoodCubit.get(context).changeSearchButtonIcon();
                          if (FoodCubit.get(context).isSearching) {
                            FoodCubit.get(context).searchedForPosts = [];
                          }
                        },
                      )
                    : const SizedBox()
              ]),
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
