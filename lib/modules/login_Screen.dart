import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/components/constants.dart';
import 'package:foodwastage/components/reusable_components.dart';
import 'package:foodwastage/layout/food_Layout.dart';
import 'package:foodwastage/modules/register_Screen.dart';
import 'package:foodwastage/network/local/cache_helper.dart';
import 'package:foodwastage/shared/cubit/Login/food_login_cubit.dart';
import 'package:foodwastage/shared/cubit/Login/food_login_states.dart';

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
                          'WELCOME',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                        // SizedBox(height: 3.0,),
                        Text(
                          'LOGIN TO CONTINUE ',
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
                                return 'please enter email address';
                              }
                              return null;
                            },
                            prefix: Icons.email,
                            label: 'Email Address'),
                        const SizedBox(
                          height: 10,
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
                            isPassword: FoodLoginCubit.get(context).isPassword,
                            prefix: Icons.vpn_key,
                            suffix: FoodLoginCubit.get(context).suffix,
                            suffixButton: () {
                              FoodLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            label: 'password'),
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
                              text: 'login'.toUpperCase()),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1.0,
                              width: 150.0,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Text(
                              'or',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Container(
                              height: 1.0,
                              width: 150.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/googleLogo.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(
                              width: 40.0,
                            ),
                            //Image.asset('assets/images/googleLogo.png',width: 50,height: 50,),
                            const Icon(
                              Icons.facebook_rounded,
                              color: Colors.blue,
                              size: 55,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        Column(
                          children: [
                            const Text('Don`t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text('Register')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is FoodLoginErrorState) {
            showToast(text: state.error.toString(), states: ToastStates.ERROR);
          }
          if (state is FoodLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              if (value) {
                uId = CacheHelper.getData(key: 'uId');
                navigateAndKill(context, const foodLayout());
              }
            });
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
        },
      ),
    );
  }
}
