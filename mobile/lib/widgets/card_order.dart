import 'package:flutter/material.dart';
import 'package:mobile/classes/colors.dart';
import 'package:mobile/pages/details_page.dart';

class CardOrder extends StatelessWidget {
  final String orderNumber;
  final String orderDate;
  final String orderStatus;
  final String orderValue;
  final VoidCallback onPressed;
  final Color color;
  final String priority;
  final String pyxis;
  final Icon iconStatus;
  final List<String> medicines;

  const CardOrder({
    super.key,
    required this.orderNumber,
    required this.orderDate,
    required this.orderStatus,
    required this.orderValue,
    required this.onPressed,
    required this.color,
    required this.priority,
    required this.pyxis,
    required this.iconStatus,
    required this.medicines,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const CircleAvatar(
                    child: Text('MS'),
                    backgroundColor: Colors.purple,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                    '$pyxis - $orderNumber',
                  )
                ]),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    priority,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          iconStatus,
                          const SizedBox(width: 5),
                          Text(
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Poppins'),
                              orderStatus),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (String medicine in medicines)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0,),
                                  child: Text(
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins'),
                                    medicine)
                                ) 
                            ],
                          )),
                    ],
                  ),
                ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                  
                  },
                  child: const Text('Request Again',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontFamily: 'Poppins',
                      )),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(
                          orderNumber: orderNumber,
                          orderDate: orderDate,
                          orderStatus: orderStatus,
                          orderValue: orderValue,
                          medicines: medicines,
                          onPressed: () {},
                          color: AppColors.warning,
                          priority: priority,
                          pyxis: pyxis,
                          iconStatus: iconStatus,
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                          style: TextStyle(
                              fontFamily: 'Poppins', color: AppColors.black50),
                          'View details'),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.black50,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
