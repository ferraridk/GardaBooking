import 'dart:async';

import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }


  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, '/'));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Center(child: Image(image: AssetImage('assets/logo.png'),
        width: 250,
          height: 250,
        ),
        ),
          SizedBox(height: 30),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text('GardaBooking', style: Theme.of(context)
              .textTheme.headlineLarge!
              .copyWith(color: Colors.white),
          ),
          ),
      ],
      ),
    );
  }
}