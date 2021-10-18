import 'package:flutter/material.dart';
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
    Usuario(email: 'test1@test.com', nombre: 'Maria', uid: '1', onLine: true),
    Usuario(email: 'test2@test.com', nombre: 'Sergio', uid: '2'),
    Usuario(email: 'test3@test.com', nombre: 'Arturo', uid: '3', onLine: true),
    Usuario(email: 'test4@test.com', nombre: 'Freddy', uid: '4', onLine: true),
    Usuario(email: 'test5@test.com', nombre: 'Claudia', uid: '5'),
    Usuario(email: 'test6@test.com', nombre: 'Julieta', uid: '6'),
    Usuario(email: 'test7@test.com', nombre: 'Natali', uid: '7', onLine: true),
    Usuario(email: 'test8@test.com', nombre: 'Nasly', uid: '8', onLine: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text( 'Mi nombre', style: TextStyle(color: Colors.black54)),
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54), 
          onPressed: () {  },
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
          color: usuario.onLine ? Colors.greenAccent : Colors.redAccent,
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