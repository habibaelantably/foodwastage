class PostModel {
  int? itemCount;
  String? location;
  String? itemName;
  String? postDate;
  String? quantity;
  String? description;
  String? imageUrl1;
  String? imageUrl2;
  String? foodType;
  String? foodDonor;
  String? donorId;
  String? userName;
  String? userImage;
  String? postId;
  String? receiverId;
  bool? isFavorite;

  PostModel({
    this.itemCount,
    this.location,
    this.itemName,
    this.postDate,
    this.quantity,
    this.description,
    this.imageUrl1,
    this.imageUrl2,
    this.foodType,
    this.foodDonor,
    this.donorId,
    this.userName,
    this.userImage,
    this.postId,
    this.receiverId,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemCount': itemCount,
      'location': location,
      'itemName': itemName,
      'postDate': postDate,
      'quantity': quantity,
      'description': description,
      'imageUrl1': imageUrl1,
      'imageUrl2': imageUrl2,
      'foodType': foodType,
      'foodDonor': foodDonor,
      'donorId': donorId,
      'userName': userName,
      'userImage': userImage,
      'postId': postId,
      'receiverId': receiverId,
      'isFavorite': isFavorite ??= false,
    };
  }

  factory PostModel.fromJson(json) {
    return PostModel(
      itemCount: json['itemCount'],
      location: json['location'],
      itemName: json['itemName'],
      postDate: json['postDate'],
      quantity: json['quantity'],
      description: json['description'],
      imageUrl1: json['imageUrl1'],
      imageUrl2: json['imageUrl2'],
      foodType: json['foodType'],
      foodDonor: json['foodDonor'],
      donorId: json['donorId'],
      userName: json['userName'],
      userImage: json['userImage'],
      postId: json['postId'],
      receiverId: json['receiverId'],
      isFavorite: json['isFavorite'] ??= false,
    );
  }
}
