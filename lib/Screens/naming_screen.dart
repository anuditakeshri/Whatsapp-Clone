import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController controller = TextEditingController();

  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  File image = File('');
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                          image.path.isEmpty ? null : FileImage(image),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          final pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery);
                          setState(
                            () {
                              image = File(pickedFile!.path);
                            },
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Enter your name and add an optional profile picture',
                    style: TextStyle(color: Color(0xff868686), fontSize: 18.0),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: 300.0,
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(hintText: 'Enter your name'),
              autofocus: true,
              cursorColor: Colors.teal,
              cursorHeight: 25.0,
            ),
          ),
          RawMaterialButton(
            elevation: 5.0,
            onPressed: () async {
              final SharedPreferences prefs = await _prefs;
              final userID = await prefs.getString('userID');
              await _storage.ref('profileURL/$userID').putFile(image);
              String imgURL =
                  await _storage.ref('profileURL/$userID').getDownloadURL();
              await _firestore.collection('users').doc(userID).update(
                {'name': controller.text, 'imageURL': imgURL},
              );
              await prefs.setBool('isProfileCreated', true);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/dashboard', (route) => false);
            },
            fillColor: Colors.green,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text('NEXT',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
          )
        ],
      ),
    );
  }
}
