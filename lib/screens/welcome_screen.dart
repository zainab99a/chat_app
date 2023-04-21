import 'package:flutter/material.dart';

import '../widget/my_button.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        //to add space from right and left
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          //لجعل عناصر في الوسط
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           Column(children: [
             Container(
               height: 180,
               child: Image.asset('images/chat_photo.png'),
             ),
             Text('MessageMe',
             style:TextStyle(
                 fontSize: 40,
                 fontWeight:FontWeight.w500
                 ,color: Colors.blueAccent[400],
             ),
             ),
           ],
            ),
//to add space between the title and buttons
            SizedBox(
              height: 30,
            ),
// تساعد على تكوين اي شكل نريده
          //to design button
            MyButton(color: Colors.blueAccent[400]!, title: 'Sign in', onPressed: (){
              Navigator.pushNamed(context, 'signin_screen');


            },),
            MyButton(color: Colors.greenAccent[400]!, title: 'Register', onPressed: (){
              Navigator.pushNamed(context, 'registeration_screen');


            }),
          ],
        ),
      ),

    );
  }
}
