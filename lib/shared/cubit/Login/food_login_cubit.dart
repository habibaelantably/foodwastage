import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/shared/cubit/Login/food_login_states.dart';

class FoodLoginCubit extends Cubit<FoodLoginStates> {
  FoodLoginCubit() : super(FoodLoginIntialState());

  static FoodLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(FoodLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(FoodLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(FoodLoginErrorState(error.toString()));
    });
  }

//
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(FoodLoginChangePasswordVisibilityState());
  }
}
