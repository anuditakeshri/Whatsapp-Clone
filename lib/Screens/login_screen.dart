import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/Screens/otp_verification_screen.dart';
import 'package:whatsapp_clone/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedCountry;

  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCountry = countriesList[0];
  }

  @override
  Widget build(BuildContext context) {
    DropdownButton<String> countryPicker() {
      List<DropdownMenuItem<String>> dropDownItems = [];
      for (String country in countriesList) {
        var newItem = DropdownMenuItem(
          child: SizedBox(
              width: 200.0,
              child: Text(
                country,
                textAlign: TextAlign.center,
              )),
          value: country,
        );
        dropDownItems.add(newItem);
      }

      return DropdownButton<String>(
        value: selectedCountry,
        isExpanded: true,
        underline: Container(
          height: 2.0,
          color: Color(0xff428A7D),
        ),
        items: dropDownItems,
        onChanged: (value) {
          setState(
            () {
              selectedCountry = value;
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  'Verify your phone number',
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
            height: 50.0,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'WhatsApp will send an SMS message(carrier charges '
                  'may apply)to verify your phone number. Enter your country code and'
                  'phone number:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff868686), fontSize: 18.0, height: 1.5),
                ),
              ),
              Container(width: 200.0, child: countryPicker()),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0, left: 20.0),
                    width: 90.0,
                    child: TextField(
                      controller: countryCodeController,
                      autofocus: true,
                      style: TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            FontAwesomeIcons.plus,
                            size: 10.0,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff428A7D),
                          )),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.teal,
                      cursorHeight: 25.0,
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
                    width: 200.0,
                    child: TextField(
                      // smartDashesType: SmartDashesType.enabled,
                      controller: phoneNumberController,
                      style: TextStyle(fontSize: 20.0),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'phone number',
                        labelStyle: TextStyle(
                          color: Color(0xff428A7D),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      cursorHeight: 25.0,
                      cursorColor: Colors.teal,
                    ),
                  )
                ],
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Container(
            margin: EdgeInsets.only(bottom: 25.0),
            child: RawMaterialButton(
              elevation: 5.0,
              onPressed: () {
                print('next button was pressed');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OtpVerify(
                    countryCode: countryCodeController.text,
                    phoneNumber: phoneNumberController.text,
                  );
                }));
              },
              fillColor: Colors.green,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
                child: Text(
                  'NEXT',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'You must be ',
                style: TextStyle(color: Color(0xff868686)),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'at least 16 years old ',
                      style: TextStyle(color: Colors.blue)),
                  TextSpan(
                      text: 'to register. Learn how WhatsApp works with the',
                      style: TextStyle(color: Color(0xff868686))),
                  TextSpan(
                      text: ' Facebook Companies',
                      style: TextStyle(color: Colors.blue)),
                ],
              ),
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
