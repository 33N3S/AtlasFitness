import 'package:atlas_fitness/components/my_button.dart';
import 'package:atlas_fitness/components/my_footer_illustrated.dart';
import 'package:atlas_fitness/components/my_text_field.dart';
import 'package:atlas_fitness/helpers/displayDialogMessage.dart';
import 'package:atlas_fitness/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


Future<void> _signIn() async {

  showDialog(context: context, builder: (context)=>
  const Center(child: CircularProgressIndicator())
  );

  try{
    UserCredential? userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

  } on FirebaseAuthException catch(e){

    Navigator.pop(context);
    displayDialogMessage(e.code, context);
  }
}


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight, // Set height to the available screen height
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),
                  Center(
                    child: Text(
                      "Welcome Back !",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: passwordController,
                    hintText: "password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    text: "Log In",
                    onTap: () => _signIn(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot password?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Spacer(), // This will push the footer to the bottom
                  const MyFooterIllustrated(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
