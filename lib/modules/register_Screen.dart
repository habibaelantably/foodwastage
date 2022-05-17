import 'package:buildcondition/buildcondition.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/components/reusable_components.dart';
import 'package:foodwastage/layout/Food_Layout.dart';
import 'package:foodwastage/modules/login_Screen.dart';
import 'package:foodwastage/network/local/cache_helper.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Register/food_register_cubit.dart';
import 'package:foodwastage/shared/cubit/Register/food_register_state.dart';

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
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                          label: 'name'),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter phone number';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                          label: 'phone'),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter email address';
                            }
                            return null;
                          },
                          prefix: Icons.email,
                          label: 'email'),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter password';
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
                          label: 'password'),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please confirm your password';
                            }
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          prefix: Icons.vpn_key_sharp,
                          label: 'Confirm Password'),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: countryController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your country';
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
                                print('Select country: ${country.displayName}');
                              },
                              countryListTheme: CountryListThemeData(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Start typing to search',
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
                        condition: state is! FoodLoadingRegisterState,
                        builder: (context) => defaultButton(
                          width: 250,
                          radius: 40.0,
                          function: () {
                            if (formkey.currentState != null &&
                                formkey.currentState!.validate()) {
                              FoodRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  country: countryController.text);
                            }
                          },
                          text: 'register'.toUpperCase(),
                          context: context,
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, LoginScreen());
                              },
                              child: const Text(
                                'login',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
        if (state is FoodSuccessCreateState) {
          FoodCubit.getLoggedInUser();
          navigateAndKill(context, const FoodLayout());
        }
      }),
    );
  }
}
