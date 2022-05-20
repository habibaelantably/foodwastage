import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/shared/cubit/Login/food_login_states.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FoodLoginCubit extends Cubit<FoodLoginStates> {
  FoodLoginCubit() : super(FoodLoginInitialState());

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
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(FoodLoginChangePasswordVisibilityState());
  }


  Future<String?> SignInWithGoogle()async{
    emit(FoodLoginWithGoogleLoadingstate());
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    //if (googleSignInAccount == null) return;
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential)
        .then((value){
      GoogleAccountExist(
          name: value.user!.displayName,
          email: value.user!.email,
          phone: value.user!.phoneNumber,
          uId: value.user!.uid,
          image: value.user!.photoURL,
          //rating: rating,
      );
    })
        .catchError((error){
      print(error.toString());

    });
  }
///////////////////////////////////////////
  bool? IsUserExist=false;
  Future <void> GoogleAccountExist({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
    required String? image,
    double rating=0.0,
     String? country='egypt',
     String? type='user',
  })async{
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element) {
        if(element.id==uId){
          IsUserExist=true;
          emit(FoodLoginGoogleSuccessState(uId!));
        }
      });
      if(IsUserExist==false){
        CreateGoogleSignInUser(
            name: name!,
            email: email!,
            phone: phone??'',
            uId: uId!,
            rating: rating ,
            type: type,
            country: country,
            image: image!,

        );
      }
    });
  }
////////////////////////////////////////////////////////
  void CreateGoogleSignInUser({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
    required String? image,
     required String? type,
    required double? rating,
    required String?country
  })
  {
    UserModel model=UserModel
      (name:name,
        email:email,
        phone:phone??'',
        uId:uId,
       type: type,
        rating: rating,
         country: country,
        image:image ?? 'https://media.istockphoto.com/photos/blue-open-sea-environmenttravel-and-nature-concept-picture-id1147989465?k=20&m=1147989465&s=612x612&w=0&h=nVI1UKhyr2WPZ5-gnFB3Q7jjToru4lg_ubBFx-Jomq0=',
    );

    FirebaseFirestore.instance.collection('users').
    doc(uId).
    set(model.toMap()).then((value) {
      emit(FoodSuccessCreateGoogleUserState(uId!));
    }).catchError((error){
      emit(FoodErrorCreateGoogleUserState());
    });

  }
///////////////////////////////////////////////////
  void SignInWithFacebook()async{
    emit(FoodLoginWithFacebookLoadingState());
    LoginResult result = await FacebookAuth.instance.login();
    final AuthCredential facebookCredential =
    FacebookAuthProvider.credential(result.accessToken!.token);
    FirebaseAuth.instance.signInWithCredential(facebookCredential)
        .then((value){
      FacebookAccountExist(
          name: value.user!.displayName,
          email: value.user!.email,
          phone: value.user!.phoneNumber,
          uId: value.user!.uid,
          image: value.user!.photoURL);
    })
        .catchError((error){
      print(error.toString());
      emit(FoodLoginFacebookErrorState(error.toString()));
    });
  }

  /////////////////////////////////////////////////////
  void FacebookAccountExist({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
    required String? image,
    double rating=0.0,
    String? country='egypt',
    String? type='user',
  })async{
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element) {
        if(element.id==uId){
          IsUserExist=true;
          emit(FoodLoginFacebookSuccessState(uId!));
        }
      });
      if(IsUserExist==false){
        CreateFacebookSignInUser(
          name: name!,
          email: email!,
          phone: phone??'',
          uId: uId!,
          image: image!,
          rating: rating ,
          type: type,
          country: country,);
      }
    });
  }
  /////////////////////////////////////////////////////
  void CreateFacebookSignInUser({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
    required String? type,
    required double? rating,
    required String?country,
    required String? image}) {
    UserModel model=UserModel
      (name:name,
        email:email,
        phone:phone??'',
        uId:uId,
      rating: rating ,
      type: type,
      country: country,
        image:image ?? 'https://media.istockphoto.com/photos/blue-open-sea-environmenttravel-and-nature-concept-picture-id1147989465?k=20&m=1147989465&s=612x612&w=0&h=nVI1UKhyr2WPZ5-gnFB3Q7jjToru4lg_ubBFx-Jomq0=',
    );

    FirebaseFirestore.instance.collection('users').
    doc(uId).
    set(model.toMap()).then((value) {
      emit(FoodSuccessCreateFacebookUserState(uId!));
    }).catchError((error){
      print(error.toString());
      emit(FoodErrorCreateFacebookUserState());
    });
  }

}
