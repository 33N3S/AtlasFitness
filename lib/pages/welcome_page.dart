import 'package:atlas_fitness/pages/login_page.dart';
import 'package:atlas_fitness/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class WelcomePage extends StatelessWidget {
const WelcomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
  
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
              'lib/images/logos/atlas_logo.svg',
              height: 100,
                color: Theme.of(context).colorScheme.surface,
            ),
            Center(
              child: Text("Atlas Fit",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.surface,
                ),
                ),
            ),
            Center(
              child:Text(
                "Consistently Break Through",
                style:TextStyle(color:Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold)
              ),
            ), 
          ],),

        Column(
          children: [
            GestureDetector(
              onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>const RegisterPage())),
              child: Container(
                decoration: BoxDecoration(
                  color:Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8)
                ),
                margin:const EdgeInsets.only(left: 80,right: 80),
                padding:const EdgeInsets.all(8),
                child:const Center(child:Text("Start Your Journey",
                style:TextStyle(fontWeight: FontWeight.bold)
                ), 
          
                )
              ),
            ),
             GestureDetector(
              onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoginPage())),
              child: Container(
                decoration: BoxDecoration(
                  color:Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8)
                ),
                margin:const EdgeInsets.only(left: 80,bottom: 50,right:80,top:20),
                padding:const EdgeInsets.all(8),
                child:const Center(child: Text("Log in",
                style:TextStyle(fontWeight: FontWeight.bold)
                ), 
                )
              ),
            )
          ],
        )
        ],
      ),

    );
  }
}