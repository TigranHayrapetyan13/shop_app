import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/user_class.dart';
import 'package:shop/screens/auth_screen.dart';
import 'package:shop/screens/first_screen.dart';

import '../providers/auths.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final mailController = TextEditingController();
    final passwordController = TextEditingController();
    final password2Controller = TextEditingController();
    final authServices = FirebaseAuth.instance;
    final authProvider = Provider.of<AuthProvider>(context);
    final String name = 'gorcd chi';
    final int age = 4;
    final String secondNAme = 'pah';

    UserName user = UserName(
        email: mailController.text.trim(),
        name: name,
        age: age,
        gender: Gender.female,
        secondName: secondNAme);

    return Scaffold(
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
                          CircleAvatar(
                            radius: 50,
                            child: Center(
                              child: image == null
                                  ? IconButton(
                                      iconSize: 50,
                                      onPressed: pickImage,
                                      icon: const Icon(Icons.camera_alt))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(360),
                                      child: Image.file(
                                        image!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (!EmailValidator.validate(value!)) {
                                return 'EMail not correct';
                              }
                            },
                            controller: mailController,
                            decoration: InputDecoration(
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
                                hintText: 'Enter Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          ElevatedButton(
                            onPressed: (() async {
                              if (!formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Somthing wnet wrong')),
                                );
                              } else {
                                final userCredential = await authServices
                                    .createUserWithEmailAndPassword(
                                        email: mailController.text.trim(),
                                        password:
                                            passwordController.text.trim());
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCredential.user!.uid)
                                    .set(user.toJson());
                                authProvider.logIn(
                                    mailController, passwordController);
                              }
                            }),
                            child: const Text('Sighn up'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) => const AuthScreen()),
                                ),
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: ' have acount',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                  TextSpan(
                                    text: '  Sighn in',
                                    style: TextStyle(
                                        color: Colors.black,
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
                : FirstScreen();
          }),
    );
  }
}
