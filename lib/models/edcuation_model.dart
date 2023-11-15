class educationmodel {
  int? id;
  int? userId;
  String? graduationDate;
  String? university;
  String? college;
  String? specialization;
  String? level;

  educationmodel(
      {this.id,
      this.userId,
      this.graduationDate,
      this.university,
      this.college,
      this.specialization,
      this.level});

  educationmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    graduationDate = json['graduation_date'];
    university = json['university'];
    college = json['college'];
    specialization = json['specialization'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['graduation_date'] = this.graduationDate;
    data['university'] = this.university;
    data['college'] = this.college;
    data['specialization'] = this.specialization;
    data['level'] = this.level;
    return data;
  }
}
