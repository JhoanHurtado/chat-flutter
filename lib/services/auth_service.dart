import 'dart:convert';

import 'package:chat/Models/login_respnse.dart';
import 'package:chat/Models/usuario.dart';
import 'package:chat/global/environment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _authenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _authenticando;
  set autenticando(bool valor) {
    _authenticando = valor;
    notifyListeners();
  }

  //Get and Set statics
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {'email': email, 'password': password};

    var url = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;
    final data = {
      'email': email,
      'nombre': nombre,
      'password': password,
    };

    var url = Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      // final LoginBadResponse = loginBadResponseFromJson(resp.body);

      // final v = respBody['msg'];
      print(respBody['errores']);
      return "Error check yours dates";
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    var url = Uri.parse('${Environment.apiUrl}/login/renew');

    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      _logOutToken();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logOutToken() async {
    return await _storage.delete(key: 'token');
  }
}
