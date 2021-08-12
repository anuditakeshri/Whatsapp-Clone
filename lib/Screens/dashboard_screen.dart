import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/Screens/calls_screen.dart';
import 'package:whatsapp_clone/Screens/camera_screen.dart';
import 'package:whatsapp_clone/Screens/chat_screen.dart';
import 'package:whatsapp_clone/Screens/status_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen(this.cameras);

  var cameras;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: null,
          child: Icon(Icons.message),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff075E54),
          title: Text(
            'WhatsApp',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Icon(
              FontAwesomeIcons.search,
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
          bottom: TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
              icon: Icon(
                FontAwesomeIcons.camera,
                size: 20.0,
              ),
            ),
            Tab(
              text: 'CHATS',
            ),
            Tab(
              text: 'STATUS',
            ),
            Tab(
              text: 'CALLS',
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            CameraScreen(widget.cameras),
            ChatScreen(),
            StatusScreen(),
            CallScreen()
          ],
        ),
      ),
    );
  }
}
