import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', width: 200),
            ]
          )
        )
      )
    );
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }
}


