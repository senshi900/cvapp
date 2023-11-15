class SkillsModel {
  final int id;
  final int userId;
  final String skill;

  SkillsModel({required this.id, required this.userId, required this.skill});

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    return SkillsModel(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      skill: json['skill'],
    );
  }
}