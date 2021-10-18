import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String labPregunta;
  final String labresp;
  const Labels({
    Key? key, 
    required this.ruta, 
    required this.labPregunta, 
    required this.labresp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Text(this.labPregunta, style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () => Navigator.popAndPushNamed(context, this.ruta),
            child: Text(this.labresp, style: TextStyle(color: Colors.blue[700], fontSize: 18, fontWeight: FontWeight.bold))
          ),
        ],
      ),
    );
  }
}
