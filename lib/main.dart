// // import 'package:docu/Screens/splash_s.dart';
// import 'package:flutter/material.dart';
//
//
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/services.dart';
// import 'Screens/Auth/login_screen.dart';
// import 'Screens/login.dart';
// import 'firebase_options.dart';
//
//
// late Size mq;
//
//
// void main() {
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   _initializeFirebase();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Docu Care',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: LoginS(),
//     );
//   }
// }
//
//
// _initializeFirebase() async
// {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }


//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'firebase_options.dart';
// import 'shared/navigation/app_router.dart';
// import 'shared/theme/colors.dart';
//
//
// late Size mq;
//
//
// void main() {
//   runApp(const MyApp());
//
//     WidgetsFlutterBinding.ensureInitialized();
//
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     _initializeFirebase();
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(seedColor: appRed),
//       ),
//       routerConfig: AppRouter().router,
//     );
//   }
// }
//
// _initializeFirebase() async
// {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }
//
//





import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/Auth/login_screen.dart';
import 'Screens/Auth/login_screen.dart';
import 'firebase_options.dart';
import 'shared/navigation/app_router.dart';
import 'shared/theme/colors.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: appRed),
      ),
      routerConfig: AppRouter().router,
    );
  }
}
