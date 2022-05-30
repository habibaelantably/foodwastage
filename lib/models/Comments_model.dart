class CommentsModel
{
  String? name;
  String? image;
  String? text;


  CommentsModel({
    this.name,
    this.image,
    this.text,
  });

  CommentsModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    image=json['image'];
    text=json['text'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name':name,
        'image':image,
        'text':text,
      };
  }
}