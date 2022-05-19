class PostModel {
  String? postId;
  String? location;
  String? itemName;
  String? pickupDate;
  String? postDate;
  String? quantity;
  String? description;
  String? imageUrl1;
  String? imageUrl2;
  String? foodType;
  String? donorId;
  String? userName;
  String? userImage;
  String? receiverId;
  bool? isFavorite;

  PostModel({
    this.postId,
    this.location,
    this.itemName,
    this.pickupDate,
    this.postDate,
    this.quantity,
    this.description,
    this.imageUrl1,
    this.imageUrl2,
    this.foodType,
    this.donorId,
    this.userName,
    this.userImage,
    this.receiverId,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'itemName': itemName,
      'pickupDate': pickupDate,
      'postDate': postDate,
      'quantity': quantity,
      'description': description,
      'imageUrl1': imageUrl1,
      'imageUrl2': imageUrl2,
      'foodType': foodType,
      'donorId': donorId,
      'userName': userName,
      'userImage': userImage,
      'receiverId': receiverId,
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
      quantity: json['quantity'],
      description: json['description'],
      imageUrl1: json['imageUrl1'],
      imageUrl2: json['imageUrl2'],
      foodType: json['foodType'],
      donorId: json['donorId'],
      userName: json['userName'],
      userImage: json['userImage'],
      receiverId: json['receiverId'],
      isFavorite: json['isFavorite'] ??= false,
    );
  }
}
