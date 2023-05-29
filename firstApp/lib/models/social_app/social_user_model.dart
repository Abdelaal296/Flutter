class SocialUserModel{
  late String name;
  String? email;
  late String phone;
  late String uid;
  String? image;
  String? cover;
  late String bio;
  bool? isEmailVerified;

  SocialUserModel({
    required this.name,
    this.email,
    required this.phone,
    required this.uid,
    this.image,
     this.cover,
    required this.bio,
     required this.isEmailVerified,
});
  SocialUserModel.fromJSon(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];

  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
    'email':email,
    'phone':phone,
    'uid':uid,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}