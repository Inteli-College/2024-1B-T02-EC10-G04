class User {
  String? createdAt;
  String? email;
  String? password;
  String? id;
  String? name;
  bool? onDuty;
  String? role;

  User(
      {this.createdAt,
      this.email,
      this.password,
      this.id,
      this.name,
      this.onDuty,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    onDuty = json['on_duty'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['email'] = email;
    data['password'] = password;
    data['id'] = id;
    data['name'] = name;
    data['on_duty'] = onDuty;
    data['role'] = role;
    return data;
  }
}
