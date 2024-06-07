import 'package:flutter/material.dart';
import 'package:mobile/widgets/dropdown.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/widgets/custom_button.dart';
import 'package:mobile/models/qrcode.dart';
import 'package:mobile/widgets/card_medicines.dart';

class NewOrderPage extends StatefulWidget {
  static const routeName = '/new-order';

  const NewOrderPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NewOrderPageState createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  String? selectedAnswer;
  String? selectedMedicineId;
  int quantity = 0;

  final NewOrderService newOrderService = NewOrderService();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as QRCodeArguments;

    List<Map<String, String>> medicines = [
      {'medicine': 'Medicine 1', 'lote': '12345'},
      {'medicine': 'Medicine 2', 'lote': '67890'},
      {'medicine': 'Medicine 3', 'lote': '111213'},
    ];

    void handleCardTap(String id) {
      setState(() {
        selectedMedicineId = id;
      });
    }

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
                                      'Pixys - ${args.pyxis}',
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
                                      )
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
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Choose the necessary medicines',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(height: 2),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListView(
                                children: medicines.map((medicine) {
                                  String id = medicine['medicine']!;
                                  return CardMedicines(
                                    medicine: medicine['medicine']!,
                                    lote: medicine['lote']!,
                                    isChecked: selectedMedicineId == id,
                                    onTap: () => handleCardTap(id),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
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
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/check-order');
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
