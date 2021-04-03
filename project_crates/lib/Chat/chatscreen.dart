// import 'dart:io';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'chatmessage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
// //import 'package:projectcrates/auth.dart';

// const String _name = "Edan Kang";

// class ChatScreen extends StatefulWidget {
//   ChatScreen(String title, {Key key, this.currentUserId, this.chatUserId})
//       : _title = title,
//         super(key: key);

//   final _title;
//   final currentUserId;
//   final chatUserId;

//   @override
//   State createState() => _ChatScreenState(_title);
// }

// class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
//   final _title;
//   final List<ChatMessage> _messages;
//   final TextEditingController _textController;
//   final DatabaseReference _messageDatabaseReference;
//   final StorageReference _photoStorageReference;
//   final bool _isComposing = false;

//   final chatUserId;
//   final currentUserId;

//   _ChatScreenState(String title)
//       : _title = title,
//         _isComposing = false,
//         _messages = <ChatMessage>[],
//         _textController = TextEditingController(),
//         _messageDatabaseReference =
//             FirebaseDatabase.instance.reference().child("testmessages"),
//         _photoStorageReference =
//             FirebaseStorage.instance.ref().child("chat_photos") {
//     _messageDatabaseReference.onChildAdded.listen(_onMessageAdded);
//   }

//   Widget _buildTextComposer() {
//     return IconTheme(
//         data: IconThemeData(color: Theme.of(context).accentColor),
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             children: <Widget>[
//               Flexible(
//                 child: TextField(
//                   controller: _textController,
//                   onChanged: (String text) {
//                     setState(() {
//                       _isComposing = text.length > 0;
//                     });
//                   },
//                   onSubmitted: _handleSubmitted,
//                   decoration:
//                       InputDecoration.collapsed(hintText: "Send a message"),
//                 ),
//               ),
//               Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                   child: Row(
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(Icons.camera_alt),
//                         onPressed: _sendImageFromCamera,
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.image),
//                         onPressed: _sendImageFromGallery,
//                       ),
//                       Theme.of(context).platform == TargetPlatform.iOS
//                           ? CupertinoButton(
//                               child: Text("Send"),
//                               onPressed: _isComposing
//                                   ? () => _handleSubmitted(_textController.text)
//                                   : null,
//                             )
//                           : IconButton(
//                               icon: Icon(Icons.send),
//                               onPressed: _isComposing
//                                   ? () => _handleSubmitted(_textController.text)
//                                   : null,
//                             ),
//                     ],
//                   ))
//             ],
//           ),
//         ));
//   }

//   void _onMessageAdded(Event event) {
//     final text = event.snapshot.value["text"];
//     final imageUrl = event.snapshot.value["imageUrl"];

//     ChatMessage message = imageUrl == null
//         ? _createMessageFromText(text)
//         : _createMessageFromImage(imageUrl);

//     setState(() {
//       _messages.insert(0, message);
//     });

//     message.animationController.forward();
//   }

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     setState(() {
//       _isComposing = false;
//     });

//     final ChatMessage message = _createMessageFromText(text);
//     _messageDatabaseReference.push().set(message.toMap());
//   }

//   ChatMessage _createMessageFromText(String text) {
//     ChatMessage(
//       text: text,
//       username: _name,
//       // userId: userId,
//       animationController: AnimationController(
//         duration: Duration(milliseconds: 180),
//         vsync: this,
//       ),
//     );
//   }

//   void _sendImage(ImageSource imageSource) async {
//     File image = await ImagePicker.pickImage(source: imageSource);
//     final String fileName = Uuid().v4();
//     StorageReference photoRef = _photoStorageReference.child(fileName);
//     final StorageUploadTask uploadTask = photoRef.putFile(image);
//     final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
//     final ChatMessage message = _createMessageFromImage(
//       await downloadUrl.ref.getDownloadURL(),
//     );
//     _messageDatabaseReference.push().set(message.toMap());
//   }

// //allow users to send image from camera
//   void _sendImageFromCamera() async {
//     _sendImage(ImageSource.camera);
//   }

// //allow users to send image from gallery
//   void _sendImageFromGallery() async {
//     _sendImage(ImageSource.gallery);
//   }

// //text message

// //image message
//   ChatMessage _createMessageFromImage(String imageUrl) => ChatMessage(
//         imageUrl: imageUrl,
//         username: _name,
//         //userId: userId,
//         animationController: AnimationController(
//           duration: Duration(milliseconds: 90),
//           vsync: this,
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_title),
//         elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Flexible(
//               child: ListView.builder(
//                 padding: EdgeInsets.all(8.0),
//                 reverse: true,
//                 itemBuilder: (_, int index) => _messages[index],
//                 itemCount: _messages.length,
//               ),
//             ),
//             Divider(height: 1.0),
//             Container(
//               decoration: BoxDecoration(color: Theme.of(context).cardColor),
//               child: _buildTextComposer(),
//             ),
//           ],
//         ),
//         decoration: Theme.of(context).platform == TargetPlatform.iOS
//             ? BoxDecoration(
//                 border: Border(
//                 top: BorderSide(color: Colors.grey[200]),
//               ))
//             : null,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     for (ChatMessage message in _messages)
//       message.animationController.dispose();
//     super.dispose();
//   }
// }
