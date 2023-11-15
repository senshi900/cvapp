class getprjectmodel {
  int? id;
  int? userId;
  String? name;
  String? description;
  String? state;

  getprjectmodel(
      {this.id, this.userId, this.name, this.description, this.state});

  getprjectmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['state'] = this.state;
    return data;
  }
}
