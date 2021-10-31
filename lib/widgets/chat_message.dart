import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  late final String texto;
  late final String uId;
  late final AnimationController animationCtrl;

  ChatMessage({
    Key? key, 
    required this.texto, 
    required this.uId,
    required this.animationCtrl
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationCtrl,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationCtrl, curve: Curves.easeOutBack),
        child: Container(
          child: (this.uId == '12345') ?  _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        margin: EdgeInsets.only(bottom: 10, left: 50, right: 7),
        decoration: BoxDecoration(
          color: Color(0xff4D9Ef6),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(this.texto, style: TextStyle(color: Colors.white),),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        margin: EdgeInsets.only(bottom: 10, left: 7, right: 50),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(this.texto, style: TextStyle(color: Colors.black87),),
      ),
    );
  }
}