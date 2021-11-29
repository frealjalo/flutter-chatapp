import 'dart:convert';

import 'package:chatapp/global/environments.dart';
import 'package:chatapp/models/login_response.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier{
   late Usuario usuario;

   Future login(String email, String Password) async {
     final data = {
       'email': email, 
       'password': Password
     };
     final apiUrl = Uri.parse('${Environment.apiUrl}/login');

     final resp = await http.post(apiUrl, body: jsonEncode(data), headers: {
       'Content-Type': 'application/json'
     });

     if(resp.statusCode == 200){
       final loginResponse = loginResponseFromJson(resp.body);
       this.usuario = loginResponse.usuario;
     }
     print(resp.body);
   }
}