import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/shared/cubit/Post/post_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../components/constants.dart';
import '../../../network/local/Cach_helper.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitialState());

  static PostCubit get(context) => BlocProvider.of(context);
  CollectionReference posts =
      FirebaseFirestore.instance.collection(postsCollectionKey);
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  ////////////////////////////////////////////////
  int itemCount = 0;

  String date = DateFormat('yMd').format(DateTime.now());

  String foodType = "Main dishes";
  String foodDonor = "User";

  List<String> status = ["Main dishes", "Desert", "Sandwich"];
  List<String> status2 = ["User", "Restaurant", "Charity"];

  bool isChecked = false;

  var uId = CacheHelper.getData(key: 'uId');

  check() {
    isChecked = !isChecked;
    emit(IsCheckedState());
  }

  minusItemCount(TextEditingController quantityController) {
    if (itemCount != 0) {
      itemCount--;
      quantityController.text = itemCount.toString();
    }
    // else {
    //   itemCount = quantityController.text as int;
    // }
    emit(CounterIncrementState());
  }

  incrementItemCount(TextEditingController quantityController) {
    itemCount++;
    quantityController.text = itemCount.toString();
    //   itemCount= quantityController.text as int ;

    emit(CounterMinusState());
  }



  changDateTime(date) {
    this.date = "${date.year}-${date.month}-${date.day}";
    emit(ChangeDateTimeState());
  }

  changeVerticalGroupValue(value) {
    foodType = value;
    emit(ChangeVerticalGroupValue());
  }

  changeVerticalGroupValue2(value) {
    foodDonor = value;
    emit(ChangeVerticalGroupValue2());
  }

////////////////////////////////////////////////////////////get images
  final ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;

  getImage1() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile1 = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print("No Image Selected");
      emit(PostImagePickedErrorState());
    }
  }

  getImage2() async {
    final _pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      imageFile2 = File(_pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print("No Image Selected");
      emit(PostImagePickedErrorState());
    }
  }

  deleteImage1() {
    imageFile1 = null;
    emit(DeleteImage1State());
  }

  deleteImage2() {
    imageFile2 = null;
    emit(DeleteImage2State());
  }

  ///////////////////////////////////////upload post data
  Future<void> addPost({
    required int itemCount,
    required String location,
    required String itemName,
    required String postDate,
    required String quantity,
    required String description,
    required String imageUrl1,
    required String imageUrl2,
    required String foodType,
    required String foodDonor,
  }) async {
    emit(CreatePostLoadingState());

    PostModel postModel = PostModel(
        description: description,
        foodDonor: foodDonor,
        foodType: foodType,
        imageUrl1: imageUrl1,
        imageUrl2: imageUrl2,
        itemCount: itemCount,
        itemName: itemName,
        location: location,
        postDate: postDate,
        quantity: itemCount.toString(),
        donorId: uId);
    posts.add(postModel.toMap()).then((idValue) async {
      if (imageFile1 != null) {
        await uploadImage(imageFile1!, idValue.id, "imageUrl1").then((value) {
          if (imageFile2 != null) {
            uploadImage(imageFile2!, idValue.id, "imageUrl2").then((value) {
              emit(CreatePostSuccessState());
            }).catchError((onError) {
              emit(CreatePostErrorState(onError.toString()));
            });
          }
        }).catchError((onError) {
          emit(CreatePostErrorState(onError.toString()));
        });
      } else if (imageFile2 != null) {
        await uploadImage(imageFile2!, idValue.id, "imageUrl2").then((value) {
          if (imageFile1 != null) {
            uploadImage(imageFile1!, idValue.id, "imageUrl1").then((value) {
              emit(CreatePostSuccessState());
            }).catchError((onError) {
              emit(CreatePostErrorState(onError.toString()));
            });
          }
        }).catchError((onError) {
          emit(CreatePostErrorState(onError.toString()));
        });
      }
      emit(CreatePostSuccessState());
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: "Post Uploaded Successfully",
        backgroundColor: Colors.green,
      );
    }).catchError((onError) {
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: "Please try again",
        backgroundColor: Colors.green,
      );
      emit(CreatePostErrorState(onError.toString()));
    });
    return;
  }

  Future uploadImage(File image, postId, String imageNum) async {
    await storage
        .ref()
        .child(
            "$postsCollectionKey/$postId/Images/${Uri.file(image.path).pathSegments.last}")
        .putFile(image)
        .then((url) {
      url.ref.getDownloadURL().then((value) {
        updateImage(postId, {"$imageNum": value.toString()});
      });
    });
  }

  updateImage(postId, Map<String, String> imageUrl) {
    posts.doc(postId).update(imageUrl);
  }

  /////////////////////////////////////updatePost

  //لازم تمرر الid بتاع البوست علسان تupdate بيه
  Future<void> updatePost({
    required String postId, //<<<<<
    required int itemCount,
    required String location,
    required String itemName,
    required String postDate,
    required String quantity,
    required String description,
    required String imageUrl1,
    required String imageUrl2,
    required String foodType,
    required String foodDonor,
  }) async {
    emit(UpdatePostLoadingState());

    PostModel postModel = PostModel(
        description: description,
        foodDonor: foodDonor,
        foodType: foodType,
        imageUrl1: imageUrl1,
        imageUrl2: imageUrl2,
        itemCount: itemCount,
        itemName: itemName,
        location: location,
        postDate: postDate,
        quantity: quantity,
        donorId: uId);
    posts.doc(postId).update(postModel.toMap()).then((idValue) async {
      if (imageFile1 != null) {
        await uploadImage(imageFile1!, postId, "imageUrl1").then((value) {
          if (imageFile2 != null) {
            uploadImage(imageFile2!, postId, "imageUrl2").then((value) {
              emit(UpdatePostSuccessState());
            }).catchError((onError) {
              emit(UpdatePostErrorState(onError.toString()));
            });
          }
        }).catchError((onError) {
          emit(UpdatePostErrorState(onError.toString()));
        });
      } else if (imageFile2 != null) {
        await uploadImage(imageFile2!, postId, "imageUrl2").then((value) {
          if (imageFile1 != null) {
            uploadImage(imageFile1!, postId, "imageUrl1").then((value) {
              emit(UpdatePostSuccessState());
            }).catchError((onError) {
              emit(UpdatePostErrorState(onError.toString()));
            });
          }
        }).catchError((onError) {
          emit(UpdatePostErrorState(onError.toString()));
        });
      }
      emit(UpdatePostSuccessState());
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: "Post Updated Successfully",
        backgroundColor: Colors.green,
      );
    }).catchError((onError) {
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: "$onError <<Please try again>>",
        backgroundColor: Colors.green,
      );
      emit(UpdatePostErrorState(onError.toString()));
    });
    return;
  }
}
