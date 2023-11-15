class SocialMediaModel {
  int? id;
  int? userId;
  String? username;
  String? social;

  SocialMediaModel({this.id, this.userId, this.username, this.social});

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      id: json['id'],
      userId: json['user_id'],
      username: json['username'],
      social: json['social'],
    );
  }
}
