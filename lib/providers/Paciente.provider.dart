import 'dart:io';
import 'package:flutterwebtopico/interfaces/response.dart';
import 'package:flutterwebtopico/interfaces/response.validatepin.dart';
import 'package:flutterwebtopico/interfaces/responseCuenta.dart';
import 'package:flutterwebtopico/interfaces/responseDiasMedico.dart';
import 'package:flutterwebtopico/interfaces/responseHorasMedico.dart';
import 'package:flutterwebtopico/interfaces/responseListEspecialidadAndMedico.dart';
import 'package:flutterwebtopico/interfaces/responseListEspecialidades.dart';
import 'package:flutterwebtopico/interfaces/responseReservas.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/src/platform_file.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class PacienteProvider{
    
      PacienteProvider(){}

      static Future<Map<String, String>> login( String password , String email  ) async {

          http.Response response ;
           try {
              response = await  http.post( Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/paciente/login") ,  headers: {
                'Content-Type': 'application/json'
            }, body: jsonEncode({
                "password" : password.trim(),
                "email" : email.trim().toLowerCase()
            }) );  
           }catch( e ){
                return {
                   "status" : "false",
                   "message" : e.message,
                   "data" : null
                };
           }

           if( response.statusCode == 200 ){
                var data = jsonDecode(response.body);
                if( data['status'] == true ){
                    return {
                      "status" : "true",
                      "message" : data['message'],
                      "data" : null  
                    };
                }else{
                    return {
                        "status" : "false",
                        "message" : data['message'],
                        "data" : null
                    };
                }
           } else {
               return {
                     "status" : "false",
                     "message" : response.reasonPhrase,
                     "data" : null
                 }; 
           }

      }

      static  Future<Map<String,String>> validatePin( int pin , int ci , String email ) async {

            try {
             var response = await  http.post( Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/cuenta/verificarpin") ,  headers: {
                'Content-Type': 'application/json'
            }, body: jsonEncode({
                "pin" : int.parse(pin.toString().trim()),
                "ci" : int.parse(ci.toString().trim()),
                "email" : email.trim().toLowerCase()
            }) );  

            if( response.statusCode == 200 ){
                  
                    ResponseValidatePin responseValidatePin =  responseValidatePinFromJson( response.body );
                    if( responseValidatePin.status ){
                       return {
                            "status" : "true",
                            "message" : responseValidatePin.message,
                            "data" : null
                        }; 
                    }else{
                          return {
                            "status" : "false",
                            "message" : responseValidatePin.message,
                            "data" : null
                        };    
                    }

            }else{
                 return {
                     "status" : "false",
                     "message" : response.reasonPhrase,
                     "data" : null
                 }; 
            }

            } catch (e) {
                 return {
                     "status" : "false",
                     "message" : e.message,
                     "data" : null
                 };
            }
                

      }

      static Future<ResponseListEspecialidades> especialidades() async {

          var uri = Uri.parse("https://nestjswebservicesapp.herokuapp.com/especialidad/getall");
          var response;

          try {
              response = await http.get( uri );
          } catch (e) {
              return null;
          }

          if( response.statusCode == 200 ){
               var data = jsonDecode(response.body);
               if( data['status'] == true ){
                  return responseListEspecialidadesFromJson(response.body);
               }else{
                  return null;
               }
          }

          return null;  

      }

      static Future<ResponseMisReservas> obtainReservas( int ciPaciente ) async {

          var uri = Uri.parse("https://nestjswebservicesapp.herokuapp.com/reserva/obtenerReservas/"+ciPaciente.toString());
          var response;
          try {
              response = await http.get( uri );
          } catch (e) {
              return null;
          }
          if( response.statusCode == 200 ){
               var data = jsonDecode(response.body);
               if( data['status'] == true ){
                  return responseMisReservasFromJson(response.body);
               }else{
                  return null;
               }
          }
          return null;
      

      }

      static Future<bool> saveNewReserva( int ciMedico , int ciPaciente , String hora , String fecha ) async {

          var uri = Uri.parse("https://nestjswebservicesapp.herokuapp.com/reserva/add");
          var response;
          try {
              response = await http.post( uri ,  headers: {
                'Content-Type': 'application/json'
              }
              , body: jsonEncode({
                  "medico" : ciMedico,
                  "paciente" : ciPaciente,
                  "hora" : hora,
                  "fecha" : fecha
              }) );
          } catch (e) {
              return false;
          }
          if( response.statusCode == 200 ){
               var data = jsonDecode(response.body);
               if( data['status'] == true ){
                  return true;
               }else{
                  return false;
               }
          }
          return false; 
          
      }


      static Future<ResponseHorasMedicos> receiveHorasOfMedico( int medico ) async {

          var uri = Uri.parse("https://nestjswebservicesapp.herokuapp.com/horario/horariomedico/"+medico.toString());
          var response;
          try {
              response = await http.get( uri );
          } catch (e) {
              return null;
          }
          if( response.statusCode == 200 ){
               var data = jsonDecode(response.body);
               if( data['status'] == true ){
                  return responseHorasMedicosFromJson(response.body);
               }else{
                  return null;
               }
          }
          return null;


      }

      static Future<ResponseDiasMedicos> receiveDiasOfMedico( int medico ) async {

          var uri = Uri.parse("https://nestjswebservicesapp.herokuapp.com/horario/diamedico/"+medico.toString());
          var response;
          try {
              response = await http.get( uri );
          } catch (e) {
              return null;
          }
          if( response.statusCode == 200 ){
               var data = jsonDecode(response.body);
               if( data['status'] == true ){
                  return responseDiasMedicosFromJson(response.body);
               }else{
                  return null;
               }
          }
          return null;


      }

      static Future<ResponseEspecialidadesAndMedico> receiveMedicos( int especialidad ) async {
          
           var uri = Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/medico/getall/"+especialidad.toString());
           var response;
           try {
              response = await http.get( uri );
           } catch (e) {
              return null;
           }
           if( response.statusCode == 200 ){
               var data = jsonDecode(response.body);
               if( data['status'] == true ){
                  return responseEspecialidadesAndMedicoFromJson(response.body);
               }else{
                  return null;
               }
           }
           return null; 
      }

      static Future<ResponseEspecialidadesAndMedico> receiveEspecialidadesAndMedico(  ) async {
          

          var uri = Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/medico/getall");
          var response ;

          try {
              response = await  http.get( uri );
          } catch (e) {
             return null;
          }

          if( response.statusCode == 200 ){
                var data = jsonDecode(response.body);
                if( data['status'] == true ){
                   return responseEspecialidadesAndMedicoFromJson( response.body );
                }else{
                  return null;
                }
                
        }

        return null;

          

      }

       static Future<Map<String, String>>  sendData( Map<String, String> data , XFile file  ) async {

            var stream = new http.ByteStream( file.openRead()  );
            var length =  await file.length();
            var uri = Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/paciente/add/" + data['email']   );
            var request = new http.MultipartRequest("POST", uri  );
            
            request.fields['fechaNacimiento'] = data[ 'fechaNacimiento' ].trim();
            request.fields['ci'] = data[ 'ci' ].trim();
            request.fields['nombres'] = data[ 'nombres' ].trim();
            request.fields['apellidos'] = data[ 'apellidos' ].trim();
            request.fields['telefono'] = data[ 'telefono' ].trim();
            request.fields['seguro'] = data[ 'seguro' ].trim();
            request.fields['gruposanguieo'] = data[ 'gruposanguieo' ].trim();
            
            var multiPartFile = new http.MultipartFile('image', stream, length, filename: file.path );
            request.files.add(multiPartFile);

            
            
           http.Response response = await http.Response.fromStream(await request.send());
           // http.StreamedResponse response = await request.send();
            if( response.statusCode == 200 ){
                   ResponseHttp respuesta = responseFromJson( response.body );
                   if( respuesta.status ){
                        
                        var uri_paciente = Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/cuenta/add");
                        var response_paciente  = await http.post(uri_paciente,  headers: { "Content-Type" : "application/json" } , body: json.encode({
                              "email" : data['email'].trim().toLowerCase(),
                              "contrasena" : data['contrasena'].trim(),
                              "persona" :  int.parse(data['ci'].trim()),
                              "tipoCuenta" : "PACIENTE" 
                        } ) );

                        if( response_paciente.statusCode == 200 ){
                              ResponseCuenta respuesta_cuenta = responseCuentaFromJson(response_paciente.body);
                              
                                if( respuesta_cuenta.status ){
                                      return {
                                         "status" : "true",
                                         "message" : "El paciente se ha registrado correctamente",
                                         "data" : respuesta.data.toString()
                                      };
                                }else{
                                      return {
                                         "status" : "false",
                                         "message" : respuesta_cuenta.message,
                                         "data" : null
                                      };
                                }
                        }else{
                            return {
                              "status" : "false",
                              "message" : "Error interno",
                              "data" : null
                          };
                         } 
                   }else{
                       return {
                          "status" : "false",
                          "message" : respuesta.message,
                          "data" : respuesta.data.toString()
                       };
                   }
            }else{
              return {
                  "status" : "false",
                  "message" : "Error interno",
                  "data" : null
              };
            }
            

       }

}