import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'package:mobile/pages/new_orders_page.dart';
import 'package:mobile/pages/check_orders_page.dart';
import 'package:mobile/pages/qr_code.dart';
import 'package:mobile/pages/settings_page.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: ".env.front");
  } catch (error) {
    print("Error loading .env.front file: $error");
  } finally {
    String? name = await LocalStorageService().getValue('name');
    String? role = await LocalStorageService().getValue('role');
    String? email = await LocalStorageService().getValue('email');

    runApp(HomeScreen(name: name, role: role, email: email));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {super.key, required this.name, required this.role, required this.email});
  final String? name;
  final String? role;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalendarLogic()),
        ChangeNotifierProvider(create: (_) => NavBarState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //initialRoute: '/orders',
        home: const SplashScreen(),
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          NewOrderPage.routeName: (context) =>
          const NewOrderPage(),
          CheckOrderPage.routeName: (context) => 
          const CheckOrderPage(),
          '/orders': (BuildContext context) => OrdersPage(
                name: name ?? 'Unknown',
              ),
          '/profile': (context) => ProfilePage(
                name: name ?? 'Unknown',
                role: role ?? 'Unknown',
                email: email ?? 'Unknown',
              ),
          '/qr-code': (context) => const QRCodePage(),
          '/settings': (context) => const SettingsPage(),
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:mobile/logic/calendar_functions.dart';
// import 'package:mobile/logic/local_storage.dart';
// import 'package:mobile/logic/navbar_state.dart';
// import 'package:mobile/pages/orders_page.dart';
// import 'package:mobile/provider.dart';
// import 'package:mobile/pages/login_page.dart';
// import 'package:mobile/pages/logo_page.dart';
// import 'package:mobile/pages/onboarding_page.dart';
// import 'package:mobile/pages/signup_page.dart';
// import 'package:mobile/pages/profile_page.dart';
// import 'package:mobile/pages/new_orders_page.dart';
// import 'package:mobile/pages/check_orders_page.dart';
// import 'package:mobile/pages/qr_code.dart';
// import 'package:mobile/pages/settings_page.dart';
// import 'package:mobile/pages/page1.dart'; // Importar página 1
// import 'package:mobile/pages/page2.dart'; // Importar página 2
// import 'package:mobile/pages/page3.dart'; // Importar página 3

// Future<void> main() async {
//   try {
//     await dotenv.load(fileName: ".env.front");
//   } catch (error) {
//     print("Error loading .env.front file: $error");
//   } finally {
//     String? name = await LocalStorageService().getValue('name');
//     String? role = await LocalStorageService().getValue('role');
//     String? email = await LocalStorageService().getValue('email');

//     runApp(HomeScreen(name: name, role: role, email: email));
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key, required this.name, required this.role, required this.email});
//   final String? name;
//   final String? role;
//   final String? email;

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: () => CalendarLogic()),
//         ChangeNotifierProvider(create: () => NavBarState()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         //initialRoute: '/orders',
//         home: const SplashScreen(),
//         routes: {
//           '/onboarding': (context) => const OnboardingScreen(),
//           '/login': (context) => const LoginScreen(),
//           '/signup': (context) => const SignUpScreen(),
//           NewOrderPage.routeName: (context) => const NewOrderPage(),
//           CheckOrderPage.routeName: (context) => const CheckOrderPage(),
//           '/orders': (BuildContext context) => OrdersPage(
//             name: name ?? 'Unknown',
//           ),
//           '/profile': (context) => ProfilePage(
//             name: name ?? 'Unknown',
//             role: role ?? 'Unknown',
//             email: email ?? 'Unknown',
//           ),
//           '/qr-code': (context) => const QRCodePage(),
//           '/settings': (context) => const SettingsPage(),
//           '/page1': (context) => const Page1(), // Adicionar rota da página 1
//           '/page2': (context) => const Page2(), // Adicionar rota da página 2
//           '/page3': (context) => const Page3(), // Adicionar rota da página 3
//         },
//       ),
//     );
//   }
// }
