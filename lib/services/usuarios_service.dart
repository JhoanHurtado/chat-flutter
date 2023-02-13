import 'package:chat/Models/usuarios_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat/Models/usuario.dart';

import '../global/environment.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      var url = Uri.parse('${Environment.apiUrl}/usuarios');
      var token = await AuthService.getToken();
      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.toString(),
        },
      );

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
