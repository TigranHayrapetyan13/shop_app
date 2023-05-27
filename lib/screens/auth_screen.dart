import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop/main.dart';
import 'package:shop/providers/auths.dart';
import 'package:shop/screens/first_screen.dart';
import 'package:shop/screens/sign_up_Screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authServices = FirebaseAuth.instance;
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    final authProvider = Provider.of<AuthProvider>(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: StreamBuilder(
          stream: authServices.authStateChanges(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'ShopApp',
                            style: GoogleFonts.lobster(
                                fontSize: 90, color: Colors.blue[600]),
                          ),
                          Text(
                            'Welcome back we mised you',
                            style: GoogleFonts.lobster(
                                fontSize: 20,
                                color: Color.fromARGB(255, 69, 129, 182)),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (!EmailValidator.validate(value!)) {
                                return 'EMail not correct';
                              }
                            },
                            controller: mailController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Colors.blue[300],
                                hintText: 'Enter @gmail',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 8) {
                                return 'PAssw not correct';
                              }
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue[300],
                                hintText: 'Enter Password',
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          InkWell(
                            onTap: () {
                              if (!formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: ((context) => const Center(
                                          child: CircularProgressIndicator(),
                                        )));

                                authProvider.logIn(
                                    mailController, passwordController);
                                navigatorKey.currentState!
                                    .popUntil((route) => route.isFirst);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 20),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.blue[500],
                                    borderRadius: BorderRadius.circular(20)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                child: const Center(
                                    child: Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) => const SignUpScreen()),
                                ),
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don\'t have an acount?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '  Sign Up',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const FirstScreen();
          }),
    );
  }
}
