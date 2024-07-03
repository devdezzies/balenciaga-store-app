import 'package:balenciaga/constants/color_scheme.dart';
import 'package:balenciaga/pages/cart_page.dart';
import 'package:balenciaga/pages/product_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  static const _widgetOptions = <Widget>[ProductList(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPage,
        children: _widgetOptions
        ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.meeting_room_outlined,
                size: 25,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.meeting_room_rounded,
                size: 25,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 25,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.shopping_bag,
                size: 25,
              ),
              label: ''),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: ColorTone.greenTone,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentPage,
        onTap: (idx) {
          setState(() {
            _currentPage = idx;
          });
        },
      ),
    );
  }
}
