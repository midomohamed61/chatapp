import 'package:chat_app/constant/const.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
String? email;
String? password;
GlobalKey<FormState> formKey = GlobalKey();
bool isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: false,
        child: Scaffold(
          backgroundColor: KPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/images/scholar.png'),
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'pacifico'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      onChanged: (data) {
                      email = data;
                    },
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      obscureText: true,
                      onChanged: (data) {
                      password = data;
                    },
                      hintText: 'password',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {

                          });
                          try {
                            await loginUser();
                            showSnackBar(context, 'Success');
                            Navigator.pushNamed(context, 'ChatPage',arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(context, 'No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context,'Wrong password provided for that user.');
                            }
                          } catch (e) {
                            showSnackBar(context, e.toString());
                          }
                          isLoading = false;
                          setState(() {

                          });
                        }
                      },
                      text: 'Login',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont\'t have an account ?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "RegisterPage");
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Future<void> loginUser() async {
  UserCredential userCredential =
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email!,
    password: password!,
  );
}

