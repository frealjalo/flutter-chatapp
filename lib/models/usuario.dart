
class Usuario {
  bool onLine;
  String email;
  String nombre;
  String uid;

  Usuario({
    this.onLine = false,
    required this.email,
    required this.nombre,
    required this.uid
  });
}