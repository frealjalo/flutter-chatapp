import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _chatTextCtrl = new TextEditingController();
  final _focusNode = new FocusNode();

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
                  // itemCount: 1,
                  itemBuilder: (context, i) {
                    return Text('$i');
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
                child: IconButton(
                  onPressed: (){

                  }, 
                  icon: Icon(Icons.send_outlined, color: Colors.blue[400],)
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  _handleSubmit(String texto){
    print(texto);
    _chatTextCtrl.clear();
    _focusNode.requestFocus();
  }
}