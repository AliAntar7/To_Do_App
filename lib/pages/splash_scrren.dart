import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer ;

  _startDelay()
  {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext ()
  {
    Navigator.pushReplacementNamed(context, 'Home');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.indigo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const
          [
            Image(
              image: AssetImage('assets/images/todo.png'),
              width: 250.0,
              height: 250.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'To Do App',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 200.0,
            ),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
