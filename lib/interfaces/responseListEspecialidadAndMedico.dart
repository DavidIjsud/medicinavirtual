// To parse this JSON data, do
//
//     final responseEspecialidadesAndMedico = responseEspecialidadesAndMedicoFromJson(jsonString);

import 'dart:convert';

ResponseEspecialidadesAndMedico responseEspecialidadesAndMedicoFromJson(String str) => ResponseEspecialidadesAndMedico.fromJson(json.decode(str));

String responseEspecialidadesAndMedicoToJson(ResponseEspecialidadesAndMedico data) => json.encode(data.toJson());

class ResponseEspecialidadesAndMedico {
    ResponseEspecialidadesAndMedico({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory ResponseEspecialidadesAndMedico.fromJson(Map<String, dynamic> json) => ResponseEspecialidadesAndMedico(
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
        this.ci,
        this.apellidos,
        this.foto,
        this.nombres,
        this.telefono,
        this.contrato,
        this.cv,
        this.fotoTituloProfesional,
        this.numeroMatricula,
        this.estado,
        this.rol,
        this.especialidad,
    });

    int ci;
    String apellidos;
    String foto;
    String nombres;
    int telefono;
    String contrato;
    String cv;
    String fotoTituloProfesional;
    int numeroMatricula;
    String estado;
    String rol;
    Especialidad especialidad;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        ci: json["ci"],
        apellidos: json["apellidos"],
        foto: json["foto"],
        nombres: json["nombres"],
        telefono: json["telefono"],
        contrato: json["contrato"],
        cv: json["cv"],
        fotoTituloProfesional: json["fotoTituloProfesional"],
        numeroMatricula: json["numeroMatricula"],
        estado: json["estado"],
        rol: json["rol"],
        especialidad: Especialidad.fromJson(json["especialidad"]),
    );

    Map<String, dynamic> toJson() => {
        "ci": ci,
        "apellidos": apellidos,
        "foto": foto,
        "nombres": nombres,
        "telefono": telefono,
        "contrato": contrato,
        "cv": cv,
        "fotoTituloProfesional": fotoTituloProfesional,
        "numeroMatricula": numeroMatricula,
        "estado": estado,
        "rol": rol,
        "especialidad": especialidad.toJson(),
    };
}

class Especialidad {
    Especialidad({
        this.id,
        this.nombre,
    });

    int id;
    String nombre;

    factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
