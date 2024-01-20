import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

String? email;
String? password;
GlobalKey<FormState> formKey = GlobalKey();
bool isLoading = false;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,

        child: Scaffold(
          backgroundColor: Color(0xff2B475E),
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
                              await registerUser();
                              showSnackBar(context, 'Success');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showSnackBar(context, 'weak-password');
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBar(context,
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              showSnackBar(context, e.toString());
                            }
                            isLoading = false;
                            setState(() {

                            });
                          }
                        },
                        text: 'Register'),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Do you have an account ?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
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

Future<void> registerUser() async {
  UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email!,
    password: password!,
  );
}


