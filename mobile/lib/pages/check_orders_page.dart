import 'package:flutter/material.dart';
import 'package:mobile/models/colors.dart';

class CheckOrderPage extends StatelessWidget {
  final String pyxis;
  final String medicine; 

  const CheckOrderPage({
    super.key, 
    required this.pyxis,
    required this.medicine, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
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
                                  const SizedBox(height: 10),
                                  const Text(
                                    'medicine', // Exibe o nome do medicamento selecionado
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      color: AppColors.grey2,
                                    ),
                                  ),
                                  // Aqui você pode adicionar mais detalhes do medicamento, se necessário
                                ],
                              ),
                            ],
                          ),
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
