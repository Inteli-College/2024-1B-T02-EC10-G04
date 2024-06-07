import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/logic/calendar_funcitons.dart';
import 'package:mobile/logic/local_storage.dart';
import 'package:mobile/logic/navbar_state.dart';
import 'package:mobile/models/pyxis.dart';
import 'package:mobile/pages/orders_page.dart';
import 'package:provider/provider.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/logo_page.dart';
import 'package:mobile/pages/onboarding_page.dart';
import 'package:mobile/pages/signup_page.dart';
import 'package:mobile/pages/profile_page.dart';
import 'package:mobile/pages/new_orders_page.dart';
import 'package:mobile/pages/check_orders_page.dart';
import 'package:mobile/pages/qr_code.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env.front");
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static final LocalStorageService localStorageService = LocalStorageService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalendarLogic()),
        ChangeNotifierProvider(create: (_) => NavBarState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/new-order': (BuildContext context) => FutureBuilder<List<String?>>(
                future: Future.wait([
                  localStorageService.getValue('pyxis'),
                  localStorageService.getValue('medicine'),
                  localStorageService.getValue('medicineid'),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  } else {
                    final data = snapshot.data;
                    if (data == null || data.contains(null)) {
                      return const Center(child: Text('Missing data'));
                    } else {
                      final pyxis = data[0]!;
                      final medicine = data[1]!;
                      final medicineid = data[2]!;
                      return NewOrderPage(
                        pyxis: pyxis,
                        medicine: medicine,
                        medicineid: medicineid,
                      );
                    }
                  }
                },
              ),
          '/check-order': (context) => CheckOrderPage(
                pyxis: 'M10 G04',
                medicine: 'Ibuprofeno',
                quantity: 1,
              ),
          '/orders': (BuildContext context) => FutureBuilder<List<String?>>(
                future: Future.wait([
                  localStorageService.getValue('name'),
                  localStorageService.getValue('role'),
                  localStorageService.getValue('email'),
                ]),
                builder: (context, snapshot) {
                  final name = snapshot.data?[0] ?? 'Unknown';
                  return OrdersPage(
                    name: name,
                  );
                },
              ),
          '/profile': (context) => FutureBuilder<List<String?>>(
                future: Future.wait([
                  localStorageService.getValue('name'),
                  localStorageService.getValue('role'),
                  localStorageService.getValue('email'),
                ]),
                builder: (context, snapshot) {
                  final name = snapshot.data?[0] ?? 'Unknown';
                  final role = snapshot.data?[1] ?? 'Auxiliar de Enfermagem';
                  final email = snapshot.data?[2] ?? 'email@email.com';
                  return ProfilePage(
                    name: name,
                    role: role,
                    email: email,
                  );
                },
              ),
          '/qr-code': (context) => const QRCodePage(),
        },
      ),
    );
  }
}
