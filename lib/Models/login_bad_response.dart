import 'dart:convert';

LoginBadResponse loginBadResponseFromJson(String str) =>
    LoginBadResponse.fromJson(json.decode(str));

String loginBadResponseToJson(LoginBadResponse data) =>
    json.encode(data.toJson());

class LoginBadResponse {
  LoginBadResponse({
    required this.ok,
    required this.errores,
  });

  bool ok;
  Errores errores;

  factory LoginBadResponse.fromJson(Map<String, dynamic> json) =>
      LoginBadResponse(
        ok: json["ok"],
        errores: Errores.fromJson(json["errores"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "errores": errores.toJson(),
      };
}

class Errores {
  Errores(this.email, this.nombre, this.password);

  Param email;
  Param nombre;
  Param password;

  factory Errores.fromJson(Map<String, dynamic> json) => Errores(
        Param.fromJson( json.containsKey("email") ? json["email"] : Map<String, dynamic>()),
        Param.fromJson(json.containsKey("nombre") ? json["nombre"] : null),
        Param.fromJson(json.containsKey("password") ? json["password"] : null),
      );

  Map<String, dynamic> toJson() => {
        "email": email.toJson(),
        "nombre": nombre.toJson(),
        "password": password.toJson(),
      };

  Future<String> MessageToString() async {
    if (nombre.msg != "") {
      return nombre.msg;
    }
    if (email.msg != "") {
      return email.msg;
    }
    if (password.msg != "") {
      return password.msg;
    }
    return "";
  }
}

class Param {
  Param({
    required this.value,
    required this.msg,
    required this.param,
    required this.location,
  });

  String value;
  String msg;
  String param;
  String location;

  factory Param.fromJson(Map<String, dynamic> json) => Param(
        value: json.containsKey(json["value"]) ? json["value"] : '',
        msg: json.containsKey(json["msg"]) ? json["msg"] : '',
        param: json.containsKey(json["param"]) ? json["param"] : '',
        location: json.containsKey(json["location"]) ? json["location"] : '',
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "msg": msg,
        "param": param,
        "location": location,
      };
}
