import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';

import '../../components/constants.dart';
import '../../models/post_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
            appBar: AppBar(
              title: const Text('HISTORY'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => buildHistoryPosts(
                            context: context,
                            index: index,
                            myReceivedPost:
                            FoodCubit.get(context).myReceivedFoodList[index],
                            selectedUserId: uId),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20.0,
                        ),
                        itemCount: FoodCubit.get(context).myReceivedFoodList.length),
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget buildHistoryPosts(
      {required BuildContext context,
      required PostModel myReceivedPost,
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
            height: 155,
            width: 155,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                image: DecorationImage(
                  image: NetworkImage(myReceivedPost.imageUrl1!),
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
                  myReceivedPost.itemName!,
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
                      backgroundImage: NetworkImage(myReceivedPost.userImage!),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(myReceivedPost.userName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800)),
                          Text(myReceivedPost.foodDonor!,
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
          SizedBox(
            height: 155,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
          )
        ],
      ),
    );
  }
}
