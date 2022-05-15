import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/components/reusable_components.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/modules/Profile%20Screen/profile_screen.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';

import '../Post Overview Screen/post_overview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

//
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
                    context, FoodCubit.get(context).postsList[index], state),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
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

Widget postBuilder(context, PostModel postModel, state) => Column(
      children: [
        InkWell(
          onTap: () {
            navigateTo(context, PostOverview(postModel: postModel));
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
                  height: 155,
                  width: 155,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage('${postModel.imageUrl1}'),
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
                        '${postModel.itemName}',
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage('${postModel.userImage}'),
                            ),
                            onTap: () {
                              if (postModel.donorId != uId) {
                                FoodCubit.get(context).getUserdata(
                                    selectedUserId: postModel.donorId,
                                    context: context);
                                FoodCubit.get(context).getSelectedUserPosts(
                                  selectedUserId: postModel.donorId!,
                                );
                              }
                              navigateTo(
                                context,
                                ProfileScreen(
                                  selectedUserId: postModel.donorId!,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (postModel.donorId != uId) {
                                      FoodCubit.get(context).getUserdata(
                                          selectedUserId: postModel.donorId,
                                          context: context);
                                      FoodCubit.get(context)
                                          .getSelectedUserPosts(
                                        selectedUserId: postModel.donorId!,
                                      );
                                    }
                                    navigateTo(
                                        context,
                                        ProfileScreen(
                                          selectedUserId: postModel.donorId!,
                                        ));
                                  },
                                  child: Text(postModel.userName!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800)),
                                ),
                                Text('${postModel.foodDonor}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 10))
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
                        postModel.donorId != uId
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, right: 5.0),
                                child: IconButton(
                                  onPressed: () {
                                    FoodCubit.get(context)
                                        .getFavPosts(postModel.postId!);
                                  },
                                  icon: Icon(
                                    FoodCubit.get(context)
                                                .isItFav(postModel.postId!) ??
                                            false
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.orange,
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, right: 5.0),
                                child: PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_horiz,
                                    ),
                                    onSelected: (value) {
                                      if (value == "Delete") {
                                        FoodCubit.get(context)
                                            .deletePost(postModel.postId!);
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
                              '13',
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
        ),
      ],
    );
