import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/constants.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});
static String idLogin='LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
GlobalKey<FormState>formKey=GlobalKey();

bool isLoading=false;
String? email,password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Spacer(flex: 1,),
                Image.asset(kLogo),
                const Text('Scholar Chat',
                  style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white,
                      fontFamily: 'pacifico'
                  ),),
                const Spacer(flex: 2,),
                const Row(
                  children: [
                    Text('LOGIN',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),),
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
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, 'Email Not Found');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context, 'wrong-password');
                          }
                        } catch (error) {
                          showSnackBar(context, 'there was an error');
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    text: 'LOGIN'),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('don\'t have an account? ',
                      style: TextStyle(
                          color: Colors.white
                      ),),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.idRegister);
                      },
                      child: const Text('Register',
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



Future<void> loginUser() async {
  UserCredential credential=await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!);
}

}