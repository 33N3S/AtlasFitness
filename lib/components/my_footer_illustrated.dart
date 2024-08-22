import 'package:flutter/material.dart';

class MyFooterIllustrated extends StatelessWidget {
  const MyFooterIllustrated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          
            child: Container(
              height: 160,
              color: Colors.transparent,
              child: Image.asset(
                'lib/images/illustrations/footer_illustration1.png',
              fit: BoxFit.cover, // Ensures the image covers the entire container
              ),
            ),
          
        ),
      ],
    );
  }
}
