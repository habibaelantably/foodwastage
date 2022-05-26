import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/layout/App_Layout.dart';
import 'package:foodwastage/shared/constants.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Login/food_login_cubit.dart';
import 'package:foodwastage/shared/cubit/Login/food_login_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Register/register_Screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoodLoginCubit(),
      child: BlocConsumer<FoodLoginCubit, FoodLoginStates>(
          builder: (BuildContext context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(31.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/LoginIcon.png',
                        width: 500,
                        height: 300,
                      ),
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black),
                      ),
                      // SizedBox(height: 3.0,),
                      Text(
                        AppLocalizations.of(context)!.loginToContinue,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 15.0,
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
                        height: 10,
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
                          isPassword: FoodLoginCubit.get(context).isPassword,
                          prefix: Icons.vpn_key,
                          suffix: FoodLoginCubit.get(context).suffix,
                          suffixButton: () {
                            FoodLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          label: AppLocalizations.of(context)!
                              .loginScreenPasswordFieldLabel),
                      const SizedBox(
                        height: 17.0,
                      ),
                      BuildCondition(
                        condition: state is! FoodLoginLoadingState,
                        builder: (context) => defaultButton(
                            width: 300,
                            function: () {
                              if (formkey.currentState != null &&
                                  formkey.currentState!.validate()) {
                                FoodLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: AppLocalizations.of(context)!
                                .loginButton
                                .toUpperCase(),
                            context: context),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            AppLocalizations.of(context)!.or,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () =>
                                FoodLoginCubit.get(context).SignInWithGoogle(),
                            child: Image.asset(
                              'assets/images/googleLogo.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          InkWell(
                            onTap: () => FoodLoginCubit.get(context)
                                .SignInWithFacebook(),
                            child: const Icon(
                              Icons.facebook_rounded,
                              color: Colors.blue,
                              size: 55,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      Column(
                        children: [
                          Text(AppLocalizations.of(context)!
                              .loginScreenRegisterHint),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text(AppLocalizations.of(context)!
                                  .registerButton)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener: (BuildContext context, Object? state) {
        if (state is FoodLoginErrorState) {
          showToast(text: state.error.toString(), states: ToastStates.ERROR);
        }

        if (state is FoodLoginSuccessState ||
            state is FoodLoginGoogleSuccessState ||
            state is FoodSuccessCreateGoogleUserState ||
            state is FoodLoginFacebookSuccessState ||
            state is FoodSuccessCreateFacebookUserState) {
          if (uId != null) {
            FoodCubit.getLoggedInUser();
            FoodCubit.get(context).getUserdata(context: context);
            FoodCubit.get(context).getPosts();
            navigateAndKill(context, AppLayout());
          } else {
            FoodCubit.getLoggedInUser();
            navigateAndKill(context, AppLayout());
          }
        }
      }
//
          // if(state is AppSuccessState)
          // {
          //   if(state.loginModel.status==true)
          //   {
          //     print(state.loginModel.status);
          //     print(state.loginModel.message);
          //     //print(state.loginModel.data!.token);
          //     // showToast(states: ToastStates.SUCCESS,text:state.loginModel.message.toString() );
          //     cacheHelper.saveData
          //       (key: 'token',
          //         value: state.loginModel.data!.token)
          //         .then((value) {
          //       if(value){
          //
          //         token=state.loginModel.data!.token;
          //         NavigateAndKill(context, shopLayoutScreen());
          //       }
          //     });
          //
          //
          //   }else
          //   {
          //     print(state.loginModel.message);
          //
          //     showToast(states: ToastStates.ERROR,text:state.loginModel.message.toString() );
          //
          //   }
          //
          // }
          ),
    );
  }
}
