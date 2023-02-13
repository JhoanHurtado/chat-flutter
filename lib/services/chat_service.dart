import 'package:chat/Models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/mensajes_response.dart';
import '../global/environment.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String userId) async {
    final token = await AuthService.getToken();

    var url = Uri.parse('${Environment.apiUrl}/mensajes/${userId}');

    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString(),
      },
    );

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }
}
