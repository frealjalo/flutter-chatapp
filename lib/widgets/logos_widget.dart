import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String mensaje;

  const Logo({
    Key? key, 
    required this.mensaje
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 180,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/tag-logo.png'),
            ),
            SizedBox(height: 20),
            Text(this.mensaje, style: TextStyle(fontSize: 25),)
          ],
        ),
      ),
    );
  }
}