
class UserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? country;
  String? image;


  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.country,
    this.image,
    });

  UserModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    country=json['country'];
    image=json['image'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name':name,
        'email':email,
        'phone':phone,
        'uId':uId,
        'country':country,
        'image':image,
      };
  }
}