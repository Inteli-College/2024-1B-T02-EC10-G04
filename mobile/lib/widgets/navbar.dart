import 'package:flutter/material.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/widgets/navbar_icon.dart';

class NavBarContainer extends StatelessWidget {
  const NavBarContainer({super.key});
  @override
  Widget build(context) {
    return Container(
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
          border: Border(
            left: BorderSide(
                color: Color.fromARGB(255, 243, 243, 244), width: 0.5),
            right: BorderSide(
                color: Color.fromARGB(255, 243, 243, 244), width: 0.5),
            top: BorderSide(
                color: Color.fromARGB(255, 243, 243, 244), width: 0.5),
          ),
          color: AppColors.white50,
        ),
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              NavBarIcon(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  index: 0,
                  route: '/orders'),
              NavBarIcon(
                  icon: Icons.new_label_rounded,
                  label: 'Create',
                  index: 1,
                  route: '/orders'),
              NavBarIcon(
                  icon: Icons.person,
                  label: 'Profile',
                  index: 2,
                  route: '/profile'),
              NavBarIcon(
                  icon: Icons.settings,
                  label: 'Settings',
                  index: 3,
                  route: '/settings'),
            ]));
  }
}
