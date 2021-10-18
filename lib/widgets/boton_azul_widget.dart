import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String texto;
  final Function() onPressed;
  BotonAzul({
    required this.texto, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: this.onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Colors.blueAccent[700],
          shape: StadiumBorder(),
        ),
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(this.texto, style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        )
      ),
    );
  }
}