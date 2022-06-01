import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:foodwastage/styles/colors.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();

  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodCubit.get(context).profileImage = null;

    nameController.text = FoodCubit.get(context).userModel!.name!;
    phoneController.text = FoodCubit.get(context).userModel!.phone!;
    emailController.text = FoodCubit.get(context).userModel!.email!;
    countryController.text = FoodCubit.get(context).userModel!.country!;

    return BlocConsumer<FoodCubit, FoodStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileImage = FoodCubit.get(context).profileImage;
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.editProfile),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: profileImage != null
                          ? AlignmentDirectional.topEnd
                          : AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 90,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          backgroundImage: profileImage == null
                              ? NetworkImage(
                                  "${FoodCubit.get(context).userModel!.image}")
                              : FileImage(profileImage) as ImageProvider,
                        ),
                        profileImage != null
                            ? CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    FoodCubit.get(context).deleteProfileImage();
                                  },
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 30,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 26,
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: defaultColor,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      FoodCubit.get(context)
                                          .pickProfileImage(context);
                                    },
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    FoodCubit.get(context).userModel!.name!,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .registerScreenNameFieldValidation;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value!.length ==
                                FoodCubit.get(context).userModel!.name!.length -
                                    1 ||
                            value.length ==
                                FoodCubit.get(context).userModel!.name!.length +
                                    1) {
                          FoodCubit.get(context)
                              .enableEditButton(isEnabled: true);
                        }
                        if (nameController.text ==
                                FoodCubit.get(context).userModel!.name &&
                            phoneController.text ==
                                FoodCubit.get(context).userModel!.phone &&
                            emailController.text ==
                                FoodCubit.get(context).userModel!.email &&
                            countryController.text ==
                                FoodCubit.get(context).userModel!.country &&
                            profileImage == null) {
                          FoodCubit.get(context)
                              .enableEditButton(isEnabled: false);
                        }
                      },
                      prefix: Icons.person,
                      label: AppLocalizations.of(context)!
                          .donateScreenNameFieldHint),
                  const SizedBox(
                    height: 5,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .registerScreenPhoneFieldValidation;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value!.length ==
                                FoodCubit.get(context)
                                        .userModel!
                                        .phone!
                                        .length -
                                    1 ||
                            value.length ==
                                FoodCubit.get(context)
                                        .userModel!
                                        .phone!
                                        .length +
                                    1) {
                          FoodCubit.get(context)
                              .enableEditButton(isEnabled: true);
                        }
                        if (nameController.text ==
                                FoodCubit.get(context).userModel!.name &&
                            phoneController.text ==
                                FoodCubit.get(context).userModel!.phone &&
                            emailController.text ==
                                FoodCubit.get(context).userModel!.email &&
                            countryController.text ==
                                FoodCubit.get(context).userModel!.country &&
                            FoodCubit.get(context).profileImage == null) {
                          FoodCubit.get(context)
                              .enableEditButton(isEnabled: false);
                        }
                      },
                      prefix: Icons.phone,
                      label: AppLocalizations.of(context)!
                          .registerScreenPhoneFieldLabel),
                  const SizedBox(
                    height: 5,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .loginScreenEmailFieldValidation;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value!.length ==
                                FoodCubit.get(context)
                                        .userModel!
                                        .email!
                                        .length -
                                    1 ||
                            value.length ==
                                FoodCubit.get(context)
                                        .userModel!
                                        .email!
                                        .length +
                                    1) {
                          FoodCubit.get(context)
                              .enableEditButton(isEnabled: true);
                        }
                        if (nameController.text ==
                                FoodCubit.get(context).userModel!.name &&
                            phoneController.text ==
                                FoodCubit.get(context).userModel!.phone &&
                            emailController.text ==
                                FoodCubit.get(context).userModel!.email &&
                            countryController.text ==
                                FoodCubit.get(context).userModel!.country &&
                            FoodCubit.get(context).profileImage == null) {
                          FoodCubit.get(context)
                              .enableEditButton(isEnabled: false);
                        }
                      },
                      prefix: Icons.email,
                      label: AppLocalizations.of(context)!
                          .loginScreenEmailFieldLabel),
                  const SizedBox(
                    height: 5,
                  ),
                  defaultFormField(
                      controller: countryController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .registerScreenCountryFieldLabel;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value!.length ==
                                FoodCubit.get(context)
                                        .userModel!
                                        .country!
                                        .length -
                                    1 ||
                            value.length ==
                                FoodCubit.get(context)
                                        .userModel!
                                        .country!
                                        .length +
                                    1) {
                          FoodCubit.get(context)
                              .enableEditButton(isEnabled: true);
                        }
                        if (nameController.text ==
                                FoodCubit.get(context).userModel!.name &&
                            phoneController.text ==
                                FoodCubit.get(context).userModel!.phone &&
                            emailController.text ==
                                FoodCubit.get(context).userModel!.email &&
                            countryController.text ==
                                FoodCubit.get(context).userModel!.country &&
                            FoodCubit.get(context).profileImage == null) {
                          FoodCubit.get(context)
                              .enableEditButton(isEnabled: false);
                        }
                      },
                      prefix: Icons.vpn_lock,
                      label: AppLocalizations.of(context)!
                          .registerScreenCountryFieldLabel,
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          showWorldWide: false,
                          onSelect: (Country country) {
                            countryController.text =
                                country.displayNameNoCountryCode.toString();
                          },
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          height: 50,
                          color: defaultColor,
                          disabledColor: Colors.grey[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: FoodCubit.get(context)
                                      .editButtonIsEnabled &&
                                  state is! UpdateUserLoadingState
                              ? () async {
                                  await FoodCubit.get(context).updateUser(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      country: countryController.text,
                                      context: context);
                                  FoodCubit.get(context)
                                      .enableEditButton(isEnabled: false);
                                  FoodCubit.get(context).profileImage = null;
                                }
                              : null,
                          child: state is UpdateUserLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  AppLocalizations.of(context)!
                                      .editButton
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
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
