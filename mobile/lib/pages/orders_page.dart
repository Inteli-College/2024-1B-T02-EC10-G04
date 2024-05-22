import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/logic/calendar_funcitons.dart';
import 'package:provider/provider.dart';
import 'package:mobile/widgets/calendar.dart';
import 'package:mobile/classes/colors.dart';
import 'package:mobile/widgets/card_order.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var calendarLogic = Provider.of<CalendarLogic>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          'Welcome, Flávio!'),
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
                            fontFamily: 'Poppins',
                            fontSize: 14),
                          'History'
                          ),
                          ),
                        Tab(
                          child: Text(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14
                            ),
                          'Pedding orders'
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          CardOrder(
                                            // exemplo de uso do CardOrder
                                            orderNumber: '6978',
                                            orderDate: '2021-09-01',
                                            orderStatus: 'Order in Progress',
                                            orderValue: 'R\$ 100,00',
                                            onPressed: () {},
                                            color: AppColors.success,
                                            priority: 'Normal',
                                            pyxis: 'MS-01D',
                                            iconStatus: Icon(
                                              Icons.change_circle,
                                              color: AppColors.warning,
                                            ),
                                            medicines: [
                                              'Dipirona Monihidratada 500mg',
                                              'Nimesulida 100mg'
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          // card aqui
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
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

