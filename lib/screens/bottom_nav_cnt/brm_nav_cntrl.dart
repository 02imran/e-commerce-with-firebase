import 'package:firebase_ecommerce_app/constants.dart';
import 'package:firebase_ecommerce_app/screens/bottom_nav_cnt/components/cart.dart';
import 'package:firebase_ecommerce_app/screens/bottom_nav_cnt/components/favourite.dart';
import 'package:firebase_ecommerce_app/screens/bottom_nav_cnt/components/home.dart';
import 'package:firebase_ecommerce_app/screens/bottom_nav_cnt/components/profile.dart';
import 'package:flutter/material.dart';

class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _page = [
    HomeScreen(),
    Favourite(),
    Cart(),
    Proofile(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.deep_orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: _page[_selectedIndex],
    );
  }
}
