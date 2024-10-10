import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
   const RegisterScreen({super.key});
 static String idRegister='RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 String? email;

 String? password;

 GlobalKey<FormState> formKey=GlobalKey();

 bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:kPrimaryColor ,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Spacer(flex: 1,),
                Image.asset(kLogo),
                const Text('Scholar Chat',
                  style:TextStyle(
                      fontSize: 32.0,
                      color: Colors.white,
                      fontFamily: 'pacifico'
                  ) ,),
                const Spacer(flex: 2,),
                const Row(
                  children: [
                    Text('REGISTER',
                      style:TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ) ,),
                  ],
                ),
                const SizedBox(height: 20.0,),
                CustomTextField(
                  onChanged: (data){
                    email=data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(height: 10.0,),
                CustomTextField(
                  onChanged: (data){
                    password=data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(height: 20.0,),
                CustomButton(
                  onTap: ()async{
                   if (formKey.currentState!.validate()) {
                     isLoading = true;
                     setState(() {});
                     try {
                       await registerUser();
                       Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                     } on FirebaseAuthException catch (e) {
                       if (e.code == 'weak-password') {
                         showSnackBar(context, 'weak password');
                       } else if (e.code == 'email-already-in-use') {
                         showSnackBar(context, 'email already exists');
                       }
                     } catch (error) {
                       showSnackBar(context, 'there was an error');
                     }
                     isLoading = false;
                     setState(() {});
                   }
                  },
                    text: 'REGISTER'),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                      style: TextStyle(
                          color: Colors.white
                      ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Text('Login',
                        style: TextStyle(
                            color: Color(0xffC7EDE6)
                        ),),
                    ),
                  ],
                ),
                const Spacer(flex: 3,)
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<void> registerUser() async {
    UserCredential credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!);
  }
}
