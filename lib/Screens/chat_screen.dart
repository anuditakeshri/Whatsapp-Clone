import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/Screens/Chat%20Screens/chatting_screen.dart';
import 'package:whatsapp_clone/utils/data_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<User> users = <User>[];

  final _firestore = FirebaseFirestore.instance;
  String? myUserID;

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic>? initialisation() async {
    print('initialisation started');
    final SharedPreferences prefs = await _prefs;
    myUserID = await prefs.getString('userID');
    if (users.isEmpty) {
      await _firestore.collection('users').get().then(
        (value) {
          value.docs.forEach(
            (element) {
              // print(element.data());
              if (element.id != myUserID) {
                users.add(
                  User(
                      name: (element.data() as Map)['name'],
                      imageURL: (element.data() as Map)['imageURL'],
                      id: (element.id)),
                );
              }
            },
          );
        },
      );
    }
    print('initialisation ended');
    // await Future.delayed(Duration(seconds: 1));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialisation(),
        builder: (context, AsyncSnapshot state) {
          print(state);
          if (state.connectionState == ConnectionState.done) {
            print('build main UI');
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 16.0, 8.0),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChattingScreen(
                              myUserID: myUserID,
                              user: users[index],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(users[index].name!),
                        subtitle: Text('Recent message'),
                        trailing: Text(DateTime.now().hour.toString() +
                            ':' +
                            DateTime.now().minute.toString()),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index].imageURL!),
                          backgroundColor: Colors.transparent,
                          radius: 40.0,
                        ),
                      ),
                    );
                  }),
            );
          } else {
            print('Loading UI');
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
