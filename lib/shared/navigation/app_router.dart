
// import 'package:airbnb_clone/screens/home_screen.dart';
// import 'package:airbnb_clone/screens/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homies/Screens/login.dart';

import '../../Screens/Auth/login_screen.dart';
import '../../Screens/home_screen.dart';
// import '../../Screens/login.dart';
import '../../Screens/splash_screen1.dart';
import '../../screens/booking_details_screen.dart';


import '../theme/colors.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: '/login', // Set initial route to the splash screen
    routes: <GoRoute>[
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return  LoginPage(); // Return the splash screen widget
        },
      ),
      // GoRoute(
      //   name: 'login',
      //   path: '/Auth/loginS',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const LoginS(); // Return the splash screen widget
      //   },
      // ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        name: 'booking-details',
        path: '/booking-details',
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            opaque: false,
            barrierColor: appBlack.withOpacity(0.5),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
            child: const BookingDetailsScreen(),
          );
        },
      ),
    ],
  );
}




// class AppRouter {
//   late final GoRouter router = GoRouter(
//     routes: <GoRoute>[
//       GoRoute(
//         name: 'home',
//         path: '/',
//         builder: (BuildContext context, GoRouterState state) {
//           return const HomeScreen();
//         },
//       ),
//       GoRoute(
//         name: 'booking-details',
//         path: '/booking-details',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage<void>(
//             key: state.pageKey,
//             opaque: false,
//             barrierColor: appBlack.withOpacity(0.5),
//             transitionDuration: const Duration(milliseconds: 300),
//             reverseTransitionDuration: const Duration(milliseconds: 300),
//             child: const BookingDetailsScreen(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return child;
//             },
//           );
//         },
//       ),
//     ],
//   );
// }

// Navigator.push(
//   context,
//   PageRouteBuilder(
//     opaque: false,
//     barrierColor: appBlack.withOpacity(0.5),
//     transitionDuration: const Duration(milliseconds: 300),
//     reverseTransitionDuration: const Duration(
//       milliseconds: 300,
//     ),
//     transitionsBuilder: (
//       context,
//       animation,
//       secondaryAnimation,
//       child,
//     ) {
//       return child;
//     },
//     pageBuilder: (context, animation1, animation2) {
//       return BackdropFilter(
//         filter: ImageFilter.blur(
//           sigmaX: 8.0,
//           sigmaY: 8.0,
//         ),
//         child: const BookingDetailsScreen(),
//       );
//     },
//   ),
// ),