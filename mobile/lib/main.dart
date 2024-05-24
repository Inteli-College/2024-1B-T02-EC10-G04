import 'package:flutter/material.dart';
import 'package:mobile/logic/calendar_funcitons.dart';
import 'package:mobile/logic/local_storage.dart';
import 'package:mobile/logic/navbar_state.dart';
import 'package:mobile/pages/orders_page.dart';
import 'package:provider/provider.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/logo_page.dart';
import 'package:mobile/pages/onboarding_page.dart';
import 'package:mobile/pages/signup_page.dart';
import 'package:mobile/pages/profile_page.dart';
import 'package:mobile/pages/settings_page.dart';

void main() {
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
          '/orders': (BuildContext context) => FutureBuilder<List<String?>>(
                future: Future.wait([
                  localStorageService.getValue('name'),
                  localStorageService.getValue('role'),
                  localStorageService.getValue('email'),
                ]),
                builder: (context, snapshot) {
                  final name = snapshot.data?[0] ?? 'Unknown';
                  final role = snapshot.data?[1] ?? 'Auxiliar de Enfermagem';
                  final email = snapshot.data?[2] ?? 'email@email.com';
                  return OrdersPage(
                    name: name,
                    role: role,
                    email: email,
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
          '/settings': (context) => const SettingsPage(),
        },
      ),
    );
  }
}
