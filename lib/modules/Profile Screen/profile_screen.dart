import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:foodwastage/styles/colors.dart';

import '../../components/reusable_components.dart';
import '../../models/User_model.dart';
import '../../models/post_model.dart';
import '../Post Overview Screen/post_overview.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.selectedUserId}) : super(key: key);
  final String selectedUserId;
  late UserModel profileUserModel;
  double? ratingValue;

//
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
            titleSpacing: 20.0,
            title: Row(
              children: const [
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ],
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
                                          child: const Text(
                                            "Rate",
                                            style:
                                                TextStyle(color: Colors.white),
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
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildMyPosts(
                            context: context,
                            currentUserPost: uId == selectedUserId
                                ? FoodCubit.get(context)
                                    .currentUserPostsList[index]
                                : FoodCubit.get(context)
                                    .selectedUserPostsList[index],
                            index: index,
                            selectedUserId: selectedUserId,
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10.0,
                            ),
                        itemCount: selectedUserId == uId
                            ? FoodCubit.get(context).currentUserPostsList.length
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
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildMyPosts(
      {required BuildContext context,
      required PostModel currentUserPost,
      required int index,
      required selectedUserId}) {
    return InkWell(
      onTap: () {
        navigateTo(context, PostOverview(postModel: currentUserPost));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        color: Colors.grey[100],
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Container(
              height: 135,
              width: 155,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  image: DecorationImage(
                    image: NetworkImage(currentUserPost.imageUrl1!),
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    currentUserPost.itemName!,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(currentUserPost.userImage!),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(currentUserPost.userName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800)),
                            Text(currentUserPost.foodDonor!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.grey, fontSize: 10))
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 5.0),
              child: SizedBox(
                height: 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //the condition is for display delete button if i'm in my profile and favorite button if i'm in another user profile
                    currentUserPost.donorId != uId
                        ? const Padding(
                            padding: EdgeInsets.only(top: 5.0, right: 5.0),
                            child: Icon(
                              Icons.favorite_border,
                              color: defaultColor,
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, right: 5.0),
                            child: PopupMenuButton<String>(
                                icon: const Icon(Icons.more_horiz),
                                onSelected: (value) {
                                  if (value == "Delete") {
                                    FoodCubit.get(context)
                                        .deletePost(currentUserPost.postId!);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return <PopupMenuItem<String>>[
                                    const PopupMenuItem(
                                      child: Text("Delete"),
                                      value: "Delete",
                                    )
                                  ];
                                })),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textBaseline: TextBaseline.alphabetic,
                      children: const [
                        Text(
                          "13",
                          style: TextStyle(color: Colors.orange),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0, right: 5.0),
                          child: Icon(Icons.comment_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
