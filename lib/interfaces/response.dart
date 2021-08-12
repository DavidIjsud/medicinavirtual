// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

ResponseHttp responseFromJson(String str) => ResponseHttp.fromJson(json.decode(str));

String responseToJson(ResponseHttp data) => json.encode(data.toJson());

class ResponseHttp {
    ResponseHttp({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    Data data;

    factory ResponseHttp.fromJson(Map<String, dynamic> json) => ResponseHttp(
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
        this.pacienteRegistrado,
    });

    PacienteRegistrado pacienteRegistrado;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        pacienteRegistrado: PacienteRegistrado.fromJson(json["paciente_registrado"]),
    );

    Map<String, dynamic> toJson() => {
        "paciente_registrado": pacienteRegistrado.toJson(),
    };
}

class PacienteRegistrado {
    PacienteRegistrado({
        this.fechaNacimiento,
        this.ci,
        this.apellidos,
        this.nombres,
        this.telefono,
        this.foto,
        this.seguro,
        this.gruposanguieo,
    });

    DateTime fechaNacimiento;
    String ci;
    String apellidos;
    String nombres;
    String telefono;
    String foto;
    String seguro;
    String gruposanguieo;

    factory PacienteRegistrado.fromJson(Map<String, dynamic> json) => PacienteRegistrado(
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        ci: json["ci"],
        apellidos: json["apellidos"],
        nombres: json["nombres"],
        telefono: json["telefono"],
        foto: json["foto"],
        seguro: json["seguro"],
        gruposanguieo: json["gruposanguieo"],
    );

    Map<String, dynamic> toJson() => {
        "fechaNacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "ci": ci,
        "apellidos": apellidos,
        "nombres": nombres,
        "telefono": telefono,
        "foto": foto,
        "seguro": seguro,
        "gruposanguieo": gruposanguieo,
    };
}
