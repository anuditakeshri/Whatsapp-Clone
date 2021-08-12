import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/utils/constants.dart';
import 'package:whatsapp_clone/utils/data_model.dart';

class ChattingScreen extends StatefulWidget {
  ChattingScreen({this.user});

  User? user;

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/background.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // leading: null,
            backgroundColor: Color(0xff075E54),
            title: Row(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.arrowLeft),
                    SizedBox(
                      width: 10.0,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.user!.imageURL!),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
              Text(
                widget.user!.name!,
                style: TextStyle(color: Colors.white),
              ),
            ]),
            actions: [
              Icon(
                FontAwesomeIcons.video,
                size: 20.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Icon(
                FontAwesomeIcons.phoneAlt,
                size: 20.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Icon(
                FontAwesomeIcons.ellipsisV,
                size: 20.0,
              ),
              SizedBox(
                width: 10.0,
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                      // color: Colors.pink,
                      ),
                ),
                // MessgeStream(),
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            // controller: messageTextController,
                            // onChanged: (value) {
                            //   messageText = value;
                            // },
                            decoration: kMessageTextFieldDecoration,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.teal.shade800,
                            child: IconButton(
                              onPressed: () {
                                // messageTextController.clear();
                                // //message text + loggedIn user
                                // _fireStore
                                //     .collection('messages')
                                //     .doc(DateTime.now().millisecondsSinceEpoch.toString())
                                //     .set({
                                //   'text': messageText,
                                //   'sender': loggedInUser.email,
                                // });
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
