import 'package:atlas_fitness/pages/home_page.dart';
import 'package:atlas_fitness/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
const Auth({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context,snapshot){
        if(snapshot.hasData){
          return const HomePage();
        }else{
          return const WelcomePage();
        }
      });
  }
}