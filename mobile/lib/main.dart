import 'package:flutter/material.dart';
import 'package:mobile/logic/calendar_funcitons.dart';
import 'package:mobile/pages/orders_page.dart';
import 'package:provider/provider.dart';
import 'package:mobile/pages/logo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CalendarLogic()),
        ],
        child: MaterialApp(
          routes: {
            '/orders': (BuildContext context) => OrdersPage(),
          },
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ));
  }
}
