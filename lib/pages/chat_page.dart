import 'dart:io';

import 'package:chatapp/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final TextEditingController _chatTextCtrl = new TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, i) {
                    return _messages[i];
                  },
                ),
              ),
              Divider(height: 2,),
              Container(
                child: _inputChat(),
                color: Colors.white,
              )
            ],
          ),
        ),
     ),
   );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 2,
      title: Column(
        children: [
          CircleAvatar(
            maxRadius: 14,
            child: Text('Te', style: TextStyle(fontSize: 12, color: Colors.blue[900], fontWeight: FontWeight.bold)),
            backgroundColor: Colors.blue[200],
          ),
          SizedBox(height: 3,),
          Text('Freddy Jaramillo', style: TextStyle(fontSize: 12, color: Colors.blue[900]))
        ],
      ),
    );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _chatTextCtrl,
                onSubmitted: _handleSubmit,
                onChanged: (texto){
                  setState(() {
                    if(texto.trim().length > 0) this._estaEscribiendo = true;
                    else this._estaEscribiendo = false;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Escribe acá tu mensaje'
                ),
                focusNode: _focusNode,
              )
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS ? CupertinoButton(
                child: Text('Enviar'), 
                onPressed: (){

                }
              ) : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.blue[400],
                  ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: (_estaEscribiendo) 
                    ? () => _handleSubmit(_chatTextCtrl.text.trim()) 
                    : null, 
                    icon: Icon(Icons.send_outlined)
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  _handleSubmit(String texto){
    if(texto.length == 0) return;

    
    print(texto);
    _chatTextCtrl.clear();
    _focusNode.requestFocus();

    final ChatMessage message = ChatMessage(texto: texto, uId: '12345', animationCtrl: AnimationController(vsync: this, duration: Duration(milliseconds: 400)),);

    _messages.insert(0, message);

    message.animationCtrl.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }
}