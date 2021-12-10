import 'package:chatapp/helpers/mostrar_alerta.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/widgets/boton_azul_widget.dart';
import 'package:chatapp/widgets/custom_input_widget.dart';
import 'package:chatapp/widgets/labels_widget.dart';
import 'package:chatapp/widgets/logos_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            //height: MediaQuery.of(context).size.height *90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Logo(mensaje: 'Family Chat',),
                _Form(),
                Labels(ruta: 'register', labPregunta: '¿No tienes cuenta?', labresp: 'Crea una ahora'),
                SizedBox(height: 20),
                Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w300,))
              ],
            ),
          ),
        ),
      ),
   );
  }
}

class _Form extends StatefulWidget {
  
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    final authService = Provider.of<AuthService>(context, listen: false);
    final provider = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(tipo: TextInputType.emailAddress, icon: Icons.email_outlined, hintText: 'Email', controller: emailCtrl),
          CustomInput(obscureText: true, icon: Icons.lock, hintText: 'Password', controller: passCtrl),

          BotonAzul(
            texto: 'Ingresar', 
            onPressed: (!provider.autenticando) ? () async {
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
              if(loginOk){
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Credenciales incorrectas', 'Usuario y contraseña incorrectos');
              }
            } : () => Null
          ),
        ],
      ),
    );
  }
}
