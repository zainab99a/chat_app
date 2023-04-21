import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User signinUser;//this will give us email

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextComtroller=TextEditingController();
  final _fireStore=FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
  String? messageText;//this will give us message

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  //هنا لفحص هل المستخدم قام بتسجل دخول
  void getCurrentUser(){
    try{
      final user= _auth.currentUser;
    if(user !=null)
      {
        signinUser=user;
        print(signinUser.email);
      }
    }
        catch(e){

        }
  }
  //هذه الداله لسحب البيانات من الفايرستور
 void messagesStream() async{
    await for(var snapshot in _fireStore.collection('messages').snapshots() ){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[400],
        //we have icon and text beside each others so we use row
        title: Text('MessageMe'),

        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pop(context);
          }, icon: Icon(Icons.close),),
        ],
        ),

      body: SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('messages').orderBy('time').snapshots(),
                builder:(context,snapshot){
                  List<MessageLine>messageWidgets=[];

                  //اذا ماكو اي رسائل
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent[400],
                      ),
                    );

                  }

                  final messages=snapshot.data!.docs.reversed;
                  //كي تعطي كل رسالة على حده
                  for(var message in messages){
                    final messageText=message.get('text');
                    final messageSender=message.get('sender');
                    final currentUser= signinUser.email;


                    final messageWidget=MessageLine(sender: messageSender,
                      text: messageText,
                      isMe: currentUser==messageSender,);
                    messageWidgets.add(messageWidget);

                  }

// استخدمنا لستفيو حتى الشاشه تكون scrolling
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding:EdgeInsets.symmetric(horizontal: 10,vertical: 10) ,
                      children: messageWidgets,
                    ),
                  );
                },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.blueAccent[400]!,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: TextField(
                    //مسح النص من الحقل بعد ضغط غلى زر الارسال
                    controller: messageTextComtroller,
                    onChanged: (value){
                      messageText=value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal:20 ,
                        vertical: 10,
                      ),
                      hintText: 'Write Your Message Here...',
                      border: InputBorder.none,
                    ),
                  ),
                  ),
                  TextButton(onPressed: (){
                    messageTextComtroller.clear();
                    _fireStore.collection('messages').add({
                      'text':messageText,
                      'sender':signinUser.email,
                      'time':FieldValue.serverTimestamp()
                      
                    });
                  }, child: Text(
                    'send',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ))
                ],
              ),
            ),
          ],
        ) ,
      ),
    );
  }
}
class MessageLine extends StatelessWidget {
  const MessageLine({this.sender,this.text,Key? key, required this.isMe}) : super(key: key);

  final String? sender;
  final String? text;
 final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text('$sender',
            style: TextStyle(fontSize: 12,color: Colors.black45),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: isMe? Colors.blueAccent[400]: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:10 ,horizontal:20 ),
                child: Text('$text',style: TextStyle(fontSize: 15,color: isMe? Colors.white: Colors.black87),
                ),
              ),
          ),
        ],
      ),
    );
  }
}

