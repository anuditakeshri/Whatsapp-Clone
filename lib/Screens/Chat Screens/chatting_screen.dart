import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/Screens/Chat Screens/Widgets/message_stream.dart';
import 'package:whatsapp_clone/utils/constants.dart';
import 'package:whatsapp_clone/utils/data_model.dart';

class ChattingScreen extends StatefulWidget {
  ChattingScreen({this.user, this.myUserID});

  User? user;
  String? myUserID;

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final _firestore = FirebaseFirestore.instance;

  TextEditingController controller = TextEditingController();

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
                MessgeStream(
                  partnerUser: widget.user,
                  myUserID: widget.myUserID,
                ),
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: kMessageTextFieldDecoration,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.teal.shade800,
                            child: IconButton(
                              onPressed: () async {
                                // //message text + loggedIn user
                                String conversationID = createConversationID(
                                    widget.myUserID!, widget.user!.id!);
                                if (controller.text.isNotEmpty) {
                                  _firestore
                                      .collection('messages')
                                      .doc('ZnyArP5nI8Ywb2zMntpR')
                                      .collection(conversationID)
                                      .doc(DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString())
                                      .set(
                                    {
                                      'text': controller.text,
                                      'senderID': widget.myUserID,
                                    },
                                  );
                                }
                                controller.clear();
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
