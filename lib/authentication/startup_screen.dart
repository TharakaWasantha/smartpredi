import 'package:agrogenicprl/authentication/signin_screen.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {


  @override
  void initState(){
    super.initState();
    _mockCheckForSession().then(
            (status) {
          _navigateToLogin();
        });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 6000), () {});
    return true;
  }

  void _navigateToLogin(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => SignInScreen()
        )
    );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Opacity(
                opacity: 1,
                child: Image.asset('assets/agrogenic.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,)
            ),
          ],
        ),
      ),
    );
  }
}

