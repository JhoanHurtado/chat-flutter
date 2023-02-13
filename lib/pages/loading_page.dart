import 'package:chat/pages/usuarios_pages.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CheckLoginState(context),
      builder: (context, snapshot) {
        return const Scaffold(
          body: Center(
            child: Text('Loading....'),
          ),
        );
      },
    );
  }

  Future CheckLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      //TODO> Conectar al socket server
      socketService.connect();
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (
                _,
                __,
                ___,
              ) =>
                  const UsuariosPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
