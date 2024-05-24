import 'package:flutter/material.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/widgets/custom_button.dart';
import 'package:mobile/widgets/modal.dart';

class CheckOrderPage extends StatelessWidget {
  final String pyxis;
  final String medicine; 
  final int quantity;  // Adiciona a quantidade como parâmetro

  const CheckOrderPage({
    super.key, 
    required this.pyxis,
    required this.medicine, 
    required this.quantity,  // Adiciona a quantidade como parâmetro
  });

  void _showSuccessModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5), // Semitransparent background
      builder: (BuildContext context) {
        return const Modal(
          title: 'Success',
          description: 'Order placed successfully!',
          icon: Icons.check_circle,
          iconColor: Colors.green,
          routeName: '/orders',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primary,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/orders');
            },
          ),
        ),
        title: const Text(
          'Order details',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
            child: const Text(
              'Check out the details of your orders!',
              style: TextStyle(
                color: AppColors.primary,
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
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey5, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                SizedBox(width: 10),
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
                                    SizedBox(height: 10),
                                    const Text(
                                      'Medicine',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14.0,
                                        color: AppColors.grey2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20), // Espaçamento entre os elementos
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Quantity: $quantity',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      color: AppColors.grey2,
                                    ),
                                  ),
                                  Text(
                                    medicine,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      color: AppColors.grey2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    icon: const Icon(Icons.arrow_back),
                    label: 'Back',
                    receivedColor: AppColors.grey3,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/new-order');
                    },
                    isEnabled: true,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    icon: const Icon(Icons.arrow_forward),
                    label: 'Submit',
                    receivedColor: AppColors.secondary,
                    onPressed: () {
                      _showSuccessModal(context);
                    },
                    isEnabled: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}