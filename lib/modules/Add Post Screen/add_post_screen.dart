import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  AddPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                        text: AppLocalizations.of(context)!.layoutAppBarTitleDonate,
                        fontWeight: FontWeight.w800,
                        color: KBlack,
                        fontSize: 26),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                FoodCubit.get(context)
                                    .minusItemCount(quantityController);
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 15,
                                color: defaultColor,
                              )),
                          defaultText(
                              text: "${FoodCubit.get(context).itemCount}",
                              fontSize: 15,
                              color: KBlack,
                              fontWeight: FontWeight.normal),
                          IconButton(
                              onPressed: () {
                                FoodCubit.get(context)
                                    .incrementItemCount(quantityController);
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

                      /////////////////////////////////////Food Name/////////////////////////////////////

                      rowTextAndFormInput(
                          initialValue: null,
                          textEditingController: foodNameController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return AppLocalizations.of(context)!.donateScreenNameFieldValidation;
                            } else {
                              return null;
                            }
                          },
                          rowText: AppLocalizations.of(context)!.donateScreenNameFieldHeader,
                          fontSize: 19,
                          color: KBlack,
                          fontWeight: FontWeight.normal,
                          icon: Icons.fastfood_outlined,
                          hintTextForm: AppLocalizations.of(context)!.donateScreenNameFieldHint),
                      SizedBox(
                        height: size.height / 60,
                      ),
                      /////////////////////////////////////Location/////////////////////////////////////

                      rowTextAndFormInput(
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return AppLocalizations.of(context)!.donateScreenLocationFieldValidation;
                            } else {
                              return null;
                            }
                          },
                          initialValue: null,
                          textEditingController: locationController,
                          rowText: AppLocalizations.of(context)!.donateScreenLocationFieldHeader,
                          fontSize: 19,
                          color: KBlack,
                          fontWeight: FontWeight.normal,
                          icon: Icons.add_location_alt_outlined,
                          hintTextForm: AppLocalizations.of(context)!.donateScreenLocationFieldHint),
                      SizedBox(
                        height: size.height / 60,
                      ),

                      /////////////////////////////////////Date/////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          defaultText(
                              text: AppLocalizations.of(context)!.donateScreenDateFieldHeader,
                              fontSize: 19,
                              color: KBlack,
                              fontWeight: FontWeight.normal),
                          const Icon(Icons.date_range_outlined,
                              color: defaultColor),
                        ],
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        readOnly: true,
                        initialValue: FoodCubit.get(context).date,
                        onTap: (){
                          DatePicker.showDatePicker(
                            context,
                            currentTime: DateTime.now(),
                            locale: LocaleType.en,
                            maxTime: DateTime(2030, 1, 1),
                            minTime: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day),
                            onChanged: (date) {
                              FoodCubit.get(context).changDateTime(date);
                            },
                            onConfirm: (date) {
                              FoodCubit.get(context).changDateTime(date);
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height / 120,
                      ),
                      /////////////////////////////////////Quantity/////////////////////////////////////
                      rowTextAndFormInput(
                          initialValue: null,
                          validator: (value) {
                            if (value == 0 ||
                                quantityController.text.isEmpty) {
                              return AppLocalizations.of(context)!.donateScreenQuantityFieldValidation;
                            } else {
                              return null;
                            }
                          },
                          textEditingController: quantityController,
                          textInputType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          rowText: AppLocalizations.of(context)!.donateScreenQuantityFieldHeader,
                          fontSize: 19,
                          color: KBlack,
                          fontWeight: FontWeight.normal,
                          icon: Icons.list_alt,
                          hintTextForm: AppLocalizations.of(context)!.donateScreenQuantityFieldHint),
                      SizedBox(
                        height: size.height / 65,
                      ),
                      /////////////////////////////////////Description/////////////////////////////////////

                      rowTextAndFormInput(
                          initialValue: null,
                          textEditingController: descriptionController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return AppLocalizations.of(context)!.donateScreenDescriptionFieldValidation;
                            } else if (value.toString().length <= 50) {
                              return AppLocalizations.of(context)!.donateScreenDescriptionFieldValidation2;
                            } else {
                              return null;
                            }
                          },
                          rowText: AppLocalizations.of(context)!.donateScreenDescriptionFieldHeader,
                          fontSize: 19,
                          color: KBlack,
                          fontWeight: FontWeight.normal,
                          icon: Icons.description,
                          hintTextForm: AppLocalizations.of(context)!.donateScreenDescriptionFieldHint),
                      SizedBox(
                        height: size.height / 60,
                      ),
                      /////////////////////////////////////Images/////////////////////////////////////
                      Text(
                        AppLocalizations.of(context)!.donateScreenPhotoFieldHeader,
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
                                  if (FoodCubit.get(context)
                                      .imageFile1 ==
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
                                          FoodCubit.get(context)
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
                                          FoodCubit.get(context)
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
                      /////////////////////////////////////FoodDonor And FoodType/////////////////////////////////////
                      RadioGroup<String>.builder(
                        activeColor: KBlack,
                        direction: Axis.horizontal,
                        groupValue: FoodCubit.get(context).foodType,
                        horizontalAlignment: MainAxisAlignment.spaceAround,
                        onChanged: (value) => FoodCubit.get(context)
                            .changeVerticalGroupValue(value),
                        items: FoodCubit.get(context).status,
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
                        groupValue: FoodCubit.get(context).foodDonor,
                        horizontalAlignment: MainAxisAlignment.spaceAround,
                        onChanged: (value) {
                          FoodCubit.get(context)
                              .changeVerticalGroupValue2(value);
                        },
                        items: FoodCubit.get(context).status2,
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),

                      /////////////////////////////////////Assure Quality/////////////////////////////////////
                      const SizedBox(height: 10.0,),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              FoodCubit.get(context).check();
                            },
                            child: Icon(
                              FoodCubit.get(context).isChecked == false
                                  ? Icons.radio_button_unchecked_outlined
                                  : Icons.check_circle_outline,
                              color: defaultColor,
                            ),
                          ),
                          defaultText(
                              text:
                              AppLocalizations.of(context)!.donateScreenPolicy,
                              fontSize: size.width * 0.03,
                              color: KBlack,
                              fontWeight: FontWeight.normal)
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: size.width / 2,
                          decoration: const BoxDecoration(),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // <-- Radius
                                ),
                              ),
                              onPressed: () {
                                if (FoodCubit.get(context).isChecked ==
                                    false) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title:
                                        Text(AppLocalizations.of(context)!.donateScreenPolicyValidationDialogTitle),
                                        content: Text(
                                            AppLocalizations.of(context)!.donateScreenPolicyValidationDialogDescription),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: defaultText(
                                                  text: AppLocalizations.of(context)!.dialogOkButton,
                                                  fontSize: 20,
                                                  color: KBlack,
                                                  fontWeight:
                                                  FontWeight.bold))
                                        ],
                                      ));
                                }
                                if (formKey.currentState!.validate() &&
                                    FoodCubit.get(context).isChecked ==
                                        true) {
                                  FoodCubit.get(context).addPost(
                                    itemCount:
                                    FoodCubit.get(context).itemCount,
                                    location: locationController.text,
                                    itemName: foodNameController.text,
                                    postDate: FoodCubit.get(context).date,
                                    quantity: FoodCubit.get(context)
                                        .itemCount
                                        .toString(),
                                    description: descriptionController.text,
                                    imageUrl1: "imageUrl1",
                                    imageUrl2: "imageUrl2",
                                    foodType:
                                    FoodCubit.get(context).foodType,
                                    foodDonor:
                                    FoodCubit.get(context).foodDonor,
                                  );
                                }
                              },
                              child: state is CreatePostLoadingState
                                  ? SizedBox(
                                height: size.width * .05,
                                width: size.width * .05,
                                child:
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                                  : defaultText(
                                  text: AppLocalizations.of(context)!.submitButton,
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
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
