import 'package:flutter/material.dart';
import 'package:projectcrates/helpers/items.dart';
import 'package:projectcrates/activity.dart';
import 'package:projectcrates/pages/notificationpage.dart';

class ChatPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          chatHeader(),
          Container(
              child: SingleChildScrollView(
            child: // CHILD 1
                ListView.builder(
              //CHILD 2
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              itemCount: hello.length,
              itemBuilder: (context, index) {
                final item = hello[index];
                return Card(
                    child: ListTile(
                  leading:
                      FlutterLogo(), //  TODO how to change to profile picture
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChattingPage(
                                //TODO change to chatpage
                                messageitem:
                                    hello[index]))); // to go  to notifcation
                  },
                  title: item.buildTitle(context),
                  subtitle: item.buildSubtitle(context),
                  trailing: Icon(Icons
                      .keyboard_arrow_right), //TODO need to change the icon to arrow
                  isThreeLine: true,
                ));
              },
            ),
          ))
        ],
      ),
    );
  }
}

// create chat header
Widget chatHeader() {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('Chat', style: TextStyle(fontSize: 20)),
          )),
      Align(
          alignment: Alignment.centerRight,
          child: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: TextButton.icon(
                icon: Icon(Icons.sort),
                label: Text('Sort'),
                onPressed: () {},
              )))
    ],
  ));
}

class ChattingPage extends StatelessWidget {
  final MessageItem messageitem;

  ChattingPage({Key key, @required this.messageitem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber[400],
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.keyboard_backspace), // need to change
                onPressed: () {
                  Navigator.pop(context);
                });
          }),
          title: Text("Name of Person",
              style: TextStyle(fontSize: 30, color: Colors.white)),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.0))),
        ),
        body: Column(children: <Widget>[
          Text('Name of the dude'),
          secondRow(),
          //how to put text???,
          chat(),
          enterMessage(),
        ]));
  }
}

Widget secondRow() {
  return Container(
      child: Row(children: <Widget>[
    Text('picture but I put as text <3'),
    Column(children: <Widget>[
      Text('Listing name'),
      TextButton(onPressed: () {}, child: Text('COmplete Listing'))
    ]),
    TextButton(
      onPressed: () {},
      child: Text('Leave Review'),
    )
  ]));
}

Widget chat() {
  return Container(child: Text('just chatting'));
}

Widget enterMessage() {
  return Container(
    child: Row(children: [
      TextField(
        decoration: InputDecoration(labelText: 'Message'),
      ),
      IconButton(
          icon: const Icon(Icons.attach_file),
          onPressed: () {}) //TODO ATTACH FILE
    ]),
  );
}
