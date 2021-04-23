import 'package:quicksale/models/user.dart';
import 'package:quicksale/services/auth.dart';
import 'package:quicksale/shared/loading.dart';
import 'package:quicksale/views/shop_views_screen/index.views.dart';
import 'package:quicksale/views/splash_views_screen/splash.view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MultiProvider(providers: [
    Provider<AuthService>(
      create: (_) => AuthService(),
    ),
    StreamProvider(
      initialData: UserModel(),
      create: (context) => context.read<AuthService>().user,
    ),
  ], child: MaterialApp(home: MyApp())));
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        print(snapshot.connectionState == ConnectionState.done);
        // Check for errors
        if (snapshot.hasError) {
          return snapshot.error;
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          if (user != null) {
            Timer(
                Duration(seconds: 6),
                () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Shop())));
          } else {
            Timer(
                Duration(seconds: 6),
                () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home())));
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}
