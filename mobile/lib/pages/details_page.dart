import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/controller/orders.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/models/medicines.dart';
import 'package:mobile/services/orders.dart';
import 'package:mobile/widgets/custom_button.dart';

class OrderDetailsPage extends StatelessWidget {
  late final OrdersController _ordersController =
      OrdersController(orderService: OrderService());

  final String orderNumber;
  final String orderDate;
  final String orderStatus;
  final VoidCallback onPressed;
  final Color color;
  final String priority;
  final String pyxis;
  final Icon iconStatus;
  final List<Medicines> medicines;
  final String role;
  final String orderId;

  OrderDetailsPage({
    super.key,
    required this.orderNumber,
    required this.orderDate,
    required this.orderStatus,
    required this.onPressed,
    required this.color,
    required this.priority,
    required this.pyxis,
    required this.iconStatus,
    required this.medicines,
    required this.role,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/orders');
              },
            )),
        title: const Text('Order details',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins')),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
            child: const Text(
              'Kindly select the medication you require',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Text(
                                  'MS',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pixys - $pyxis',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 18.0,
                                      color: AppColors.grey2,
                                    ),
                                  ),
                                  Text(
                                    'Order nº $orderNumber - $orderDate',
                                    style: const TextStyle(
                                      color: AppColors.grey3,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.grey5,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  iconStatus,
                                  const SizedBox(width: 5),
                                  Text(
                                    orderStatus,
                                    style: const TextStyle(
                                      color: AppColors.black50,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ))),
                          const SizedBox(height: 20),
                          const Divider(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Medicines requested:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: AppColors.grey2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (Medicines medicine in medicines)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 2.0,
                                    ),
                                    child: Text(
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins'),
                                      medicine.name!,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    role == 'collector'
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      receivedColor: AppColors.secondary,
                                      isEnabled: true,
                                      label: 'Finish Order',
                                      onPressed: () {
                                        _ordersController.updateOrder(
                                            context, orderId, 'completed');
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Refuse order',
                                        style: const TextStyle(
                                            color: AppColors.grey3,
                                            fontSize: 16),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _ordersController.updateOrder(
                                                context, orderId, 'refused');
                                          },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: TextButton(
                              onPressed: onPressed,
                              child: const Text(
                                'Request Again',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
