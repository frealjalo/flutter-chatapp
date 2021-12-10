import 'dart:convert';

import 'package:chatapp/global/environments.dart';
import 'package:chatapp/models/login_response.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  

class AuthService with ChangeNotifier{
  late Usuario _usuario;
  bool _autenticando = false;
   
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;

  set autenticando(bool valor){
    this._autenticando = valor;
    notifyListeners();
  }

  Usuario get usuario => this._usuario;

  // Getters del token de forma estática

  static Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    if (token != null){
      return token;
    } else {
      return '';
    }
  }

  static Future<void> deleteToken() async {
    final storage = new FlutterSecureStorage();
    return await storage.delete(key: 'token');
  }

   Future<bool> login(String email, String Password) async {

     this.autenticando = true;
    final data = {
      'email': email, 
      'password': Password
    };
    final apiUrl = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(apiUrl, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json'
    });
    this.autenticando = false;
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      return false;
    }
    
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email, 
      'password': password
    };

    final apiUrl = Uri.parse('${Environment.apiUrl}/login/new');
    final resp = await http.post(apiUrl, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json'
    });

    this.autenticando = false;

    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final tokenResp = await this._storage.read(key: 'token');
    final token = (tokenResp != null) ? tokenResp : '';
    final apiUrl = Uri.parse('${Environment.apiUrl}/login/renew');
    final resp = await http.get(apiUrl, headers: {
      'Content-Type': 'application/json',
      'x-token': token
    });
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      this._logOut();
      return false;
    }
  }

  Future _guardarToken(String token) async{
    return await _storage.write(key: 'token', value: token);
  }

  Future _logOut() async{
    await _storage.delete(key: 'token');
  }
}