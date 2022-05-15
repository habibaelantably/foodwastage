import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../components/constants.dart';
import '../../../components/reusable_components.dart';
import '../../../modules/Add Post Screen/add_post_screen.dart';
import '../../../modules/Chats Screen/chats_screen.dart';
import '../../../modules/Favorites Screen/favorites_screen.dart';
import '../../../modules/Home Screen/home_screen.dart';
import '../../../modules/Maps Screen/maps_screen.dart';
import 'food_states.dart';

class FoodCubit extends Cubit<FoodStates> {
  FoodCubit() : super(InitialFoodStates());

  static FoodCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  UserModel? selectedUserModel;

  void getUserdata(
      {String? selectedUserId, required BuildContext context}) async {
    //this condition to not do the method again if i clicked on current user because we already got his data at starting of application
    if (selectedUserId == null || selectedUserId != uId) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(selectedUserId ?? uId)
          .get()
          .then((value) {
        if (selectedUserId != uId && selectedUserId != null) {
          selectedUserModel = UserModel.fromJson(value.data()!);
          emit(FoodGetSelectedUserSuccessState(selectedUserId));
        } else if (selectedUserId == null) {
          userModel = UserModel.fromJson(value.data()!);
          emit(FoodSuccessState('uId'));
        }
      }).catchError((error) {
        print(error.toString());
        emit(FoodErrorState());
      });
    }
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const MapScreen(),
    AddPosts(),
    const FavoritesScreen(),
    const ChatsScreen()
  ];
  List<String> titles = ['Home', 'Maps', 'Donate', 'favorites', 'Chats'];

  void changeBottomNav(int index) {
    // if (index == 2) {
    //   emit(DonateFoodState());
    // } else {
    currentIndex = index;
    emit(ChangeBottomNavState());
    // }
  }

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
    bool? isFavorite,
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
      donorId: uId,
      userName: userModel!.name,
      userImage: userModel!.image,
      isFavorite: isFavorite ??= false,
    );
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
        updateImage(postId, {imageNum: value.toString()});
      });
    });
  }

  updateImage(postId, Map<String, String> imageUrl) {
    posts.doc(postId).update(imageUrl);
  }

  /////////////////////////////////////updatePost

  //لازم تمرر id بتاع البوست علسان تعمل update بيه
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
    required bool isFavorite,
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
      donorId: uId,
      isFavorite: isFavorite,
    );
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

//////////////////////////////////////////////////get posts at home and profile
  List<PostModel> postsList = [];
  List<PostModel> currentUserPostsList = [];
  List<PostModel> selectedUserPostsList = [];
  List<PostModel> myReceivedFoodList = [];
  List<String> postId = [];
  List<UserModel> userData = [];
  List<PostModel> favPosts = [];

  bool? isItFav(String postID) {
    final selectedOne =
        postsList.firstWhere((element) => element.postId == postID);
    return selectedOne.isFavorite;
  }

  void getFavPosts(String postID) {
    final selectedOne =
        postsList.firstWhere((element) => element.postId == postID);
    selectedOne.isFavorite ??= false;
    selectedOne.isFavorite = !selectedOne.isFavorite!;
    if (selectedOne.isFavorite == true) {
      favPosts.add(selectedOne);
    } else {
      favPosts.remove(selectedOne);
    }
    emit(FoodFavoriteState());
    emit(UpdatePostSuccessState());
  }

  void getPosts() {
    posts.snapshots().listen((event) {
      postsList = [];
      currentUserPostsList = [];
      for (var element in event.docs) {
        //this condition is for getting current user's posts.
        if (element.get('donorId') == uId) {
          currentUserPostsList.add(PostModel.fromJson(element.data()));
        }
        postId.add(element.id);
        postsList.add(PostModel.fromJson(element.data()));
      }
      emit(FoodGetPostsSuccessState());
    });
  }

  void getSelectedUserPosts({required String selectedUserId}) async {
    selectedUserPostsList = [];
    if (selectedUserPostsList.isEmpty) {
      for (PostModel postModel in postsList) {
        if (postModel.donorId! == selectedUserId) {
          selectedUserPostsList.add(postModel);
        }
      }
      emit(FoodGetSelectedUserPostsSuccessState());
    }
  }

//
  void receiveFood({required PostModel postModel}) async {
    emit(FoodReceiveFoodLoadingState());
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .update({'receiverId': uId}).then((value) {
      postModel.receiverId = uId!;
      showToast(text: 'you got this item', states: ToastStates.SUCCESS);
      emit(FoodReceiveFoodSuccessState());
    }).catchError((error) {
      emit(FoodReceiveFoodErrorState());
    });
  }

  void getMyReceivedFood() async {
    if (myReceivedFoodList.isEmpty) {
      for (PostModel postModel in postsList) {
        if (postModel.donorId! == uId || postModel.receiverId == uId) {
          myReceivedFoodList.add(postModel);
        }
      }
      emit(FoodGetMyReceiveFoodSuccessState());
    }
  }

  void deletePost(String postId) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
    emit(FoodDeletePostSuccessState());
  }

  void updateUserRating({required double rating}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(selectedUserModel!.uId)
        .update({'rating': rating});
    emit(FoodRatingUpdateSuccessState());
  }
}
