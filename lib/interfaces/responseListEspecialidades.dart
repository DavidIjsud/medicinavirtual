// To parse this JSON data, do
//
//     final responseListEspecialidades = responseListEspecialidadesFromJson(jsonString);

import 'dart:convert';

ResponseListEspecialidades responseListEspecialidadesFromJson(String str) => ResponseListEspecialidades.fromJson(json.decode(str));

String responseListEspecialidadesToJson(ResponseListEspecialidades data) => json.encode(data.toJson());

class ResponseListEspecialidades {
    ResponseListEspecialidades({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory ResponseListEspecialidades.fromJson(Map<String, dynamic> json) => ResponseListEspecialidades(
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
        this.nombre,
    });

    int id;
    String nombre;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
