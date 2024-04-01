
// import 'package:airbnb_clone/screens/chat_screen.dart';
// import 'package:airbnb_clone/screens/profile_screen.dart';
// import 'package:airbnb_clone/screens/trips_screen.dart';
// import 'package:airbnb_clone/screens/wishlist_screen.dart';

import 'package:flutter/material.dart';



import '../../Screens/Explore.dart';
import '../../Screens/chat_screen.dart';
import '../../Screens/profile_screen.dart';
import '../../Screens/trips_screen.dart';
import '../../Screens/wishlist_screen.dart';
import '../theme/colors.dart';


class AppNavBar extends StatefulWidget {
  const AppNavBar({Key? key}) : super(key: key);

  @override
  _AppNavBarState createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              const WishlistScreen() , // Replace Placeholder with HomeScreen
              Explore(), // Replace with your WishlistPage
              const TripScreen(), // Replace with your TripsPage
             ChatScreen(), // Replace with your InboxPage
              ProfilePage(), // ProfilePage
            ],
          ),
        ),
        NavigationBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          indicatorColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          height: 56.0,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              label: 'Explore',
              selectedIcon: Icon(
                Icons.search,
                color: appRed,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Wishlist',
              selectedIcon: Icon(
                Icons.favorite,
                color: appRed,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.wb_sunny_outlined),
              label: 'Trips',
              selectedIcon: Icon(
                Icons.wb_sunny,
                color: appRed,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.message_outlined),
              label: 'Inbox',
              selectedIcon: Icon(
                Icons.message,
                color: appRed,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
              selectedIcon: Icon(
                Icons.person,
                color: appRed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}






























