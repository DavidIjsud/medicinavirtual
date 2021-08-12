// To parse this JSON data, do
//
//     final responseValidatePin = responseValidatePinFromJson(jsonString);

import 'dart:convert';

ResponseValidatePin responseValidatePinFromJson(String str) => ResponseValidatePin.fromJson(json.decode(str));

String responseValidatePinToJson(ResponseValidatePin data) => json.encode(data.toJson());

class ResponseValidatePin {
    ResponseValidatePin({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    dynamic data;

    factory ResponseValidatePin.fromJson(Map<String, dynamic> json) => ResponseValidatePin(
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
    };
}
