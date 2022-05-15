import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:foodwastage/styles/colors.dart';

import '../../components/constants.dart';
import '../../models/post_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('HISTORY'),
            ),
            body: BuildCondition(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildHistoryPosts(
                              context: context,
                              index: index,
                              historyPost: FoodCubit.get(context)
                                  .myReceivedFoodList[index],
                              selectedUserId: uId),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 20.0,
                              ),
                          itemCount:
                              FoodCubit.get(context).myReceivedFoodList.length),
                    )
                  ],
                ),
              ),
              condition: FoodCubit.get(context).myReceivedFoodList.isNotEmpty,
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }

  Widget buildHistoryPosts(
      {required BuildContext context,
      required PostModel historyPost,
      required int index,
      required selectedUserId}) {
    return Card(
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
                  image: NetworkImage(historyPost.imageUrl1!),
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
                  historyPost.itemName!,
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
                      backgroundImage: NetworkImage(historyPost.userImage!),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(historyPost.userName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800)),
                          Text(historyPost.foodDonor!,
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
                  Text(
                    historyPost.donorId == uId ? 'donated' : 'received',
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: defaultColor),
                  ),
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
    );
  }
}
