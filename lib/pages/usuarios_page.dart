import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chatapp/models/usuario.dart';

class UsuariosPage extends StatefulWidget {

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(email: 'test1@test.com', nombre: 'Maria', uId: '1', online: true),
    Usuario(email: 'test2@test.com', nombre: 'Sergio', uId: '2'),
    Usuario(email: 'test3@test.com', nombre: 'Arturo', uId: '3', online: true),
    Usuario(email: 'test4@test.com', nombre: 'Freddy', uId: '4', online: true),
    Usuario(email: 'test5@test.com', nombre: 'Claudia', uId: '5'),
    Usuario(email: 'test6@test.com', nombre: 'Julieta', uId: '6'),
    Usuario(email: 'test7@test.com', nombre: 'Natali', uId: '7', online: true),
    Usuario(email: 'test8@test.com', nombre: 'Nasly', uId: '8', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text( usuario.nombre, style: TextStyle(color: Colors.black54)),
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54), 
          onPressed: () {
            // TODO: desconectar del socketserver
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(Icons.check_circle, color: Colors.blueAccent[400],),
            // child: Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blueAccent[400]!,
        ),onRefresh: _cargarUsuarios,
        child: _listviewUsuarios(),
      ),
   );
  }

  ListView _listviewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder: (_, i) => Divider(), 
      itemCount: this.usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2), style: TextStyle(color: Colors.blue[900]),),
        backgroundColor: Colors.blue[300],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.greenAccent : Colors.redAccent,
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }

  void _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}