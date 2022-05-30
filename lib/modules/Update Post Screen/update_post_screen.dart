import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:group_radio_button/group_radio_button.dart';
import '../../shared/cubit/Food_Cubit/food_cubit.dart';
import '../../styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class UpdatePostScreen extends StatelessWidget {
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  PostModel postModel;

  UpdatePostScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    locationController.text = postModel.location!;
    dateController.text = postModel.pickupDate!;
    itemNameController.text = postModel.itemName!;
    descriptionController.text = postModel.description!;
    FoodCubit.get(context).foodType = postModel.foodType!;
    FoodCubit.get(context).contactMethod = postModel.contactMethod!;
    FoodCubit.get(context).itemQuantity = int.parse(postModel.itemQuantity!);

    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                onPressed: FoodCubit.get(context).itemQuantity >
                                        1
                                    ? () {
                                        FoodCubit.get(context).minusItemCount();
                                        if (FoodCubit.get(context)
                                                    .itemQuantity -
                                                int.parse(
                                                    postModel.itemQuantity!) ==
                                            -1) {
                                          FoodCubit.get(context)
                                              .enableEditButton(
                                                  isEnabled: true);
                                        }
                                        if (itemNameController.text ==
                                                postModel.itemName &&
                                            locationController.text ==
                                                postModel.location &&
                                            dateController.text ==
                                                postModel.pickupDate &&
                                            descriptionController.text ==
                                                postModel.description &&
                                            FoodCubit.get(context).foodType ==
                                                postModel.foodType &&
                                            FoodCubit.get(context)
                                                    .contactMethod ==
                                                postModel.contactMethod &&
                                            FoodCubit.get(context)
                                                    .itemQuantity
                                                    .toString() ==
                                                postModel.itemQuantity) {
                                          FoodCubit.get(context)
                                              .enableEditButton(
                                                  isEnabled: false);
                                        }
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.remove,
                                  size: 15,
                                  color:
                                      FoodCubit.get(context).itemQuantity == 1
                                          ? Colors.grey
                                          : defaultColor,
                                )),
                            Text(
                              "${FoodCubit.get(context).itemQuantity}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                            ),
                            IconButton(
                                onPressed: FoodCubit.get(context).itemQuantity <
                                        5
                                    ? () {
                                        FoodCubit.get(context)
                                            .incrementItemCount();
                                        if (FoodCubit.get(context)
                                                    .itemQuantity -
                                                int.parse(
                                                    postModel.itemQuantity!) ==
                                            1) {
                                          FoodCubit.get(context)
                                              .enableEditButton(
                                                  isEnabled: true);
                                        }
                                        if (itemNameController.text ==
                                                postModel.itemName &&
                                            locationController.text ==
                                                postModel.location &&
                                            dateController.text ==
                                                postModel.pickupDate &&
                                            descriptionController.text ==
                                                postModel.description &&
                                            FoodCubit.get(context).foodType ==
                                                postModel.foodType &&
                                            FoodCubit.get(context)
                                                    .contactMethod ==
                                                postModel.contactMethod &&
                                            FoodCubit.get(context)
                                                    .itemQuantity
                                                    .toString() ==
                                                postModel.itemQuantity) {
                                          FoodCubit.get(context)
                                              .enableEditButton(
                                                  isEnabled: false);
                                        }
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.add,
                                  size: 15,
                                  color:
                                      FoodCubit.get(context).itemQuantity == 5
                                          ? Colors.grey
                                          : defaultColor,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
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
                            onChange: (value) {
                              if (value!.length ==
                                      postModel.itemName!.length - 1 ||
                                  value.length ==
                                      postModel.itemName!.length + 1) {
                                FoodCubit.get(context)
                                    .enableEditButton(isEnabled: true);
                              }
                              if (itemNameController.text ==
                                      postModel.itemName &&
                                  locationController.text ==
                                      postModel.location &&
                                  dateController.text == postModel.pickupDate &&
                                  descriptionController.text ==
                                      postModel.description &&
                                  FoodCubit.get(context).foodType ==
                                      postModel.foodType &&
                                  FoodCubit.get(context).contactMethod ==
                                      postModel.contactMethod &&
                                  FoodCubit.get(context)
                                          .itemQuantity
                                          .toString() ==
                                      postModel.itemQuantity) {
                                FoodCubit.get(context)
                                    .enableEditButton(isEnabled: false);
                              }
                            },
                            rowText: AppLocalizations.of(context)!
                                .donateScreenNameFieldHeader,
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            icon: Icons.fastfood_outlined,
                            hintTextForm: AppLocalizations.of(context)!
                                .donateScreenNameFieldHint),

                        const SizedBox(
                          height: 15,
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
                            onChange: (value) {
                              if (value!.length ==
                                      postModel.location!.length - 1 ||
                                  value.length ==
                                      postModel.location!.length + 1) {
                                FoodCubit.get(context)
                                    .enableEditButton(isEnabled: true);
                              }
                              if (itemNameController.text ==
                                      postModel.itemName &&
                                  locationController.text ==
                                      postModel.location &&
                                  dateController.text == postModel.pickupDate &&
                                  descriptionController.text ==
                                      postModel.description &&
                                  FoodCubit.get(context).foodType ==
                                      postModel.foodType &&
                                  FoodCubit.get(context).contactMethod ==
                                      postModel.contactMethod &&
                                  FoodCubit.get(context)
                                          .itemQuantity
                                          .toString() ==
                                      postModel.itemQuantity) {
                                FoodCubit.get(context)
                                    .enableEditButton(isEnabled: false);
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
                        const SizedBox(
                          height: 15,
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
                                dateController.text =
                                    FoodCubit.get(context).date;
                                if (date.toString().length ==
                                        postModel.pickupDate!.length - 1 ||
                                    date.toString().length ==
                                        postModel.pickupDate!.length + 1) {
                                  FoodCubit.get(context)
                                      .enableEditButton(isEnabled: true);
                                }
                                if (itemNameController.text ==
                                        postModel.itemName &&
                                    locationController.text ==
                                        postModel.location &&
                                    dateController.text ==
                                        postModel.pickupDate &&
                                    descriptionController.text ==
                                        postModel.description &&
                                    FoodCubit.get(context).foodType ==
                                        postModel.foodType &&
                                    FoodCubit.get(context).contactMethod ==
                                        postModel.contactMethod &&
                                    FoodCubit.get(context)
                                            .itemQuantity
                                            .toString() ==
                                        postModel.itemQuantity) {
                                  FoodCubit.get(context)
                                      .enableEditButton(isEnabled: false);
                                }
                              },
                              onConfirm: (date) {
                                FoodCubit.get(context).changDateTime(date);
                                dateController.text =
                                    FoodCubit.get(context).date;
                                if (date.toString().length ==
                                        postModel.pickupDate!.length - 1 ||
                                    date.toString().length ==
                                        postModel.pickupDate!.length + 1) {
                                  FoodCubit.get(context)
                                      .enableEditButton(isEnabled: true);
                                }
                                if (itemNameController.text ==
                                        postModel.itemName &&
                                    locationController.text ==
                                        postModel.location &&
                                    dateController.text ==
                                        postModel.pickupDate &&
                                    descriptionController.text ==
                                        postModel.description &&
                                    FoodCubit.get(context).foodType ==
                                        postModel.foodType &&
                                    FoodCubit.get(context).contactMethod ==
                                        postModel.contactMethod &&
                                    FoodCubit.get(context)
                                            .itemQuantity
                                            .toString() ==
                                        postModel.itemQuantity) {
                                  FoodCubit.get(context)
                                      .enableEditButton(isEnabled: false);
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        /////////////////////////////////////Description/////////////////////////////////////

                        rowTextAndFormInput(
                            linesNumber: 5,
                            initialValue: null,
                            onChange: (value) {
                              if (value!.length ==
                                      postModel.description!.length - 1 ||
                                  value.length ==
                                      postModel.description!.length + 1) {
                                FoodCubit.get(context)
                                    .enableEditButton(isEnabled: true);
                              }
                              if (itemNameController.text ==
                                      postModel.itemName &&
                                  locationController.text ==
                                      postModel.location &&
                                  dateController.text == postModel.pickupDate &&
                                  descriptionController.text ==
                                      postModel.description &&
                                  FoodCubit.get(context).foodType ==
                                      postModel.foodType &&
                                  FoodCubit.get(context).contactMethod ==
                                      postModel.contactMethod &&
                                  FoodCubit.get(context)
                                          .itemQuantity
                                          .toString() ==
                                      postModel.itemQuantity) {
                                FoodCubit.get(context)
                                    .enableEditButton(isEnabled: false);
                              }
                            },
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
                        const SizedBox(
                          height: 15,
                        ),
                        ///////////////////////////////////// FoodType/////////////////////////////////////
                        const Text("Food Type:"),
                        RadioGroup<String>.builder(
                          activeColor: defaultColor,
                          direction: Axis.horizontal,
                          groupValue: FoodCubit.get(context).foodType,
                          horizontalAlignment: MainAxisAlignment.spaceBetween,
                          onChanged: (value) {
                            FoodCubit.get(context).changeFoodTypeValue(value);
                            if (value != postModel.foodType) {
                              FoodCubit.get(context)
                                  .enableEditButton(isEnabled: true);
                            }
                            if (itemNameController.text == postModel.itemName &&
                                locationController.text == postModel.location &&
                                dateController.text == postModel.pickupDate &&
                                descriptionController.text ==
                                    postModel.description &&
                                FoodCubit.get(context).foodType ==
                                    postModel.foodType &&
                                FoodCubit.get(context).contactMethod ==
                                    postModel.contactMethod &&
                                FoodCubit.get(context)
                                        .itemQuantity
                                        .toString() ==
                                    postModel.itemQuantity) {
                              FoodCubit.get(context)
                                  .enableEditButton(isEnabled: false);
                            }
                          },
                          items: FoodCubit.get(context).foodTypeList,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text("Contact Method"),
                        RadioGroup<String>.builder(
                          activeColor: defaultColor,
                          direction: Axis.horizontal,
                          groupValue: FoodCubit.get(context).contactMethod,
                          horizontalAlignment: MainAxisAlignment.spaceBetween,
                          onChanged: (value) {
                            FoodCubit.get(context)
                                .changeContactMethodValue(value);
                            if (value != postModel.contactMethod) {
                              FoodCubit.get(context)
                                  .enableEditButton(isEnabled: true);
                            }
                            if (itemNameController.text == postModel.itemName &&
                                locationController.text == postModel.location &&
                                dateController.text == postModel.pickupDate &&
                                descriptionController.text ==
                                    postModel.description &&
                                FoodCubit.get(context).foodType ==
                                    postModel.foodType &&
                                FoodCubit.get(context).contactMethod ==
                                    postModel.contactMethod &&
                                FoodCubit.get(context)
                                        .itemQuantity
                                        .toString() ==
                                    postModel.itemQuantity) {
                              FoodCubit.get(context)
                                  .enableEditButton(isEnabled: false);
                            }
                          },
                          items: FoodCubit.get(context).contactMethodList,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 150,
                              height: 40,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: MaterialButton(
                                disabledColor: Colors.grey[700],
                                color: defaultColor,
                                onPressed: FoodCubit.get(context)
                                        .editButtonIsEnabled
                                    ? () {
                                        if (formKey.currentState!.validate()) {
                                          if ((FoodCubit.get(context)
                                                          .contactMethod ==
                                                      'Phone' ||
                                                  FoodCubit.get(context)
                                                          .contactMethod ==
                                                      'Both') &&
                                              FirebaseAuth.instance.currentUser!
                                                  .phoneNumber!.isEmpty) {
                                            showToast(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .phoneNumberIsNotVerified,
                                                states: ToastStates.ERROR);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(AppLocalizations
                                                            .of(context)!
                                                        .phoneNumberIsNotVerified),
                                                    content: Text(AppLocalizations
                                                            .of(context)!
                                                        .phoneNumberIsNotVerifiedDialogContent),
                                                    actions: [
                                                      state
                                                              is PhoneVerificationCodeSendLoadingState
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : TextButton(
                                                              onPressed: () {
                                                                FoodCubit.get(
                                                                        context)
                                                                    .verifyPhoneNumber(
                                                                        FoodCubit.get(context)
                                                                            .userModel!
                                                                            .phone!,
                                                                        context);
                                                              },
                                                              child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .verifyButton)),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .cancelButton))
                                                    ],
                                                  );
                                                });
                                          } else {
                                            FoodCubit.get(context).updatePost(
                                              context: context,
                                              pickUpLocation:
                                                  locationController.text,
                                              itemName: itemNameController.text,
                                              pickUpDate: dateController.text,
                                              itemQuantity:
                                                  FoodCubit.get(context)
                                                      .itemQuantity
                                                      .toString(),
                                              description:
                                                  descriptionController.text,
                                              imageUrl1: postModel.imageUrl1!,
                                              imageUrl2: postModel.imageUrl2!,
                                              foodType: FoodCubit.get(context)
                                                  .foodType,
                                              contactMethod:
                                                  FoodCubit.get(context)
                                                      .contactMethod,
                                              postId: postModel.postId!,
                                            );
                                            Navigator.pop(context);
                                            FoodCubit.get(context)
                                                .currentIndex = 0;
                                            FoodCubit.get(context).date =
                                                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                                            FoodCubit.get(context).foodType =
                                                "Main dishes";
                                            FoodCubit.get(context)
                                                .contactMethod = "Phone";
                                            FoodCubit.get(context)
                                                .addPostPolicyIsChecked = false;
                                            locationController.text = '';
                                            itemNameController.text = '';
                                            descriptionController.text = '';
                                            dateController.text = '';
                                            FoodCubit.get(context)
                                                .itemQuantity = 1;
                                          }
                                        }
                                      }
                                    : null,
                                child: state is UpdatePostLoadingState
                                    ? const CircularProgressIndicator(
                                        color: defaultColor,
                                      )
                                    : Text(
                                        AppLocalizations.of(context)!
                                            .updateButton,
                                        style: const TextStyle(
                                            fontSize: 26,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                              ),
                            )),
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
