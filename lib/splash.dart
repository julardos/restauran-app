import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:restaurant/list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      navigateToEligiblePage();
    });
  }

  Future<void> navigateToEligiblePage() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const ListScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Welcome",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              "to Restaurant App",
              style: TextStyle(fontSize: 18),
            ),
          ],
        )
      ),
    );
  }
}
