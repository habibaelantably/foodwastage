class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? country;
  String? image;
  String? type;
  double? rating;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.country,
    this.image,
    this.type,
    this.rating,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    country = json['country'];
    image = json['image'];
    type = json['type'];
    rating = json['rating'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'country': country,
      'image': image,
      'type': type,
      'rating': rating,
    };
  }
}
