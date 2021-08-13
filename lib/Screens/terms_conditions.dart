import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Center(
            child: Text(
              'Welcome To WhatsApp',
              style: TextStyle(
                  color: Color(0xff428A7D),
                  fontSize: 40.0 * (350 / (MediaQuery.of(context).size.width)),
                  fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ),
          Expanded(child: SizedBox()),
          Image.asset('images/whatsapp_tc.png'),
          Expanded(child: SizedBox()),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Read our ',
                style: TextStyle(color: Color(0xff868686)),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Private Policy ',
                      style: TextStyle(color: Colors.blue)),
                  TextSpan(
                      text: '.Tap "Agree and Continue" to accept the',
                      style: TextStyle(color: Color(0xff868686))),
                  TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
          // Expanded(child: SizedBox()),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              fillColor: Colors.green,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 60.0, vertical: 12.0),
                child: Text(
                  'AGREE AND CONTINUE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
              elevation: 5.0,
            ),
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
