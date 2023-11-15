class aboutmodel {
  String? msg;
  Data? data;
  int? codeState;

  aboutmodel({this.msg, this.data, this.codeState});

  aboutmodel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    codeState = json['codeState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['codeState'] = this.codeState;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  Null? titlePosition;
  String? phone;
  Null? location;
  Null? birthday;
  Null? about;
  String? image;
  String? createAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.titlePosition,
      this.phone,
      this.location,
      this.birthday,
      this.about,
      this.image,
      this.createAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    titlePosition = json['title_position'];
    phone = json['phone'];
    location = json['location'];
    birthday = json['birthday'];
    about = json['about'];
    image = json['image'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['title_position'] = this.titlePosition;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['birthday'] = this.birthday;
    data['about'] = this.about;
    data['image'] = this.image;
    data['create_at'] = this.createAt;
    return data;
  }
}