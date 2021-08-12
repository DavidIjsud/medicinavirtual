// To parse this JSON data, do
//
//     final responseCuenta = responseCuentaFromJson(jsonString);

import 'dart:convert';

ResponseCuenta responseCuentaFromJson(String str) => ResponseCuenta.fromJson(json.decode(str));

String responseCuentaToJson(ResponseCuenta data) => json.encode(data.toJson());

class ResponseCuenta {
    ResponseCuenta({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    Data data;

    factory ResponseCuenta.fromJson(Map<String, dynamic> json) => ResponseCuenta(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.email,
        this.contrasena,
        this.persona,
        this.pin,
        this.fechaCreacion,
        this.estado,
    });

    String email;
    String contrasena;
    int persona;
    int pin;
    DateTime fechaCreacion;
    bool estado;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        contrasena: json["contrasena"],
        persona: json["persona"],
        pin: json["pin"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "contrasena": contrasena,
        "persona": persona,
        "pin": pin,
        "fechaCreacion": "${fechaCreacion.year.toString().padLeft(4, '0')}-${fechaCreacion.month.toString().padLeft(2, '0')}-${fechaCreacion.day.toString().padLeft(2, '0')}",
        "estado": estado,
    };
}
