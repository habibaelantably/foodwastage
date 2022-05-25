import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/Register/register_Screen.dart';
import 'package:foodwastage/models/User_model.dart';
import 'food_register_state.dart';

class FoodRegisterCubit extends Cubit<FoodRegisterStates> {
  FoodRegisterCubit() : super(FoodInitialRegisterState());

  static FoodRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String country,
      }) {
    emit(FoodLoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          country: country,);
    }).catchError((error) {
      print(error.toString());
      emit(FoodErrorRegisterState());
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String country,
    String type = 'user',
    double rating = 0,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://media.istockphoto.com/photos/blue-open-sea-environmenttravel-and-nature-concept-picture-id1147989465?k=20&m=1147989465&s=612x612&w=0&h=nVI1UKhyr2WPZ5-gnFB3Q7jjToru4lg_ubBFx-Jomq0=',
      country: country,
      type: type,
      rating: rating
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

  EmailAuth emailAuth= EmailAuth(sessionName: 'test OTP session');
  void sendOTP(String? email)async
  {
    emit(FoodSendOTPLoadingState());
    var res= await emailAuth.sendOtp(recipientMail: email!,otpLength: 4);
    if(res){
      print('OTP Sent');
      emit(FoodSuccessSentOTPState());
    }else {
      print('failed to send');
      emit(FoodErrorSendOTPState());
    }
  }

  void verifyOTP(String? email,String? UserOTP){
    var res = emailAuth.validateOtp(recipientMail: email!, userOtp: UserOTP!);
    if(res){
      print('OTP verified');
      emit(FoodSuccessVerifyOTPState());
    }else{
      print('Invalid OTP');
      emit(FoodErrorVerifyOTPState());
    }
  }
}
