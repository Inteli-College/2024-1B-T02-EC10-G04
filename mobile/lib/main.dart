import 'package:flutter/material.dart';
import 'package:mobile/logic/calendar_funcitons.dart';
import 'package:mobile/logic/navbar_state.dart';
import 'package:mobile/pages/orders_page.dart';
import 'package:provider/provider.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/logo_page.dart';
import 'package:mobile/pages/onboarding_page.dart';
import 'package:mobile/pages/signup_page.dart';
import 'package:mobile/pages/profile_page.dart';
import 'package:mobile/pages/new_orders_page.dart';
import 'package:mobile/pages/check_orders_page.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          '/orders': (BuildContext context) => const OrdersPage(),
          '/new-order': (context) => const NewOrderPage(
            pyxis: 'M10 G04', 
            medicine: 'Ibuprofeno',
            lote: '4679',
          ),
          '/check-order': (context)=> const CheckOrderPage(
            pyxis: 'M10 G04', 
            medicine: 'Ibuprofeno',
            quantity: 1,
          ),
          '/profile': (context) => const ProfilePage(
                name: 'Flávio José da Silva',
                role: 'Auxiliar de Enfermagem',
                email: 'email@email.com',)
        },
      ),
    );
  }
}

