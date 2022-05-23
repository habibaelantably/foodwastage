
class PostModel {
  String? postId;
  String? location;
  String? itemName;
  String? pickupDate;
  String? postDate;
  String? itemQuantity;
  String? description;
  String? imageUrl1;
  String? imageUrl2;
  String? foodType;
  String? contactMethod;
  String? donorId;
  String? donorPhone;
  String? donorType;
  String? userName;
  String? userImage;
  String? receiverId;
  List? requestsUsers;
  List? requestsUsersId;
  bool? isFavorite;

  PostModel({
    this.postId,
    this.location,
    this.itemName,
    this.pickupDate,
    this.postDate,
    this.itemQuantity,
    this.description,
    this.imageUrl1,
    this.imageUrl2,
    this.foodType,
    this.contactMethod,
    this.donorId,
    this.donorPhone,
    this.donorType,
    this.userName,
    this.userImage,
    this.receiverId,
    this.requestsUsers,
    this.requestsUsersId,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'location': location,
      'itemName': itemName,
      'pickupDate': pickupDate,
      'postDate': postDate,
      'itemQuantity': itemQuantity,
      'description': description,
      'imageUrl1': imageUrl1,
      'imageUrl2': imageUrl2,
      'foodType': foodType,
      'contactMethod': contactMethod,
      'donorId': donorId,
      'donorPhone': donorPhone,
      'donorType':donorType,
      'userName': userName,
      'userImage': userImage,
      'receiverId': receiverId,
      'requestsUsers': requestsUsers,
      'requestsUsersId': requestsUsersId,
      'isFavorite': isFavorite ??= false,
    };
  }

  factory PostModel.fromJson(json) {
    return PostModel(
      postId: json['postId'],
      location: json['location'],
      itemName: json['itemName'],
      pickupDate: json['pickupDate'],
      postDate: json['postDate'],
      itemQuantity: json['itemQuantity'],
      description: json['description'],
      imageUrl1: json['imageUrl1'],
      imageUrl2: json['imageUrl2'],
      foodType: json['foodType'],
      contactMethod: json['contactMethod'],
      donorId: json['donorId'],
      donorPhone: json['donorPhone'],
      donorType:json['donorType'],
      userName: json['userName'],
      userImage: json['userImage'],
      receiverId: json['receiverId'],
      requestsUsers: json['requestsUsers'],
      requestsUsersId: json['requestsUsersId'],
      isFavorite: json['isFavorite'] ??= false,
    );
  }
}
