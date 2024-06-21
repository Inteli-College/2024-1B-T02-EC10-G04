import 'package:flutter/material.dart';
import 'package:mobile/logic/show_modal.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/services/orders.dart';

class OrdersController {
  final OrderService orderService;

  OrdersController({required this.orderService});

  Future<void> createOrder(BuildContext context, List<String> medicineIds,
      String observation) async {
    try {
      final response = await orderService.createOrder(medicineIds, observation);

      if (response.isNotEmpty) {
        showModal(
            // ignore: use_build_context_synchronously
            context,
            "Order created!",
            "Your order were created successfully. You can check your orders in the orders page.",
            Icons.check,
            AppColors.success,
            "/orders");
        return;
      }
      showModal(
          // ignore: use_build_context_synchronously
          context,
          "Oops! Something Went Wrong",
          "Something went wrong while the order were created. Please try again or talk with an administrador.",
          Icons.error,
          AppColors.error,
          "");

      // Handle login success
    } catch (e) {
      // Handle login failure
    }
  }

  Future<void> updateOrder(
      BuildContext context, String orderId, String status) async {
    try {
      final response = await orderService.updateOrder(orderId, status);

      if (response.isNotEmpty) {
        showModal(
            // ignore: use_build_context_synchronously
            context,
            "Order Finished!",
            "Your order were finished successfully. You can check your orders in the orders page.",
            Icons.check,
            AppColors.success,
            "/orders");
        return;
      }
      showModal(
          // ignore: use_build_context_synchronously
          context,
          "Oops! Something Went Wrong",
          "Something went wrong while the order were finished. Please try again or talk with an administrador.",
          Icons.error,
          AppColors.error,
          "");

      // Handle login success
    } catch (e) {
      // Handle login failure
    }
  }
}
