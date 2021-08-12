import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerify extends StatefulWidget {
  OtpVerify({this.countryCode, this.phoneNumber});

  String? phoneNumber;
  String? countryCode;

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  bool showSpinner = false;

  String? code;

  int? time;
  Timer? timer;
  Color? color = Color(0xff868686);

  String buildTime(int? t) {
    if (t! < 10) {
      return '00:0$t';
    } else {
      return '00:$t';
    }
  }

  String? mobileNumber;

  @override
  void initState() {
    super.initState();
    mobileNumber = '+' + widget.countryCode! + widget.phoneNumber!;
    time = 59;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        // setState(() {
        //   if (time == 0) {
        //     timer.cancel();
        //     color = Color(0xff428A7D);
        //   } else {
        //     time = (time! - 1)!;
        //   }
        // });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Text(
                      'Verify + ${widget.countryCode}' +
                          ' ${widget.phoneNumber}',
                      style: TextStyle(
                          color: Color(0xff428A7D),
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      FontAwesomeIcons.ellipsisV,
                      color: Color(0xff868686),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:
                        'Waiting to automatically detect an SMS sent to + ${widget.countryCode} ${widget.phoneNumber}. ',
                    style: TextStyle(color: Colors.black),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Wrong number?',
                          style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: 200.0,
                child: TextField(
                  onChanged: (value) {
                    code = value;
                  },
                  style: TextStyle(fontSize: 20.0),
                  autofocus: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Color(0xff428A7D)),
                  ),
                  keyboardType: TextInputType.phone,
                  cursorHeight: 25.0,
                  cursorColor: Color(0xff868686),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Enter 6-digit code',
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.commentAlt, color: color),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Resend SMS',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
                Expanded(child: SizedBox()),
                Text(
                  buildTime(time),
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
            width: 315.0,
            child: Divider(
              color: Colors.black,
              thickness: 1.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.phoneAlt,
                  color: color,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Call me',
                  style: TextStyle(color: color, fontSize: 20.0),
                ),
                Expanded(child: SizedBox()),
                Text(
                  buildTime(time),
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: showSpinner
                ? CircularProgressIndicator()
                : RawMaterialButton(
                    elevation: 5.0,
                    onPressed: () {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final user = _auth.verifyPhoneNumber(
                            phoneNumber: mobileNumber!,
                            verificationCompleted:
                                (PhoneAuthCredential credential) async {
                              await _auth.signInWithCredential(credential);
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              if (e.code == 'invalid-phone-number') {
                                print(
                                    'The provided phone number is not valid.');
                              }
                            },
                            codeSent: (String verificationId,
                                int? resendToken) async {
                              // Update the UI - wait for the user to enter the SMS code
                              String smsCode = code!;

                              // Create a PhoneAuthCredential with the code
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: smsCode);

                              // Sign the user in (or link) with the credential
                              await _auth
                                  .signInWithCredential(credential)
                                  .then((value) async {
                                await _firestore
                                    .collection('users')
                                    .doc(widget.phoneNumber)
                                    .set(
                                  {'phoneNumber': mobileNumber},
                                  SetOptions(merge: true),
                                );
                                final SharedPreferences prefs = await _prefs;
                                prefs.setString('userID', widget.phoneNumber!);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/profile', (route) => false);
                              });
                            },
                            codeAutoRetrievalTimeout: (String verID) {});
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'NEXT',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    ),
                    fillColor: Colors.green,
                  ),
          )
        ],
      ),
    );
  }
}
