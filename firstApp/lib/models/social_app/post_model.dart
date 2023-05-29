class PostModel{
  late String name;
  late String uid;
  String? image;
  late String dateTime;
  late String text;
  late String postImage;


  PostModel({
    required this.name,
    required this.uid,
    this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,

  });
  PostModel.fromJSon(Map<String,dynamic> json){
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];

  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uid':uid,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}