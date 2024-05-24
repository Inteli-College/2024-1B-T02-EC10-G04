import 'package:flutter/material.dart';
import 'package:mobile/widgets/card_order.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/models/order.dart';

class TabSession extends StatefulWidget {
  final Future<List<Order>> orders;

  @override
  // ignore: library_private_types_in_public_api
  _TabSessionState createState() => _TabSessionState();

  const TabSession({
    super.key,
    required this.orders,
  });
}

class _TabSessionState extends State<TabSession> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder<List<Order>>(
                      future: widget.orders,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return CardOrder(
                                orderNumber: '#1234123',
                                orderDate: snapshot.data![index].createdAt!,
                                orderStatus: snapshot.data![index].status!,
                                orderValue: 'R\$ 100,00',
                                onPressed: () {},
                                color: AppColors.success,
                                priority: snapshot.data![index].priority!,
                                pyxis: 'MS-01D',
                                iconStatus: const Icon(
                                  Icons.change_circle,
                                  color: AppColors.warning,
                                ),
                                medicines: const [
                                  'Dipirona Monihidratada 500mg',
                                  'Nimesulida 100mg'
                                ],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      })),
            ],
          )),
    );
  }
}
