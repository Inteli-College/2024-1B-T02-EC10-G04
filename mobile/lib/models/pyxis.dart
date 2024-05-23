class Pyxis {
  String? name;
  String? email;
  String? password;
  String? createdAt;
  String? id;
  String? label;

  Pyxis({this.createdAt, this.id, this.label});

  Pyxis.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['label'] = label;
    return data;
  }
}
