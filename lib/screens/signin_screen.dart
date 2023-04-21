import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widget/my_button.dart';
class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  //لتسجيل مستخدم موجود سابقا
  final _auth=FirebaseAuth.instance;
  //we create variable  to save data
  //we add late because we don't add value
  late String email;
  late String password;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          //to add space from right and left
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            //لجعل عناصر في الوسط
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset('images/chat_photo.png'),
              ),
              SizedBox(
                height: 30,
              ),
              //we add text field to enter info
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value){
                  email=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10),),
                  ),

                  //ميصير تغيير عندما يضغط المستخدم على الحقل
                  enabledBorder: OutlineInputBorder
                    (borderSide: BorderSide(color: Colors.deepPurple,width: 1,),
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),


                  //يحدث تغيير عندما يضغط المستخدم على الحقل
                  focusedBorder: OutlineInputBorder
                    (borderSide: BorderSide(color: Colors.blue,width: 2,),
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              TextField(
                obscureText: true,
                onChanged: (value){
                  password=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Password',
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10),),
                  ),

                  //ميصير تغيير عندما يضغط المستخدم على الحقل
                  enabledBorder: OutlineInputBorder
                    (borderSide: BorderSide(color: Colors.deepPurple,width: 1,),
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),


                  //يحدث تغيير عندما يضغط المستخدم على الحقل
                  focusedBorder: OutlineInputBorder
                    (borderSide: BorderSide(color: Colors.blue,width: 2,),
                    borderRadius: BorderRadius.all(Radius.circular(10),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              //we call this method to create button
              MyButton(color: Colors.blueAccent[400]!, title: 'Sign in', onPressed: () async {
                setState(() {
                  showSpinner=true;
                });
                try{
                  final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(user!=null){
                  Navigator.pushNamed(context, 'chat_screen');}
                  setState(() {
                    showSpinner=false;
                  });
                }
                catch(e){
                  print(e);
                }
              },),
            ],
          ),
//to add space between the title and buttons

        ),
      ),
    );
  }
}
