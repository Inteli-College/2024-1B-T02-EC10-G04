import 'package:flutter/material.dart';
import 'package:mobile/widgets/card_order.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/models/order.dart';

class TabSessionHistory extends StatefulWidget {
  final Future<List<Order>> orders;

  @override
  // ignore: library_private_types_in_public_api
  _TabSessionHistoryState createState() => _TabSessionHistoryState();

  const TabSessionHistory({
    super.key,
    required this.orders,
  });
}

class _TabSessionHistoryState extends State<TabSessionHistory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                  child: FutureBuilder<List<Order>>(
                      future: widget.orders,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return CardOrder(
                                orderNumber: "Nº ${snapshot.data![index].id!.substring(0, 6).toUpperCase()}",
                                orderDate: snapshot.data![index].createdAt!,
                                orderStatus: snapshot.data![index].status!.toUpperCase(),
                                onPressed: () {},
                                color: snapshot.data![index].priority == "red" ? AppColors.error : snapshot.data![index].priority == "green" ? AppColors.success : AppColors.warning,
                                priority: snapshot.data![index].priority!,
                                pyxis: 'MS-01D',
                                iconStatus:
                                snapshot.data![index].status == "requested" ?
                                const Icon(
                                 Icons.change_circle,
                                 color: AppColors.warning,
                                )
                                : snapshot.data![index].status == "pending" ? 
                                const Icon(
                                 Icons.change_circle,
                                 color: AppColors.warning,
                                ) : snapshot.data![index].status == "completed" ? 
                                const Icon(
                                 Icons.check_circle,
                                 color: AppColors.success,
                                ) : snapshot.data![index].status == "cancelled" ?
                                const Icon(
                                 Icons.cancel,
                                 color: AppColors.error,
                                ) : const Icon(
                                 Icons.cancel,
                                 color: AppColors.error,
                                ),
                                //medicineList.map((medicine) => medicine['name'] as String).toList();
                                medicines: [
                                  snapshot.data![index].medicine!.name!,
                                ]
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Padding(
                            padding: EdgeInsets.all(
                                16.0), // Define o padding desejado
                            child: Text(
                              'Orders not found!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black50,
                              ),
                            ),
                          );
                        }
                        return const CircularProgressIndicator();
                      })),
            ],
          )),
    );
  }
}
