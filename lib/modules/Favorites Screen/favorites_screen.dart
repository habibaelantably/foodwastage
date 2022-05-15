import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/post_model.dart';
import '/shared/cubit/Food_Cubit/food_cubit.dart';
import '../../shared/cubit/Food_Cubit/food_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      builder: (BuildContext context, state) {
        return BuildCondition(
          condition: FoodCubit.get(context).favPosts.isNotEmpty &&
              FoodCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => PostBuilder(
                      context,
                      FoodCubit.get(context).favPosts[index],
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                itemCount: FoodCubit.get(context).favPosts.length),
          ),
          fallback: (context) =>
              const Center(child: Text('no Favorite add yet')),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

// ignore: non_constant_identifier_names
Widget PostBuilder(context, PostModel postModel) => Column(
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
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage('${postModel.userImage}'),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          children: [
                            Text(
                              '${postModel.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            Text(
                              '${postModel.foodDonor}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                            ),
                          ],
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
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        right: 5.0,
                      ),
                      child: IconButton(
                        onPressed: () {
                          FoodCubit.get(context).getFavPosts(postModel.postId!);
                        },
                        icon: Icon(
                          FoodCubit.get(context).isItFav(postModel.postId!) ??
                                  false
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.orange,
                        ),
                      ),
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
