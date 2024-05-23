class Order {
  String? createdAt;
  String? id;
  String? medicineId;
  String? observation;
  String? priority;
  int? quantity;
  String? status;
  String? updatedAt;
  String? userId;

  Order(
      {this.createdAt,
      this.id,
      this.medicineId,
      this.observation,
      this.priority,
      this.quantity,
      this.status,
      this.updatedAt,
      this.userId});

  Order.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    medicineId = json['medicine_id'];
    observation = json['observation'];
    priority = json['priority'];
    quantity = json['quantity'];
    status = json['status'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['medicine_id'] = medicineId;
    data['observation'] = observation;
    data['priority'] = priority;
    data['quantity'] = quantity;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    return data;
  }
}
