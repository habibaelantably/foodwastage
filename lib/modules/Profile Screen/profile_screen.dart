import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/shared/constants.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:foodwastage/styles/colors.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.selectedUserId}) : super(key: key);
  final String selectedUserId;
  late UserModel profileUserModel;
  double? ratingValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
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
            title: Text(
              AppLocalizations.of(context)!.profileScreenTitle,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              selectedUserId != uId
                  ? IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                      onPressed: () {},
                    )
                  : const SizedBox(),
            ],
          ),
          body: BuildCondition(
              builder: (context) {
                if (uId == selectedUserId) {
                  profileUserModel = FoodCubit.get(context).userModel!;
                } else {
                  profileUserModel = FoodCubit.get(context).selectedUserModel!;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage:
                                NetworkImage(profileUserModel.image!),
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "${profileUserModel.name} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800)),
                                  TextSpan(
                                    text: "(${profileUserModel.type})",
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ]),
                              ),
                              const SizedBox(
                                height: 7.0,
                              ),
                              Row(
                                children: [
                                  RatingBar(
                                    initialRating: profileUserModel.rating!,
                                    itemSize: 20.0,
                                    ignoreGestures:
                                        selectedUserId == uId ? true : false,
                                    itemCount: 5,
                                    direction: Axis.horizontal,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(
                                        Icons.star,
                                        color: defaultColor,
                                      ),
                                      half: const Icon(
                                        Icons.star_half,
                                        color: defaultColor,
                                      ),
                                      empty: const Icon(
                                        Icons.star_border,
                                        color: defaultColor,
                                      ),
                                    ),
                                    minRating: 1,
                                    maxRating: 5,
                                    onRatingUpdate: (double value) {
                                      ratingValue = value;
                                    },
                                  ),
                                  const SizedBox(
                                    width: 30.0,
                                  ),
                                  selectedUserId != uId
                                      ? Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          height: 29.0,
                                          width: 45.0,
                                          decoration: BoxDecoration(
                                              color: defaultColor,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: TextButton(
                                            onPressed: () {
                                              if (ratingValue != 0) {
                                                FoodCubit.get(context)
                                                    .updateUserRating(
                                                        rating: ratingValue!);
                                              }
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .rateButton,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                              selectedUserId != uId
                                  ? MaterialButton(
                                      onPressed: () {},
                                      color: defaultColor,
                                      height: 24,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .chatButton,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        width: double.infinity,
                        height: 2.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return postBuilder(
                                context: context,
                                postModel: uId == selectedUserId
                                    ? FoodCubit.get(context)
                                        .currentUserPostsList[index]
                                    : FoodCubit.get(context)
                                        .selectedUserPostsList[index],
                                viewPost: true,
                                isInHistory: false);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 20.0,
                              ),
                          itemCount: selectedUserId == uId
                              ? FoodCubit.get(context)
                                  .currentUserPostsList
                                  .length
                              : FoodCubit.get(context)
                                  .selectedUserPostsList
                                  .length),
                    )
                  ],
                );
              },
              condition: (selectedUserId != uId &&
                      FoodCubit.get(context).selectedUserPostsList.isNotEmpty &&
                      FoodCubit.get(context).selectedUserModel != null) ||
                  (selectedUserId == uId &&
                      FoodCubit.get(context).currentUserPostsList.isNotEmpty &&
                      FoodCubit.get(context).userModel != null),
              fallback: (context) {
                if (selectedUserId == uId &&
                    FoodCubit.get(context).currentUserPostsList.isEmpty &&
                    FoodCubit.get(context).userModel != null) {
                  profileUserModel = FoodCubit.get(context).userModel!;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage:
                                    NetworkImage(profileUserModel.image!),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profileUserModel.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 7.0,
                                  ),
                                  Row(
                                    children: [
                                      RatingBar(
                                        initialRating: profileUserModel.rating!,
                                        itemSize: 20.0,
                                        ignoreGestures: selectedUserId == uId
                                            ? true
                                            : false,
                                        itemCount: 5,
                                        direction: Axis.horizontal,
                                        ratingWidget: RatingWidget(
                                          full: const Icon(
                                            Icons.star,
                                            color: defaultColor,
                                          ),
                                          half: const Icon(
                                            Icons.star_half,
                                            color: defaultColor,
                                          ),
                                          empty: const Icon(
                                            Icons.star_border,
                                            color: defaultColor,
                                          ),
                                        ),
                                        minRating: 1,
                                        maxRating: 5,
                                        onRatingUpdate: (double value) {
                                          ratingValue = value;
                                        },
                                      ),
                                      const SizedBox(
                                        width: 30.0,
                                      ),
                                      selectedUserId != uId
                                          ? Container(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              height: 29.0,
                                              width: 45.0,
                                              decoration: BoxDecoration(
                                                  color: defaultColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: TextButton(
                                                onPressed: () {
                                                  if (ratingValue != 0) {
                                                    FoodCubit.get(context)
                                                        .updateUserRating(
                                                            rating:
                                                                ratingValue!);
                                                  }
                                                },
                                                child: const Text(
                                                  "Rate",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  selectedUserId != uId
                                      ? MaterialButton(
                                          onPressed: () {},
                                          color: defaultColor,
                                          height: 24,
                                          child: const Text(
                                            'Chat',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Container(
                            width: double.infinity,
                            height: 2.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        const Text(
                          "You have no posts yet...",
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w700,
                              color: defaultColor),
                        )
                      ]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      },
    );
  }
}
