import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Screens/Chat Screens/Widgets/message_bubble.dart';
import 'package:whatsapp_clone/utils/constants.dart';
import 'package:whatsapp_clone/utils/data_model.dart';

class MessgeStream extends StatefulWidget {
  MessgeStream({this.partnerUser, this.myUserID});

  User? partnerUser;
  String? myUserID;

  @override
  _MessgeStreamState createState() => _MessgeStreamState();
}

class _MessgeStreamState extends State<MessgeStream> {
  final _firestore = FirebaseFirestore.instance;
  String? conversationID;

  @override
  void initState() {
    super.initState();
    initialisation();
  }

  void initialisation() async {
    conversationID =
        createConversationID(widget.myUserID!, widget.partnerUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .doc('ZnyArP5nI8Ywb2zMntpR')
          .collection(conversationID!)
          .snapshots(),
      builder: (context, snapshot) {
        //asyncsnapshot
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageData = message.data() as Map<String, dynamic>;
          final messageText = messageData['text'];
          final messageSenderID = messageData['senderID'];

          final currentUser = widget.myUserID;

          // if(currentUser == messageSender){
          //   //the message is from the current user
          // }

          final messageBubble = MessageBubble(
            // sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSenderID,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
