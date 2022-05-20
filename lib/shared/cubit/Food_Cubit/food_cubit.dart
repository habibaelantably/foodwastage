import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../modules/Add Post Screen/add_post_screen.dart';
import '../../../modules/Chats Screen/chats_screen.dart';
import '../../../modules/Favorites Screen/favorites_screen.dart';
import '../../../modules/Home Screen/home_screen.dart';
import '../../../modules/Maps Screen/maps_screen.dart';
import '../../constants.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          emit(FoodSuccessState());
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

  int itemQuantity = 1;

  String date =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

  String foodType = "Main dishes";

  List<String> foodTypeList = ["Main dishes", "Desert", "Sandwich"];

  String contactMethod = "Phone";

  List<String> contactMethodList = ["Phone", "Chat", "Both"];

  bool addPostPolicyIsChecked = false;

  donatePolicyCheck() {
    addPostPolicyIsChecked = !addPostPolicyIsChecked;
    emit(IsCheckedState());
  }

  minusItemCount() {
    if (itemQuantity != 0) {
      itemQuantity--;
    }
    emit(CounterIncrementState());
  }

  incrementItemCount() {
    if (itemQuantity < 5) {
      itemQuantity++;
    }
    emit(CounterMinusState());
  }

  changDateTime(date) {
    this.date = "${date.day}/${date.month}/${date.year}";
    emit(ChangeDateTimeState());
  }

  changeFoodTypeValue(value) {
    foodType = value;
    emit(ChangeVerticalGroupValue());
  }

  changeContactMethodValue(value) {
    contactMethod = value;
    emit(ChangeVerticalGroupValue());
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
    required String location,
    required String itemName,
    required String pickupDate,
    required String itemQuantity,
    required String description,
    required String imageUrl1,
    required String imageUrl2,
    required String foodType,
    required String contactMethod,
    required String foodDonor,
    required String postDate,
    bool? isFavorite,
  }) async {
    emit(CreatePostLoadingState());

    PostModel postModel = PostModel(
      description: description,
      foodType: foodType,
      contactMethod: contactMethod,
      imageUrl1: imageUrl1,
      imageUrl2: imageUrl2,
      itemName: itemName,
      location: location,
      pickupDate: pickupDate,
      itemQuantity: itemQuantity,
      donorId: uId,
      donorPhone: userModel!.phone,
      userName: userModel!.name,
      userImage: userModel!.image,
      isFavorite: isFavorite ??= false,
      postDate: postDate,
      requestsUsersId: [],
      requestsUsers: [],
    );
    posts.add(postModel.toMap()).then((idValue) async {
      if (imageFile1 != null) {
        await uploadImage(imageFile1!, idValue.id, imageUrl1).then((value) {
          if (imageFile2 != null) {
            uploadImage(imageFile2!, idValue.id, imageUrl2).then((value) {
              emit(CreatePostSuccessState());
            }).catchError((onError) {
              emit(CreatePostErrorState(onError.toString()));
            });
          }
        }).catchError((onError) {
          emit(CreatePostErrorState(onError.toString()));
        });
      } else if (imageFile2 != null) {
        await uploadImage(imageFile2!, idValue.id, imageUrl2).then((value) {
          if (imageFile1 != null) {
            uploadImage(imageFile1!, idValue.id, imageUrl1).then((value) {
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
      showToast(
          text: "Post uploaded successfully", states: ToastStates.SUCCESS);
    }).catchError((onError) {
      showToast(text: "Post uploaded successfully", states: ToastStates.ERROR);
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
    required String location,
    required String itemName,
    required String postDate,
    required String foodQuantity,
    required String description,
    required String imageUrl1,
    required String imageUrl2,
    required String foodType,
    required String contactMethod,
    required bool isFavorite,
  }) async {
    emit(UpdatePostLoadingState());

    PostModel postModel = PostModel(
      description: description,
      foodType: foodType,
      contactMethod: contactMethod,
      imageUrl1: imageUrl1,
      imageUrl2: imageUrl2,
      itemName: itemName,
      location: location,
      pickupDate: postDate,
      itemQuantity: foodQuantity,
      donorId: uId,
      donorPhone: userModel!.phone,
      isFavorite: isFavorite,
    );
    posts.doc("postId").update(postModel.toMap()).then((idValue) async {
      if (imageFile1 != null) {
        await uploadImage(imageFile1!, postModel.postId, imageUrl1)
            .then((value) {
          if (imageFile2 != null) {
            uploadImage(imageFile2!, postModel.postId, imageUrl2).then((value) {
              emit(UpdatePostSuccessState());
            }).catchError((onError) {
              emit(UpdatePostErrorState(onError.toString()));
            });
          }
        }).catchError((onError) {
          emit(UpdatePostErrorState(onError.toString()));
        });
      } else if (imageFile2 != null) {
        await uploadImage(imageFile2!, postModel.postId, imageUrl2)
            .then((value) {
          if (imageFile1 != null) {
            uploadImage(imageFile1!, postModel.postId, imageUrl1).then((value) {
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
  List<UserModel> userData = [];
  List<UserModel> postRequestsList = [];
  List<PostModel> postsList = [];
  List<PostModel> currentUserPostsList = [];
  List<PostModel> selectedUserPostsList = [];
  List<PostModel> myHistoryTransactionsList = [];
  List<PostModel> favPosts = [];

  bool? isItFav(PostModel postModel) {
    return postModel.isFavorite;
  }

  void getFavPosts(PostModel postModel) async {
    postModel.isFavorite ??= false;
    postModel.isFavorite = !postModel.isFavorite!;
    if (postModel.isFavorite == true) {
      favPosts.add(postModel);
    } else {
      favPosts.remove(postModel);
    }
    emit(FoodFavoriteState());
  }

  void getPosts() {
    posts.snapshots().listen((event) async {
      postsList = [];
      currentUserPostsList = [];
      myHistoryTransactionsList = [];
      for (var element in event.docs) {
        PostModel post = PostModel.fromJson(element.data());
        post.postId = element.id;
        //this condition is for getting current user's posts & his transactions.
        if (post.donorId == uId) {
          currentUserPostsList.add(post);
        }
        if (post.receiverId == null) {
          postsList.add(post);
        }
        if (post.receiverId != null &&
            (post.receiverId == uId || post.donorId == uId)) {
          myHistoryTransactionsList.add(post);
        }
      }
      emit(FoodGetPostsSuccessState());
    });
  }

  void getSelectedUserPosts({required String selectedUserId}) async {
    posts.get().then((value) {
      for (var element in value.docs) {
        if (element.get('donorId') == selectedUserId) {
          selectedUserPostsList.add(PostModel.fromJson(element.data()));
        }
      }
    });
    emit(FoodGetSelectedUserPostsSuccessState());
  }

  void requestFood(BuildContext context, {required PostModel postModel}) {
    emit(FoodReceiveFoodLoadingState());

    PostModel post = PostModel(
      description: postModel.description,
      foodType: foodType,
      contactMethod: postModel.contactMethod,
      imageUrl1: postModel.imageUrl1,
      imageUrl2: postModel.imageUrl2,
      itemName: postModel.itemName,
      location: postModel.location,
      pickupDate: postModel.pickupDate,
      itemQuantity: postModel.itemQuantity,
      donorId: postModel.donorId,
      donorPhone: postModel.donorPhone,
      userName: postModel.userName,
      userImage: postModel.userImage,
      isFavorite: postModel.isFavorite ??= false,
      postDate: postModel.postDate,
      requestsUsersId: postModel.requestsUsersId,
      requestsUsers: postModel.requestsUsers,
    );

    post.requestsUsers!.add(userModel!.toMap());
    post.requestsUsersId!.add(uId);

    posts.doc(postModel.postId).set(post.toMap()).then((value) {
      emit(FoodReceiveFoodSuccessState());
      showToast(
          text: AppLocalizations.of(context)!.requestItemToast,
          states: ToastStates.SUCCESS);
    }).catchError((error) {
      print(error.toString());
    });
  }

  void getPostRequests(PostModel postModel) {
    postRequestsList = [];
    emit(FoodGetPostRequestsUsersLoadingState());
    posts.doc(postModel.postId).get().then((value) {
      for (var element in value.get('requestsUsers')) {
        postRequestsList.add(UserModel.fromJson(element));
      }
      emit(FoodGetPostRequestsUsersSuccessState());
    }).catchError((error) {
      emit(FoodGetPostRequestsUsersErrorState());
    });
  }

  void confirmDonation(
      {required PostModel postModel, required String receiverId}) {
    posts.doc(postModel.postId).update({
      'receiverId': receiverId,
      'requestsUsers': [],
      'requestsUsersId': []
    }).then((value) {
      emit(FoodConfirmDonationSuccessState());
    });
  }

  Future<void> makePhoneCall(String phone, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse("tel:$phone"))) {
      await launchUrl(Uri.parse("tel:$phone"));
    } else {
      throw '${AppLocalizations.of(context)!.makePhoneCallFallback}$phone';
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

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static String? getLoggedInUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    currentUser != null ? uId = currentUser.uid : uId = null;
    return uId;
  }
}
