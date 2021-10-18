import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextInputType tipo;
  final bool obscureText;
  final IconData icon;
  final String hintText;
  final TextEditingController controller;

  const CustomInput({
    this.tipo = TextInputType.text, 
    this.obscureText = false, 
    required this.icon, 
    required this.hintText,
    required this.controller
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(5, 5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: this.tipo,
        obscureText: this.obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.hintText
        ),
        controller: this.controller,
      )
    );
  }
}