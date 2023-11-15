class Skill {
  final int id;
  final int userId;
  final String skill;

  Skill({required this.id, required this.userId, required this.skill});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id']as int ,
      userId: json['user_id'],
      skill: json['skill'],
    );
  }
}
