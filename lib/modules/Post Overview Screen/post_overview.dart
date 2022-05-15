import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';

import '../../components/constants.dart';
import '../../components/reusable_components.dart';
import '../../shared/cubit/Food_Cubit/food_states.dart';
import '../../styles/colors.dart';

class PostOverview extends StatelessWidget {
  const PostOverview({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

//
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Image(
                  height: 230.0,
                  width: double.infinity,
                  image: NetworkImage(
                    postModel.imageUrl1!,
                  ),
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  postModel.foodType!,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          rowTextAndFormInput(
                              /////////////////////////////////////Location/////////////////////////////////////
                              rowText: "Pickup where ?",
                              initialValue: postModel.location,
                              isReadonly: true,
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.add_location_alt_outlined,
                              hintTextForm: "Location!"),

                          const SizedBox(height: 20),

                          /////////////////////////////////////Name/////////////////////////////////////
                          rowTextAndFormInput(
                              rowText: "Food Item(s)",
                              initialValue: postModel.itemName,
                              fontSize: 19,
                              color: KBlack,
                              isReadonly: true,
                              fontWeight: FontWeight.normal,
                              icon: Icons.fastfood_outlined,
                              hintTextForm: "Item(s)!"),

                          const SizedBox(height: 20),

                          /////////////////////////////////////Date/////////////////////////////////////
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              defaultText(
                                  text: "Pickup Day",
                                  fontSize: 19,
                                  color: KBlack,
                                  fontWeight: FontWeight.normal),
                              const Icon(Icons.date_range_outlined,
                                  color: defaultColor),
                            ],
                          ),

                          TextFormField(
                            decoration: const InputDecoration(),
                            initialValue: postModel.postDate!,
                            readOnly: true,
                          ),
                          const SizedBox(height: 20),

                          /////////////////////////////////////Quantity/////////////////////////////////////

                          rowTextAndFormInput(
                              isReadonly: true,
                              rowText: "Quantity",
                              initialValue: postModel.quantity,
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.list_alt,
                              hintTextForm: "Item Quantity"),

                          const SizedBox(height: 20),

                          /////////////////////////////////////Description/////////////////////////////////////

                          rowTextAndFormInput(
                              isReadonly: true,
                              rowText: "Description",
                              initialValue: postModel.description,
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.description,
                              hintTextForm: "Write a description"),
                        ],
                      ),
                    ),
                  ),
                ),
                postModel.donorId != uId
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: defaultButton(
                                  function: () {},
                                  text: 'CHAT NOW',
                                  height: 30.0),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 30.0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color: postModel.receiverId != uId
                                      ? defaultColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: MaterialButton(
                                  onPressed: postModel.receiverId != uId
                                      ? () {
                                          FoodCubit.get(context).receiveFood(
                                              postModel: postModel);
                                        }
                                      : () {},
                                  child: state is FoodReceiveFoodLoadingState
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "GET",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
