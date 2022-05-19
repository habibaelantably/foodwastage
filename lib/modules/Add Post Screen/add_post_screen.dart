import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import '../../styles/colors.dart';

class AddPosts extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  AddPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    dateController.text = FoodCubit.get(context).date;
    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // first text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    defaultText(
                        text: AppLocalizations.of(context)!
                            .layoutAppBarTitleDonate,
                        fontSize: 26.0,
                        fontWeight: FontWeight.w800),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: FoodCubit.get(context).itemQuantity > 1 ? (){
                                FoodCubit.get(context).minusItemCount();
                              }: null,
                              icon: Icon(
                                Icons.remove,
                                size: 15,
                                color: FoodCubit.get(context).itemQuantity == 1 ? Colors.grey : defaultColor,
                              )),
                          Text(
                            "${FoodCubit.get(context).itemQuantity}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          IconButton(
                              onPressed:FoodCubit.get(context).itemQuantity < 5 ? () {
                                FoodCubit.get(context)
                                    .incrementItemCount();
                              }:null,
                              icon:  Icon(
                                Icons.add,
                                size: 15,
                                color: FoodCubit.get(context).itemQuantity == 5 ? Colors.grey : defaultColor,
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
                      /////////////////////////////////////Food Name/////////////////////////////////////

                      rowTextAndFormInput(
                          initialValue: null,
                          textEditingController: itemNameController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .donateScreenNameFieldValidation;
                            } else {
                              return null;
                            }
                          },
                          rowText: AppLocalizations.of(context)!
                              .donateScreenNameFieldHeader,
                          fontSize: 19,
                          fontWeight: FontWeight.normal,
                          icon: Icons.fastfood_outlined,
                          hintTextForm: AppLocalizations.of(context)!
                              .donateScreenNameFieldHint),

                      SizedBox(
                        height: size.height / 60,
                      ),
                      /////////////////////////////////////Location/////////////////////////////////////

                      rowTextAndFormInput(
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .donateScreenLocationFieldValidation;
                            } else {
                              return null;
                            }
                          },
                          initialValue: null,
                          textEditingController: locationController,
                          rowText: AppLocalizations.of(context)!
                              .donateScreenLocationFieldHeader,
                          fontSize: 19,
                          fontWeight: FontWeight.normal,
                          icon: Icons.add_location_alt_outlined,
                          hintTextForm: AppLocalizations.of(context)!
                              .donateScreenLocationFieldHint),
                      SizedBox(
                        height: size.height / 60,
                      ),

                      /////////////////////////////////////Date/////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          defaultText(
                              text: AppLocalizations.of(context)!
                                  .donateScreenDateFieldHeader,
                              fontSize: 19,
                              fontWeight: FontWeight.normal),
                          const Icon(Icons.date_range_outlined,
                              color: defaultColor),
                        ],
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: dateController,
                        readOnly: true,
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            currentTime: DateTime.now(),
                            locale: LocaleType.en,
                            maxTime: DateTime(2030, 1, 1),
                            minTime: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day),
                            onChanged: (date) {
                              FoodCubit.get(context).changDateTime(date);
                              dateController.text = FoodCubit.get(context).date;
                            },
                            onConfirm: (date) {
                              FoodCubit.get(context).changDateTime(date);
                              dateController.text = FoodCubit.get(context).date;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height / 120,
                      ),

                      /////////////////////////////////////Description/////////////////////////////////////

                      rowTextAndFormInput(
                        linesNumber: 5,
                          initialValue: null,
                          textEditingController: descriptionController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .donateScreenDescriptionFieldValidation;
                            } else if (value.toString().length <= 50) {
                              return AppLocalizations.of(context)!
                                  .donateScreenDescriptionFieldValidation2;
                            } else {
                              return null;
                            }
                          },
                          rowText: AppLocalizations.of(context)!
                              .donateScreenDescriptionFieldHeader,
                          fontSize: 19,
                          fontWeight: FontWeight.normal,
                          icon: Icons.description,
                          hintTextForm: AppLocalizations.of(context)!
                              .donateScreenDescriptionFieldHint),
                      SizedBox(
                        height: size.height / 60,
                      ),
                      /////////////////////////////////////Images/////////////////////////////////////
                      Text(
                        AppLocalizations.of(context)!
                            .donateScreenPhotoFieldHeader,
                        style: const TextStyle(fontSize: 19),
                      ),
                      SizedBox(
                        height: size.height / 90,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          if (FoodCubit.get(context).imageFile1 == null)
                            FoodCubit.get(context).imageFile2 != null
                                ? DottedBorder(
                                    color: defaultColor,
                                    strokeWidth: 2,
                                    dashPattern: const [
                                      3,
                                      3,
                                    ],
                                    child: InkWell(
                                      onTap: () {
                                        if (FoodCubit.get(context).imageFile1 ==
                                            null) {
                                          FoodCubit.get(context).getImage1();
                                        } else if (FoodCubit.get(context)
                                                .imageFile2 ==
                                            null) {
                                          FoodCubit.get(context).getImage2();
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
                                : const SizedBox()
                          else if (FoodCubit.get(context).imageFile1 != null)
                            Stack(
                              children: [
                                Container(
                                    decoration: const BoxDecoration(
                                        ),
                                    alignment: Alignment.center,
                                    width: size.width * .23,
                                    height: size.width * .23,
                                    //    padding: const EdgeInsets.all(16.0),
                                    child: Image.file(
                                      FoodCubit.get(context).imageFile1!,
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
                                          FoodCubit.get(context).deleteImage1();
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
                          const SizedBox(
                            width: 10,
                          ),
                          if (FoodCubit.get(context).imageFile2 == null)
                            DottedBorder(
                              color: defaultColor,
                              strokeWidth: 2,
                              dashPattern: const [
                                3,
                                3,
                              ],
                              child: InkWell(
                                onTap: () {
                                  if (FoodCubit.get(context).imageFile1 ==
                                      null) {
                                    FoodCubit.get(context).getImage1();
                                  } else if (FoodCubit.get(context)
                                          .imageFile2 ==
                                      null) {
                                    FoodCubit.get(context).getImage2();
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
                                        ),
                                    alignment: Alignment.center,
                                    width: size.width * .23,
                                    height: size.width * .23,
                                    //    padding: const EdgeInsets.all(16.0),
                                    child: ClipRRect(
                                      child: Image.file(
                                        FoodCubit.get(context).imageFile2!,
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
                                          FoodCubit.get(context).deleteImage2();
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
                      ///////////////////////////////////// FoodType/////////////////////////////////////
                      const Text("Food Type:"),
                      RadioGroup<String>.builder(
                        activeColor: defaultColor,
                        direction: Axis.horizontal,
                        groupValue: FoodCubit.get(context).foodType,
                        horizontalAlignment: MainAxisAlignment.spaceBetween,
                        onChanged: (value) => FoodCubit.get(context)
                            .changeFoodTypeValue(value),
                        items: FoodCubit.get(context).foodTypeList,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                      const SizedBox(height: 5.0,),
                      const Text("Contact Method"),
                      RadioGroup<String>.builder(
                        activeColor: defaultColor,
                        direction: Axis.horizontal,
                        groupValue: FoodCubit.get(context).contactMethod,
                        horizontalAlignment: MainAxisAlignment.spaceBetween,
                        onChanged: (value) => FoodCubit.get(context)
                            .changeContactMethodValue(value),
                        items: FoodCubit.get(context).contactMethodList,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                      /////////////////////////////////////Assure Quality/////////////////////////////////////
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              FoodCubit.get(context).donatePolicyCheck();
                            },
                            child: Icon(
                              FoodCubit.get(context).addPostPolicyIsChecked ==
                                      false
                                  ? Icons.radio_button_unchecked_outlined
                                  : Icons.check_circle_outline,
                              color: defaultColor,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                               AppLocalizations.of(context)!
                                  .donateScreenPolicy,
                              style: TextStyle(
                                  fontSize: size.width * 0.03,
                                  fontWeight: FontWeight.normal
                              ),)
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: size.width / 2,
                          decoration: const BoxDecoration(),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              onPressed: () {
                                if (FoodCubit.get(context)
                                        .addPostPolicyIsChecked ==
                                    false) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text(AppLocalizations.of(
                                                    context)!
                                                .donateScreenPolicyValidationDialogTitle),
                                            content: Text(AppLocalizations.of(
                                                    context)!
                                                .donateScreenPolicyValidationDialogDescription),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: defaultText(
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .dialogOkButton,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold))
                                            ],
                                          ));
                                }
                                if (formKey.currentState!.validate() &&
                                    FoodCubit.get(context)
                                            .addPostPolicyIsChecked ==
                                        true) {
                                  FoodCubit.get(context).addPost(
                                      postDate: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                      location: locationController.text,
                                      itemName: itemNameController.text,
                                      pickupDate: FoodCubit.get(context).date,
                                      foodQuantity: FoodCubit.get(context).itemQuantity.toString(),
                                      description: descriptionController.text,
                                      imageUrl1: "imageUrl1",
                                      imageUrl2: "imageUrl2",
                                      foodType: FoodCubit.get(context).foodType,
                                      contactMethod: FoodCubit.get(context).contactMethod,
                                      foodDonor: FoodCubit.get(context)
                                          .userModel!
                                          .type!);
                                  FoodCubit.get(context).currentIndex = 0;
                                  FoodCubit.get(context).date =
                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                                  FoodCubit.get(context).foodType = "Main dishes";
                                  FoodCubit.get(context)
                                      .addPostPolicyIsChecked = false;
                                  locationController.text = '';
                                  itemNameController.text = '';
                                  descriptionController.text = '';
                                  FoodCubit.get(context).itemQuantity = 1;
                                }
                              },
                              child: state is CreatePostLoadingState
                                  ? SizedBox(
                                      height: size.width * .05,
                                      width: size.width * .05,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                       AppLocalizations.of(context)!
                                          .submitButton,
                                      style: const TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400
                                      ),
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
