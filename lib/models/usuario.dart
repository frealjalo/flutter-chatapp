// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        required this.nombre, 
        required this.email,
        this.online = false,
        required this.uId,
    });

    String nombre;
    String email;
    bool online;
    String uId;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        email: json["email"],
        online: json["online"],
        uId: json["uId"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "email": email,
        "online": online,
        "uId": uId,
    };
}
