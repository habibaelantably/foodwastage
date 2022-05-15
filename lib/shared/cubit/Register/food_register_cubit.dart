import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/modules/register_Screen.dart';
import 'package:foodwastage/shared/cubit/Register/food_register_state.dart';

class FoodRegisterCubit extends Cubit<FoodRegisterStates> {
  FoodRegisterCubit() : super(FoodIntialRegisterState());

  static FoodRegisterCubit get(context) => BlocProvider.of(context);

  // ShopLoginModel? loginModel;

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String country}) {
    emit(FoodLoadingRegisterstate());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          country: country);
    }).catchError((error) {
      print(error.toString());
      emit(FoodErrorRegisterState());
    });
  }

//
  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String country,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://media.istockphoto.com/photos/blue-open-sea-environmenttravel-and-nature-concept-picture-id1147989465?k=20&m=1147989465&s=612x612&w=0&h=nVI1UKhyr2WPZ5-gnFB3Q7jjToru4lg_ubBFx-Jomq0=',
      country: country,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(FoodSuccessCreateState(uId));
    }).catchError((error) {
      print(error.toString() + '**************');
      print(RegisterScreen().confirmPasswordController.text.toString() +
          "*************************************");
      emit(FoodErrorCreateState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibilityRegister() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(FoodChangePasswordVisibilityRegisterState());
  }
}
