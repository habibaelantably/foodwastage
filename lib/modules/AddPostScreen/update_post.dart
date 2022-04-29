import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../components/reusable_components.dart';
import '../../shared/cubit/Post/post_cubit.dart';
import '../../shared/cubit/Post/post_states.dart';
import '../../styles/colors.dart';

//بتستدعي الصفحه من الليست اللي فيها البوست علشان تقدر تمرر فيها الpostId

class UpdatePost extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String postId;
  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => PostCubit(),
      child: BlocConsumer<PostCubit, PostStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //هنا بنخزن القيم اللي جايه علشان نظهرها ونعدل عليها
          locationController.text = postModel.location!;
          foodNameController.text = postModel.itemName!;
          quantityController.text = postModel.itemCount!.toString();
          descriptionController.text = postModel.description!;
          PostCubit.get(context).itemCount = postModel.itemCount!;
          PostCubit.get(context).itemCount = postModel.itemCount!;
          PostCubit.get(context).foodDonor = postModel.foodDonor!;
          PostCubit.get(context).foodType = postModel.foodType!;

          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // first text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        defaultText(
                            text: "donate",
                            fontWeight: FontWeight.normal,
                            color: KBlack,
                            fontSize: 26),
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    PostCubit.get(context).minusItemCount(quantityController);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 15,
                                    color: defaultColor,
                                  )),
                              defaultText(
                                  text: "${PostCubit.get(context).itemCount}",
                                  fontSize: 15,
                                  color: KBlack,
                                  fontWeight: FontWeight.normal),
                              IconButton(
                                  onPressed: () {
                                    PostCubit.get(context).incrementItemCount(quantityController);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 15,
                                    color: defaultColor,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height / 50),
                    //form F
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          rowTextAndFormInput(
                              validator: (value) {
                                if (value.toString().length == 0) {
                                  return "enter the location";
                                } else {
                                  return null;
                                }
                              },
                              textEditingController: locationController,
                              rowText: "Pickup where ?",
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.add_location_alt_outlined,
                              hintTextForm: "Location!"),
                          SizedBox(
                            height: size.height / 60,
                          ),
                          rowTextAndFormInput(
                              textEditingController: foodNameController,
                              validator: (value) {
                                if (value.toString().length == 0) {
                                  return "enter the food name";
                                } else {
                                  return null;
                                }
                              },
                              rowText: "Food Item(s)",
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.fastfood_outlined,
                              hintTextForm: "Item(s)!"),
                          SizedBox(
                            height: size.height / 60,
                          ),
                          //Date
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
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                currentTime: DateTime.now(),
                                locale: LocaleType.en,
                                maxTime: DateTime(2030, 1, 1),
                                minTime: DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day),
                                onChanged: (date) {
                                  PostCubit.get(context).changDateTime(date);
                                },
                                onConfirm: (date) {
                                  PostCubit.get(context).changDateTime(date);
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: Container(
                                padding: EdgeInsets.zero,
                                height: size.height / 15,
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                  border: Border.all(color: KBlack, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 6),
                                  child: Text(
                                    "${PostCubit.get(context).date}",
                                    style: const TextStyle(
                                        color: KBlack, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 120,
                          ),
                          //Quantity
                          rowTextAndFormInput(
                              validator: (value) {
                                if (value == 0 ||
                                    quantityController.text.isEmpty) {
                                  return "enter the quantity";
                                } else {
                                  return null;
                                }
                              },
                              textEditingController: quantityController,
                              textInputType: TextInputType.number,
                              rowText: "Quantity",
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.list_alt,
                              hintTextForm: "Item Quantity"),
                          SizedBox(
                            height: size.height / 65,
                          ),
                          /////////////////////////////////////Description
                          rowTextAndFormInput(
                              textEditingController: descriptionController,
                              validator: (value) {
                                if (value.toString().length == 0) {
                                  return "enter the description";
                                } else if (value.toString().length <= 50) {
                                  return "enter the more about item";
                                } else {
                                  return null;
                                }
                              },
                              rowText: "Description",
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal,
                              icon: Icons.description,
                              hintTextForm: "Write a description"),
                          SizedBox(
                            height: size.height / 60,
                          ),
                          //Photo
                          const Text(
                            "Photos",
                            style: TextStyle(fontSize: 19),
                          ),
                          SizedBox(
                            height: size.height / 90,
                          ),

                          //هنا لو ضفت صور هيتعملها update لو مضفتش هتفضل زي مهي عادي
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              if (PostCubit.get(context).imageFile1 == null)
                                PostCubit.get(context).imageFile2 != null
                                    ? DottedBorder(
                                        color: defaultColor,
                                        strokeWidth: 2,
                                        dashPattern: const [
                                          3,
                                          3,
                                        ],
                                        child: InkWell(
                                          onTap: () {
                                            if (PostCubit.get(context)
                                                    .imageFile1 ==
                                                null) {
                                              PostCubit.get(context)
                                                  .getImage1();
                                            } else if (PostCubit.get(context)
                                                    .imageFile2 ==
                                                null) {
                                              PostCubit.get(context)
                                                  .getImage2();
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: size.width * .23,
                                            height: size.width * .23,
                                            padding: const EdgeInsets.all(16.0),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              else if (PostCubit.get(context).imageFile1 !=
                                  null)
                                Stack(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.grey
                                            //         .withOpacity(0.5),
                                            //     spreadRadius: 2,
                                            //     blurRadius: 4,
                                            //     offset: Offset(0,
                                            //         3), // changes position of shadow
                                            //   ),
                                            // ],
                                            ),
                                        alignment: Alignment.center,
                                        width: size.width * .23,
                                        height: size.width * .23,
                                        //    padding: const EdgeInsets.all(16.0),
                                        child: Image.file(
                                          PostCubit.get(context).imageFile1!,
                                          fit: BoxFit.cover,
                                        )),
                                    Positioned(
                                      right: 3,
                                      top: 3,
                                      child: CircleAvatar(
                                        backgroundColor: defaultColor,
                                        maxRadius: size.width * .03,
                                        minRadius: size.width * .03,
                                        child: Center(
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              PostCubit.get(context)
                                                  .deleteImage1();
                                            },
                                            icon: Icon(
                                              Icons.clear,
                                              color: KBlack,
                                              size: size.width * .05,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              SizedBox(
                                width: 10,
                              ),
                              if (PostCubit.get(context).imageFile2 == null)
                                DottedBorder(
                                  color: defaultColor,
                                  strokeWidth: 2,
                                  dashPattern: const [
                                    3,
                                    3,
                                  ],
                                  child: InkWell(
                                    onTap: () {
                                      if (PostCubit.get(context).imageFile1 ==
                                          null) {
                                        PostCubit.get(context).getImage1();
                                      } else if (PostCubit.get(context)
                                              .imageFile2 ==
                                          null) {
                                        PostCubit.get(context).getImage2();
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: size.width * .23,
                                      height: size.width * .23,
                                      padding: const EdgeInsets.all(16.0),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Stack(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.grey
                                            //         .withOpacity(0.5),
                                            //     spreadRadius: 2,
                                            //     blurRadius: 4,
                                            //     offset: Offset(0,
                                            //         3), // changes position of shadow
                                            //   ),
                                            // ],
                                            ),
                                        alignment: Alignment.center,
                                        width: size.width * .23,
                                        height: size.width * .23,
                                        //    padding: const EdgeInsets.all(16.0),
                                        child: ClipRRect(
                                          child: Image.file(
                                            PostCubit.get(context).imageFile2!,
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                    Positioned(
                                      right: 3,
                                      top: 3,
                                      child: CircleAvatar(
                                        backgroundColor: defaultColor,
                                        maxRadius: size.width * .03,
                                        minRadius: size.width * .03,
                                        child: Center(
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              PostCubit.get(context)
                                                  .deleteImage2();
                                            },
                                            icon: Icon(
                                              Icons.clear,
                                              color: KBlack,
                                              size: size.width * .05,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 60,
                          ),
                          RadioGroup<String>.builder(
                            activeColor: KBlack,
                            direction: Axis.horizontal,
                            groupValue: PostCubit.get(context).foodType,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) => PostCubit.get(context)
                                .changeVerticalGroupValue(value),
                            items: PostCubit.get(context).status,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                          RadioGroup<String>.builder(
                            activeColor: KBlack,
                            direction: Axis.horizontal,
                            groupValue: PostCubit.get(context).foodDonor,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            onChanged: (value) {
                              PostCubit.get(context)
                                  .changeVerticalGroupValue2(value);
                            },
                            items: PostCubit.get(context).status2,
                            textStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),

                          //row text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  PostCubit.get(context).check();
                                },
                                child: Icon(
                                  PostCubit.get(context).isChecked == false
                                      ? Icons.radio_button_unchecked_outlined
                                      : Icons.check_circle_outline,
                                  color: defaultColor,
                                ),
                              ),
                              defaultText(
                                  text:
                                      "I assure that food quality and hygiene has maintained",
                                  fontSize: 12,
                                  color: KBlack,
                                  fontWeight: FontWeight.normal)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width / 2,
                                decoration: BoxDecoration(),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // <-- Radius
                                      ),
                                    ),
                                    onPressed: () {
                                      if (PostCubit.get(context).isChecked ==
                                          false) {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: Text('Confirm Rules'),
                                                  content: Text(
                                                      'Please Assure the food quality'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: defaultText(
                                                            text: "Ok",
                                                            fontSize: 20,
                                                            color: KBlack,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ));
                                      }
                                      if (formKey.currentState!.validate() &&
                                          PostCubit.get(context).isChecked ==
                                              true) {
                                        PostCubit.get(context).updatePost(
                                            itemCount: PostCubit.get(context)
                                                .itemCount,
                                            location: locationController.text,
                                            itemName: foodNameController.text,
                                            postDate:
                                                PostCubit.get(context).date,
                                            quantity: quantityController.text,
                                            description:
                                                descriptionController.text,
                                            imageUrl1: postModel.imageUrl1!,
                                            imageUrl2: postModel.imageUrl2!,
                                            foodType:
                                                PostCubit.get(context).foodType,
                                            foodDonor: PostCubit.get(context)
                                                .foodDonor,
                                            postId: postId);
                                      }
                                    },
                                    child: state is UpdatePostLoadingState
                                        ? SizedBox(
                                            height: size.width * .05,
                                            width: size.width * .05,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : defaultText(
                                            text: "Update",
                                            fontSize: 26,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  UpdatePost({required this.postId, required this.postModel});
}
