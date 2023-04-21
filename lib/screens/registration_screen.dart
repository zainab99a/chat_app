import 'package:flutter/material.dart';
import '../widget/my_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//كي نستطيع اضافه مستخدم جديد
import 'package:firebase_auth/firebase_auth.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //لتسجيل مستخدم جديد
  final _auth=FirebaseAuth.instance;
  //we create variable  to save data
  //we add late because we don't add value
  late String email;
  late String password;
  //عرض ايقونة التحميل
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
            //لتخصيص الحقل لادخال ايميل فقط
            keyboardType: TextInputType.emailAddress,
            onChanged: (value){
              //يحفظ المدخل الي جاي من فاليو بداخل لمتغير ايميل
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
                //لاخفاء الباسورد
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
              MyButton(color: Colors.blueAccent[400]!, title: 'Register', onPressed:() async
              {
                setState(() {
                  showSpinner=true;
                });

                try{
               final newUser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
                Navigator.pushNamed(context, 'chat_screen');
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
