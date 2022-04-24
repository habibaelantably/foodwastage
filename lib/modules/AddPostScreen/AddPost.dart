
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_States/foodStates.dart';

import '../../components/reusable_components.dart';
import '../../styles/colors.dart';

// import 'dart:io';

class AddPosts extends StatefulWidget {
  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  int num = 0;
  String dateTime = "Date";
  int value1=1;
  int value2=1;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SingleChildScrollView(
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
                                  setState(() {
                                    num = num - 1;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 15,
                                  color: defaultColor,
                                )),
                            defaultText(
                                text: "$num",
                                fontSize: 15,
                                color: KBlack,
                                fontWeight: FontWeight.normal),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    num = num + 1;
                                  });
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        rowTextAndFormInput(rowText: "Pickup where ?",
                            fontSize: 19, color: KBlack,
                            fontWeight: FontWeight.normal, icon: Icons.add_location_alt_outlined, hintTextForm: "Location!"),
                       SizedBox(height: size.height/60,),
                        rowTextAndFormInput(rowText: "Food Item(s)",
                            fontSize: 19, color: KBlack,
                            fontWeight: FontWeight.normal, icon: Icons.fastfood_outlined, hintTextForm: "Item(s)!"),
                        SizedBox(height: size.height/60,),
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
                              minTime: DateTime(DateTime.now().year, DateTime.now().month,
                                  DateTime.now().day),
                              onChanged: (date) {
                                setState(() {
                                  dateTime = "${date.year}-${date.month}-${date.day}";
                                });
                              },
                              onConfirm: (date) {
                                setState(() {
                                  dateTime = "${date.day}/${date.month}/${date.year}";
                                });
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              height: size.height/12,
                              width: MediaQuery.of(context).size.width,
                              decoration:  BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                border: Border.all(color: KBlack, width: 0.5),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                                child: Text(
                                  "$dateTime",
                                  style: TextStyle(
                                    color: KBlack,fontSize: 20
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height/120,),
                        //Quantity
                        rowTextAndFormInput(rowText: "Food Item(s)",
                            fontSize: 19, color: KBlack,
                            fontWeight: FontWeight.normal, icon: Icons.fastfood_outlined, hintTextForm: "Item(s)!"),
                        SizedBox(height: size.height/60,),
                        //Description
                        rowTextAndFormInput(rowText: "Description",
                            fontSize: 19, color: KBlack,
                            fontWeight: FontWeight.normal, icon: Icons.description, hintTextForm: "Write a description"),
                        SizedBox(height: size.height/60,),
                        //Photo
                        const Text("Photos",style: TextStyle(fontSize: 19),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                          ],
                        ),
                        SizedBox(height: size.height/60,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Row(
                                 children: [
                               Radio(value: 1, groupValue: value1, onChanged: (value){
                                       setState(() {
                                           value1!=value;
                                              });
                               }),
                               const Text("Main dishes")
                             ]),
                             Row(
                                 children: [
                                   Radio(value: 2, groupValue: value1, onChanged: (value){
                                     setState(() {
                                       value1!=value;
                                     });
                                   }),

                                   const Text("Desert")
                                 ]),
                             SizedBox(width: 2,),
                             Row(
                                 children: [
                                   Radio(value: 3, groupValue: value1, onChanged: (value){
                                     setState(() {
                                       value1!=value;
                                     });
                                   }),
                                   const Text("Sandwich")
                                 ]),
                           ],
                         ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                children: [
                                  Radio(value: 1, groupValue: value2, onChanged: (value){
                                    setState(() {
                                      value2!=value;
                                    });
                                  }),
                                  const Text("User")
                                ]),
                            Row(
                                children: [
                                  Radio(value: 2, groupValue: value2, onChanged: (value){
                                    setState(() {
                                      value2!=value;
                                    });
                                  }),

                                  const Text("Restaurant")
                                ]),
                            SizedBox(width: 2,),
                            Row(
                                children: [
                                  Radio(value: 3, groupValue: value2, onChanged: (value){
                                    setState(() {
                                      value2!=value;
                                    });
                                  }),
                                  const Text("Charity")
                                ]),
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
    );
  }
}
//ي