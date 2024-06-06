import 'package:flutter/material.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/widgets/custom_button.dart';
import 'package:mobile/services/new_orders.dart';
import 'package:mobile/models/new_order.dart';

class NewOrderPage extends StatefulWidget {
  final String pyxis;
  final String medicine;
  final String medicineid;

  const NewOrderPage({
    super.key,
    required this.pyxis,
    required this.medicine,
    required this.medicineid,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NewOrderPageState createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  bool isChecked = false;
  String? selectedAnswer;
  int quantity = 0;

  final NewOrderService newOrderService = NewOrderService();

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
          ),
        ),
        title: const Text(
          'New Order',
          style: TextStyle(
            color: Colors.white,
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
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.grey5,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.home,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pixys - ${widget.pyxis}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        fontSize: 18.0,
                                        color: AppColors.grey2,
                                      ),
                                    ),
                                  ],
                                ),
                                const Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.hourglass_bottom,
                                        color: AppColors.primary,
                                        size: 15,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '30 min',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                          color: AppColors.grey2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Do you need any additional quantities of missing medications?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Dropdown(
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswer = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.medicine,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          color: AppColors.grey2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        ('Lot number: ${widget.medicineid}'),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                if (selectedAnswer == 'Yes, please!' && isChecked)
                                  Container(
                                    width: 105,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.remove),
                                          iconSize: 12,
                                          onPressed: () {
                                            setState(() {
                                              if (quantity > 0) quantity--;
                                            });
                                          },
                                        ),
                                        Text(
                                          '$quantity',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.add),
                                          iconSize: 12,
                                          onPressed: () {
                                            setState(() {
                                              quantity++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(width: 1),
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                  checkColor: Colors.white,
                                  activeColor: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  icon: const Icon(Icons.arrow_back),
                                  label: 'Back',
                                  receivedColor: AppColors.grey3,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/qr-code'); 
                                  },
                                  isEnabled: true,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  label: 'Submit',
                                  receivedColor: AppColors.secondary,
                                  onPressed: () async {
                                    try {
                                      final newOrder = NewOrder(
                                        medicines: [
                                          {
                                            'medicineid': widget.medicineid,
                                            'name': widget.medicine,
                                            'dose': '',
                                          },
                                        ],
                                        userId: 'user123',
                                        observation: '',
                                        priority: 'High',
                                        quantity: quantity,
                                      );

                                      final createdOrder = await newOrderService.createOrder(newOrder);
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushNamed('/check-order', arguments: createdOrder);
                                    } catch (e) {
                                      // Handle error (e.g., show a snackbar)
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error creating order: $e')),
                                      );
                                    }
                                  },
                                  isEnabled: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
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
