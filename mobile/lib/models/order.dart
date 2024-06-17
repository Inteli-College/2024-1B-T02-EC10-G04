import 'package:mobile/models/medicines.dart';
import 'package:mobile/models/user.dart';
class Order {
  String? createdAt;
  String? id;
  Medicines? medicine;
  String? observation;
  String? priority;
  int? quantity;
  String? status;
  String? updatedAt;
  User? user;

  Order({
    this.createdAt,
    this.id,
    this.medicine,
    this.observation,
    this.priority,
    this.quantity,
    this.status,
    this.updatedAt,
    this.user,
  });

  Order.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    medicine = json['medicine'] != null ? Medicines.fromJson(json['medicine']) : null;
    observation = json['observation'];
    priority = json['priority'];
    quantity = json['quantity'];
    status = json['status'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    if (medicine != null) {
      data['medicine'] = medicine!.toJson();
    }
    data['observation'] = observation;
    data['priority'] = priority;
    data['quantity'] = quantity;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}