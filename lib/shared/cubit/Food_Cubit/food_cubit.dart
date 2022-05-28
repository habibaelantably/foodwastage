import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/modules/Nearby%20Screen/nearby_screen.dart';
import 'package:foodwastage/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../modules/Add Post Screen/add_post_screen.dart';
import '../../../modules/Chats Screen/chats_screen.dart';
import '../../../modules/Favorites Screen/favorites_screen.dart';
import '../../../modules/Home Screen/home_screen.dart';
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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(selectedUserId ?? uId)
        .get()
        .then((value) {
      if (selectedUserId != uId && selectedUserId != null) {
        selectedUserModel = UserModel.fromJson(value.data()!);
        emit(GetSelectedUserDataSuccessState(selectedUserId));
      } else if (selectedUserId == uId || selectedUserId == null) {
        userModel = UserModel.fromJson(value.data()!);
        emit(GetCurrentUserDataSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetCurrentUserDataErrorState());
    });
  }

  int currentIndex = 0;

  bool isSearching = false;

  String filterValue = 'All';

  List searchedForPosts = [];

  List<Widget> screens = [
    const HomeScreen(),
    const NearbyScreen(),
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

  List<String> foodTypeList = ["Main dishes", "Desserts", "Sandwiches"];

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
      donorType: userModel!.type,
      userName: userModel!.name,
      userImage: userModel!.image,
      requestsUsersId: [],
      postDate: postDate,
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
        updateImage(postId, {imageNum: value.toString()},
            {"postId": postId.toString()});
      });
    });
  }

  updateImage(
      postId, Map<String, String> imageUrl, Map<String, String> postIdMap) {
    posts.doc(postId).update(imageUrl).then((value) {
      posts.doc(postId).update(postIdMap);
    });
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
    required String postId,
    required String imageUrl2,
    required String foodType,
    required String contactMethod,
    required String userName,
    required String userImage,
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
      postId: postId,
      postDate: postDate,
      userName: userName,
      userImage: userImage,
      receiverId: null,

      requestsUsersId: [],

    );
    if (imageFile1 != null) {
      posts
          .doc(postId)
          .update(postModel.toMap())
          .then(
              (value) => uploadImage(imageFile1!, postModel.postId, "imageUrl1"))
          .then((value) => emit(UpdatePostSuccessState()))
          .catchError((onError) {
        emit(UpdatePostErrorState(onError.toString()));
      }).then((value) => imageFile1 == null);
    } else {
      posts
          .doc(postId)
          .update(postModel.toMap())
          .then((value) => emit(UpdatePostSuccessState()))
          .catchError((onError) {
        emit(UpdatePostErrorState(onError.toString()));
      });
    }
    // posts.doc(postId).update(postModel.toMap()).then((idValue) async {
    //   if (imageFile1 != null) {
    //     await uploadImage(imageFile1!, postModel.postId, imageUrl1)
    //         .then((value) {
    //       if (imageFile2 != null) {
    //         uploadImage(imageFile2!, postModel.postId, imageUrl2).then((value) {
    //           emit(UpdatePostSuccessState());
    //         }).catchError((onError) {
    //           emit(UpdatePostErrorState(onError.toString()));
    //         });
    //       }
    //     }).catchError((onError) {
    //       emit(UpdatePostErrorState(onError.toString()));
    //     });
    //   } else if (imageFile2 != null) {
    //     await uploadImage(imageFile2!, postModel.postId, imageUrl2)
    //         .then((value) {
    //       if (imageFile1 != null) {
    //         uploadImage(imageFile1!, postModel.postId, imageUrl1).then((value) {
    //           emit(UpdatePostSuccessState());
    //         }).catchError((onError) {
    //           emit(UpdatePostErrorState(onError.toString()));
    //         });
    //       }
    //     }).catchError((onError) {
    //       emit(UpdatePostErrorState(onError.toString()));
    //     });
    //   }
    //   emit(UpdatePostSuccessState());
    //   Fluttertoast.showToast(
    //     gravity: ToastGravity.TOP,
    //     msg: "Post Updated Successfully",
    //     backgroundColor: Colors.green,
    //   );
    // }).catchError((onError) {
    //   Fluttertoast.showToast(
    //     gravity: ToastGravity.TOP,
    //     msg: "$onError <<Please try again>>",
    //     backgroundColor: Colors.green,
    //   );
    //   emit(UpdatePostErrorState(onError.toString()));
    // });
    return;
  }

//////////////////////////////////////////////////get posts at home and profile

  List<UserModel> userData = [];
  List<UserModel> postRequestsList = [];
  List<PostModel> postsList = [];
  List<PostModel> currentUserPostsList = [];
  List<PostModel> selectedUserPostsList = [];
  List<PostModel> myHistoryTransactionsList = [];
  List<PostModel> myRequestsList = [];
  List<PostModel> favPosts = [];
  List<PostModel> filteredPosts = [];

  void changePostFavStatus(PostModel postModel) async {
    if (userModel!.favPostsId!.contains(postModel.postId)) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('favorites')
          .doc(postModel.postId)
          .delete()
          .then((value) {
        userModel!.favPostsId!.remove(postModel.postId);
        emit(UnFavoritePostSuccessState());
      }).catchError((error) {
        emit(UnFavoritePostErrorState());
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('favorites')
          .doc(postModel.postId)
          .set(postModel.toMap())
          .then((value) {
        emit(FavoritePostSuccessState());
      }).catchError((error) {
        emit(FavoritePostErrorState());
      });
    }
  }

  void getFavPosts() async{
    await Future.delayed(const Duration(seconds: 2));
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorites')
        .snapshots()
        .listen((event) {
      favPosts = [];
      for (var element in event.docs) {
        userModel!.favPostsId!.add(element.id);
        PostModel post = PostModel.fromJson(element.data());
        post.postId=  element.id;
        favPosts.add(post);
      }
      emit(GetFavoritePostsSuccessState());
    });
  }

  void getPosts() {
    posts.snapshots().listen((event) async {
      postsList = [];
      currentUserPostsList = [];
      filteredPosts = [];
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

        if (filterValue == "All") {
          filteredPosts.add(post);
        } else if (post.foodType == filterValue) {
          filteredPosts.add(post);
        }
      }
      emit(GetAllPostsSuccessState());
    });
  }

  void getMyRequests() async {
    myRequestsList = [];
    await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) async {
      for (var element in value.docs) {
        PostModel post = PostModel.fromJson(element.data());
        post.postId = element.id;
        await element.reference.collection('requests').get().then((value) {
          for (var request in value.docs) {
            if (request.id == uId) {
              myRequestsList.add(post);
            }
          }
        });
      }
      emit(GetMyRequestsSuccessState());
    });
  }

  void getSelectedUserPosts({required String selectedUserId}) async {
    selectedUserPostsList = [];
    for (var element in postsList) {
      if (element.donorId == selectedUserId) {
        selectedUserPostsList.add(element);
      }
    }
    emit(FoodGetSelectedUserPostsSuccessState());
  }

  void requestItem(BuildContext context, {required PostModel postModel}) async {
    postModel.requestsUsersId!.add(uId);
    await posts
        .doc(postModel.postId)
        .collection('requests')
        .doc(uId)
        .set(userModel!.toMap())
        .then((value) async {
      await posts
          .doc(postModel.postId)
          .update({'requestsUsersId': postModel.requestsUsersId});
      showToast(
          text: AppLocalizations.of(context)!.requestItemToast,
          states: ToastStates.SUCCESS);
      emit(RequestItemSuccessState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void getPostRequests(String postId) {
    emit(GetPostRequestsLoadingState());
    posts.doc(postId).collection('requests').snapshots().listen((event) {
      postRequestsList = [];
      for (var element in event.docs) {
        postRequestsList.add(UserModel.fromJson(element.data()));
      }
      emit(GetPostRequestsSuccessState());
    });
  }

  void acceptRequest(
      {required PostModel postModel, required String receiverId}) async {
    posts.doc(postModel.postId).delete().then((value) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(postModel.donorId)
          .collection('history')
          .doc(postModel.postId)
          .set(postModel.toMap())
          .then((value) {
        if (receiverId != postModel.donorId) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(receiverId)
              .collection('history')
              .doc(postModel.postId)
              .set(postModel.toMap());
        }
      });
    });
  }

  void cancelRequest(BuildContext context,
      {required PostModel postModel}) async {
    postModel.requestsUsersId!.remove(uId);
    myRequestsList.remove(postModel);
    await posts
        .doc(postModel.postId)
        .collection('requests')
        .doc(uId)
        .delete()
        .then((value) async {
      await posts
          .doc(postModel.postId)
          .update({'requestsUsersId': postModel.requestsUsersId}).then(
              (value) async {});
    });
  }

  void getMyHistoryTransactions() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('history')
        .snapshots()
        .listen((event) {
      myHistoryTransactionsList = [];
      for (var element in event.docs) {
        PostModel post = PostModel.fromJson(element.data());
        post.postId = element.id;
        myHistoryTransactionsList.add(post);
      }
      emit(FoodGetMyHistoryTransactionsSuccessState());
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
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete().then((value) async {
      await FirebaseFirestore.instance.collection('users').doc(uId).collection('favorites').doc(postId).delete().then((value){
        emit(FoodDeletePostSuccessState());
      });
    });
  }

  void rateUser({required double rating, required PostModel postModel}) async {
    if (postModel.isRatted == false) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(postModel.donorId)
          .collection('ratings')
          .add({'userId': uId, 'rate': rating}).then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(postModel.donorId)
            .collection('ratings')
            .get()
            .then((value) async {
          double rating = 0.0;
          for (var element in value.docs) {
            rating += element.get('rate');
          }
          rating = rating / value.docs.length;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(postModel.donorId)
              .update({'rating': rating}).then((value) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(uId)
                .collection('history')
                .doc(postModel.postId)
                .update({'isRatted': true}).then((value) {
              emit(FoodRatingUpdateSuccessState());
            });
          });
        });
      });
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static String? getLoggedInUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    currentUser != null ? uId = currentUser.uid : uId = null;
    return uId;
  }

  void changeSearchButtonIcon() {
    isSearching = !isSearching;
    emit(ChangeSearchButtonIconState());
  }

  //Search Bar in Home
  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    if (searchedCharacter.isEmpty) {
      searchedForPosts = [];
    } else {
      searchedForPosts = filteredPosts
          .where((post) =>
              post.itemName!.toLowerCase().startsWith(searchedCharacter))
          .toList();
    }
    emit(Search());
  }

  //filters
  void filterPosts(String value) {
    filterValue = value;
    filteredPosts = [];
    for (var post in postsList) {
      if (filterValue == "All") {
        filteredPosts = postsList;
      } else if (post.foodType == filterValue) {
        filteredPosts.add(post);
      }
    }
    emit(GetFilteredPostsSuccessState());
  }
}
