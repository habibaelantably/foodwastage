import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/modules/Home%20Screen/phone_otp_screen.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodwastage/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      builder: (BuildContext context, state) {
        return BuildCondition(
          condition: FoodCubit.get(context).postsList.isNotEmpty &&
              FoodCubit.get(context).userModel != null,
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: filtersButtons(context),
                ),
              ),
              if(FirebaseAuth.instance.currentUser!.phoneNumber==null||FirebaseAuth.instance.currentUser!.phoneNumber=='')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.phoneNumberIsNotVerified,style: const TextStyle(color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.bold),),
                      state is PhoneVerificationCodeSendLoadingState?
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Center(child: CircularProgressIndicator(),),
                      )
                          :Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(onPressed: (){
                          FoodCubit.get(context).verifyPhoneNumber(FoodCubit.get(context).userModel!.phone!, context);
                        }, child: Text(AppLocalizations.of(context)!.verifyButton,style: const TextStyle(color: defaultColor,fontSize: 14.0, fontWeight: FontWeight.bold),)),
                      )
                    ],
                  ),
                ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => postBuilder(
                        viewPost: true,
                        postModel: FoodCubit.get(context).isSearching
                            ? FoodCubit.get(context).searchedForPosts[index]
                            : FoodCubit.get(context).filterValue == 'All'
                            ? FoodCubit.get(context).postsList[index]
                            : FoodCubit.get(context).filteredPosts[index],
                        context: context,
                        userModel: FoodCubit.get(context).userModel!
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20.0,
                    ),
                    itemCount: FoodCubit.get(context).isSearching
                        ? FoodCubit.get(context).searchedForPosts.length
                        : FoodCubit.get(context).filterValue == 'All'
                        ? FoodCubit.get(context).postsList.length
                        : FoodCubit.get(context).filteredPosts.length),
              ),
            ],
          ),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state) {
        if(state is PhoneVerificationCodeSentSuccessState){
          navigateTo(context, PhoneOtpScreen());
        }
      },
    );
  }

  Widget filtersButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        filterButton(
            context: context,
            filterValue: FoodCubit.get(context).filterValue,
            text: AppLocalizations.of(context)!.filterButtonAll,
            value: 'All',
            onPressed: () {
              FoodCubit.get(context).filterPosts('All');
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            context: context,
            filterValue: FoodCubit.get(context).filterValue,
            text: AppLocalizations.of(context)!.filterButtonMainDishes,
            value: 'Main dishes',
            onPressed: () {
              FoodCubit.get(context).filterPosts('Main dishes');
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            context: context,
            filterValue: FoodCubit.get(context).filterValue,
            text: AppLocalizations.of(context)!.filterButtonDesserts,
            value: 'Desserts',
            onPressed: () {
              FoodCubit.get(context).filterPosts('Desserts');
            }),
        const SizedBox(
          width: 7.0,
        ),
        filterButton(
            context: context,
            filterValue: FoodCubit.get(context).filterValue,
            text: AppLocalizations.of(context)!.filterButtonSandwiches,
            value: 'Sandwiches',
            onPressed: () {
              FoodCubit.get(context).filterPosts('Sandwiches');
            }),
      ],
    );
  }
}