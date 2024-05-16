import 'package:flutter/material.dart';
import 'package:mobile/widgets/custom_icon.dart';

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
          color: Color.fromARGB(255, 249, 250, 251),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, 
            children: <Widget>[
              CustomIconButton(
                icon: const Icon(Icons.home_rounded,
                    size: 25, color: Color.fromARGB(255, 130, 130, 130)),
                label: 'Home',
                onPressed: () {
                  // 
                },
              ),
              CustomIconButton(
                icon: const Icon(Icons.new_label_rounded,
                    size: 25, color: Color.fromARGB(255, 130, 130, 130)),
                label: 'Create',
                onPressed: () {
                  // 
                },
              ),
              CustomIconButton(
                icon: const Icon(Icons.person,
                    size: 25, color: Color.fromARGB(255, 130, 130, 130)),
                label: 'Profile',
                onPressed: () {
                  // 
                },
              ),
              CustomIconButton(
                icon: const Icon(Icons.settings,
                    size: 25, color: Color.fromARGB(255, 130, 130, 130)),
                label: 'Settings',
                onPressed: () {
                  // 
                },
              ),
            ]));
  }
}
