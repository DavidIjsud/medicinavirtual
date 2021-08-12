// To parse this JSON data, do
//
//     final responseMisReservas = responseMisReservasFromJson(jsonString);

import 'dart:convert';

ResponseMisReservas responseMisReservasFromJson(String str) => ResponseMisReservas.fromJson(json.decode(str));

String responseMisReservasToJson(ResponseMisReservas data) => json.encode(data.toJson());

class ResponseMisReservas {
    ResponseMisReservas({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory ResponseMisReservas.fromJson(Map<String, dynamic> json) => ResponseMisReservas(
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

class Medico {
    Medico({
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
        this.reservas,
        this.especialidad,
        this.dias,
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
    List<Datum> reservas;
    Especialidad especialidad;
    List<DiaElement> dias;

    factory Medico.fromJson(Map<String, dynamic> json) => Medico(
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
        reservas: List<Datum>.from(json["reservas"].map((x) => Datum.fromJson(x))),
        especialidad: Especialidad.fromJson(json["especialidad"]),
        dias: List<DiaElement>.from(json["dias"].map((x) => DiaElement.fromJson(x))),
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
        "reservas": List<dynamic>.from(reservas.map((x) => x.toJson())),
        "especialidad": especialidad.toJson(),
        "dias": List<dynamic>.from(dias.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.fecha,
        this.hora,
        this.enlace,
        this.medico,
    });

    int id;
    String fecha;
    String hora;
    String enlace;
    Medico medico;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fecha: json["fecha"],
        hora: json["hora"],
        enlace: json["enlace"] == null ? null : json["enlace"],
        medico: json["medico"] == null ? null : Medico.fromJson(json["medico"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "hora": hora,
        "enlace": enlace == null ? null : enlace,
        "medico": medico == null ? null : medico.toJson(),
    };
}

class DiaElement {
    DiaElement({
        this.id,
        this.activo,
        this.dia,
    });

    int id;
    bool activo;
    DiaDia dia;

    factory DiaElement.fromJson(Map<String, dynamic> json) => DiaElement(
        id: json["id"],
        activo: json["activo"],
        dia: DiaDia.fromJson(json["dia"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "dia": dia.toJson(),
    };
}

class DiaDia {
    DiaDia({
        this.id,
        this.nombre,
        this.horarios,
    });

    int id;
    String nombre;
    List<HorarioElement> horarios;

    factory DiaDia.fromJson(Map<String, dynamic> json) => DiaDia(
        id: json["id"],
        nombre: json["nombre"],
        horarios: List<HorarioElement>.from(json["horarios"].map((x) => HorarioElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "horarios": List<dynamic>.from(horarios.map((x) => x.toJson())),
    };
}

class HorarioElement {
    HorarioElement({
        this.id,
        this.activo,
        this.ciMedico,
        this.horario,
    });

    int id;
    bool activo;
    int ciMedico;
    HorarioHorario horario;

    factory HorarioElement.fromJson(Map<String, dynamic> json) => HorarioElement(
        id: json["id"],
        activo: json["activo"],
        ciMedico: json["ciMedico"],
        horario: HorarioHorario.fromJson(json["horario"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "ciMedico": ciMedico,
        "horario": horario.toJson(),
    };
}

class HorarioHorario {
    HorarioHorario({
        this.id,
        this.horaFijada,
    });

    int id;
    String horaFijada;

    factory HorarioHorario.fromJson(Map<String, dynamic> json) => HorarioHorario(
        id: json["id"],
        horaFijada: json["horaFijada"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "horaFijada": horaFijada,
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
