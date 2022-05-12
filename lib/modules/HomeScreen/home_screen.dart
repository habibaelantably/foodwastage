import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/components/reusable_components.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/modules/ProfileScreen/profile_screen.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_States/food_states.dart';

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
        Card(
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
                        bottomLeft: Radius.circular(10.0)),
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
                            //to get selected user data to display it in his profile
                            FoodCubit.get(context)
                                .getUserdata(selectedUserId: postModel.donorId,context: context);
                            //to get selected user posts if select different user from current user
                            if (postModel.donorId != uId) {
                              FoodCubit.get(context).getSelectedUserPosts(
                                  selectedUserId: postModel.donorId!);
                            }
                            //to be sure that the method has finished to avoid null check operator
                            if (postModel.donorId == uId) {
                              NavigateTo(
                                  context,
                                  ProfileScreen(
                                    selectedUserId: uId!,
                                  ));
                            }
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
                                  //to get selected user data to display it in his profile
                                  FoodCubit.get(context).getUserdata(
                                      selectedUserId: postModel.donorId,context: context);
                                  //to get selected user posts if select different user from current user
                                  if (postModel.donorId != uId) {
                                    FoodCubit.get(context).getSelectedUserPosts(
                                        selectedUserId: postModel.donorId!);
                                  }
                                  //to be sure that the method has finished to avoid null check operator
                                  if (postModel.donorId == uId) {
                                    NavigateTo(
                                        context,
                                        ProfileScreen(
                                          selectedUserId: uId!,
                                        ));
                                  }
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
              SizedBox(
                height: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 5.0),
                      child: Icon(Icons.favorite),
                    ),
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
              )
            ],
          ),
        ),
      ],
    );
