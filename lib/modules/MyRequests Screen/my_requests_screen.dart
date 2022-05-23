import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import '../../models/User_model.dart';
import '../../shared/components/reusable_components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/constants.dart';
import '../../styles/colors.dart';
import '../Post Overview Screen/post_overview.dart';
import '../Profile Screen/profile_screen.dart';

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
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildRequestCard(context: context, postModel: FoodCubit.get(context).myRequestsList[index],userModel:FoodCubit.get(context).userModel!),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20.0,
                      ),
                  itemCount: FoodCubit.get(context).myRequestsList.length),
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
            ),
        );
      },
    );
  }
}

Widget buildRequestCard(
    {required UserModel userModel, required BuildContext context, required PostModel postModel}) {
  return InkWell(
    onTap: (){
      navigateTo(context, PostOverview(postModel: postModel));
    },
    child: Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 145,
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
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                padding: const EdgeInsetsDirectional.only(top: 8.0),
                height: 145,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      child: Text(
                        "${postModel.postDate}",
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
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
                                child: Text("${postModel.userName}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800)),
                              ),
                              Text(
                                '${FoodCubit.get(context).userModel!.type}',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              FoodCubit.get(context).cancelRequest(context, postModel: postModel);
                            },
                            height: 30,
                            color: Colors.red,
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
