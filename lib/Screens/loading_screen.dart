import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void checkLogin() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getString('userID') == null) {
      Navigator.pushReplacementNamed(context, '/tc');
    } else if (prefs.getBool('isProfileCreated') == null) {
      Navigator.pushReplacementNamed(context, '/profile');
    } else {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) => checkLogin());
    // checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Image.asset(
            'images/whatsapp_logo.png',
            height: 90.0,
          ),
          Expanded(child: SizedBox()),
          Center(
            child: Text(
              'from',
              style: TextStyle(color: Color(0xff868686), fontSize: 15.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              'FACEBOOK',
              style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
