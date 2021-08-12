// To parse this JSON data, do
//
//     final responseHorasMedicos = responseHorasMedicosFromJson(jsonString);

import 'dart:convert';

ResponseHorasMedicos responseHorasMedicosFromJson(String str) => ResponseHorasMedicos.fromJson(json.decode(str));

String responseHorasMedicosToJson(ResponseHorasMedicos data) => json.encode(data.toJson());

class ResponseHorasMedicos {
    ResponseHorasMedicos({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory ResponseHorasMedicos.fromJson(Map<String, dynamic> json) => ResponseHorasMedicos(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.activo,
        this.ciMedico,
        this.horario,
    });

    int id;
    bool activo;
    int ciMedico;
    Horario horario;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        activo: json["activo"],
        ciMedico: json["ciMedico"],
        horario: Horario.fromJson(json["horario"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "ciMedico": ciMedico,
        "horario": horario.toJson(),
    };
}

class Horario {
    Horario({
        this.id,
        this.horaFijada,
    });

    int id;
    String horaFijada;

    factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json["id"],
        horaFijada: json["horaFijada"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "horaFijada": horaFijada,
    };
}
