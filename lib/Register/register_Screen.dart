import 'package:buildcondition/buildcondition.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/Register/OTP.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/modules/login_Screen.dart';
import 'package:foodwastage/shared/cubit/Register/food_register_cubit.dart';
import 'package:foodwastage/shared/cubit/Register/food_register_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodwastage/styles/colors.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var countryController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoodRegisterCubit(),
      child: BlocConsumer<FoodRegisterCubit, FoodRegisterStates>(
          builder: (BuildContext context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70.0,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .registerButton
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: defaultColor,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .registerScreenNameFieldValidation;
                            }
                            return null;
                          },
                          prefix: Icons.person,
                          label: AppLocalizations.of(context)!
                              .donateScreenNameFieldHint),
                      const SizedBox(
                        height: 15,
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
                          prefix: Icons.phone,
                          label: AppLocalizations.of(context)!
                              .registerScreenPhoneFieldLabel),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .loginScreenEmailFieldValidation;
                            }
                            return null;
                          },
                          prefix: Icons.email,
                          label: AppLocalizations.of(context)!
                              .loginScreenEmailFieldLabel),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .loginScreenPasswordFieldValidation;
                            }
                            return null;
                          },
                          isPassword: FoodRegisterCubit.get(context).isPassword,
                          prefix: Icons.vpn_key,
                          suffix: FoodRegisterCubit.get(context).suffix,
                          suffixButton: () {
                            FoodRegisterCubit.get(context)
                                .changePasswordVisibilityRegister();
                          },
                          label: AppLocalizations.of(context)!
                              .loginScreenPasswordFieldLabel),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .loginScreenPasswordFieldValidation;
                            }
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              return AppLocalizations.of(context)!
                                  .registerScreenConfirmPasswordFieldValidation;
                            }
                            return null;
                          },
                          prefix: Icons.vpn_key_sharp,
                          label: AppLocalizations.of(context)!
                              .registerScreenConfirmPasswordFieldLabel),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: countryController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .registerScreenCountryFieldValidation;
                            }
                            return null;
                          },
                          prefix: Icons.vpn_lock,
                          label: 'Country',
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              showWorldWide: false,
                              onSelect: (Country country) {
                                countryController.text =
                                    country.displayNameNoCountryCode.toString();
                              },
                              countryListTheme: CountryListThemeData(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .registerScreenCountryFieldSearchLabel,
                                  hintText: AppLocalizations.of(context)!
                                      .registerScreenCountryFieldSearchHint,
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 40.0,
                      ),
                      BuildCondition(
                        condition: state is! FoodSendOTPLoadingState ,
                        builder: (context)=>defaultButton(
                            function:()
                            {
                              if(formkey.currentState != null && formkey.currentState!.validate())
                              {
                                FoodRegisterCubit.get(context).sendOTP(emailController.text);

                              }
                            },
                            text: AppLocalizations.of(context)!
                                .registerButton
                                .toUpperCase(),
                          context: context,
                        ),

                        fallback: (context)=>Center(child: CircularProgressIndicator()),

                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .registerScreenLoginHint,
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, LoginScreen());
                              },
                              child: Text(
                                AppLocalizations.of(context)!.loginButton,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                    //
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener: (BuildContext context, Object? state) {
        if(state is FoodSuccessSentOTPState)
        {
          navigateTo(context, OTP(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            phone: phoneController.text,
            country:countryController.text

          ));
        }
      }),
    );
  }
}
