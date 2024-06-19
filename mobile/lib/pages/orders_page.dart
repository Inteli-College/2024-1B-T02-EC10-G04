import 'package:flutter/material.dart';
import 'package:mobile/logic/calendar_funcitons.dart';
import 'package:provider/provider.dart';
import 'package:mobile/widgets/calendar.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/widgets/navbar.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/services/orders.dart';
import 'package:mobile/widgets/tab_session_history.dart';
import 'package:mobile/widgets/tab_session.dart';
import 'dart:async';

class OrdersPage extends StatefulWidget {
  final String name;

  @override
  // ignore: library_private_types_in_public_api
  _OrdersPageState createState() => _OrdersPageState();

  const OrdersPage({super.key, required this.name});
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<Order>> futureMedicineOrders;
  final OrderService orderService = OrderService();
  late Timer _timer;
  
  @override
  void initState() {
    super.initState();
    
    futureMedicineOrders = orderService.getOrders();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _fetchData() {
    setState(() {
      futureMedicineOrders = orderService.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CalendarLogic>(context);
    late String name = widget.name;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: const NavBarContainer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, $name!',
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black50),
                      ),
                    ],
                  )),
              buildCalendarSelector(context),
              const SizedBox(height: 10),
              buildDaysCalendar(context),
              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  children: [
                    const TabBar(
                      indicatorColor: AppColors.secondary,
                      labelColor: AppColors.secondary,
                      tabs: [
                        Tab(
                          child: Text(
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 14),
                              'Pedding orders'),
                        ),
                        Tab(
                          child: Text(
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 14),
                              'History'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          TabSessionPendingOrders(
                            orders: futureMedicineOrders,
                          ),
                          TabSessionHistory(
                            orders: futureMedicineOrders,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
