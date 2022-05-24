import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/modules/Home%20Screen/home_screen.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../layout/App_Layout.dart';
import '../../shared/constants.dart';
import '../../styles/colors.dart';

class PostRequests extends StatelessWidget {
  const PostRequests({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    FoodCubit.get(context).getPostRequests(postModel);
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.postRequestsScreenTitle),
          ),
          body: BuildCondition(
            builder: (context) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return buildRequestCard(
                        userModel:
                            FoodCubit.get(context).postRequestsList[index],
                        context: context);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20.0,
                      ),
                  itemCount: FoodCubit.get(context).postRequestsList.length);
            },
            condition: FoodCubit.get(context).postRequestsList.isNotEmpty,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildRequestCard(
      {required UserModel userModel, required BuildContext context}) {
    return Card(
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
                  image: NetworkImage('${userModel.image}'),
                  fit: BoxFit.fill,
                )),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 145,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "${postModel.postDate}",
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${userModel.name}',
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          width: 5.0,
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
                    const SizedBox(
                      height: 7.0,
                    ),
                    RatingBar(
                      initialRating: userModel.rating!,
                      itemSize: 25.0,
                      ignoreGestures: userModel.uId == uId ? true : false,
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
                      onRatingUpdate: (double value) {},
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              FoodCubit.get(context).confirmDonation(
                                  postModel: postModel,
                                  receiverId: userModel.uId!);
                              FoodCubit.get(context).currentIndex = 0;
                              navigateAndKill(context, AppLayout());
                            },
                            height: 35,
                            color: Colors.green,
                            child: const Text(
                              "Accept",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
