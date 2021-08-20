import 'package:flutter/material.dart';
import 'package:flutterwebtopico/helpers/notifierValueChange.dart';
import 'package:flutterwebtopico/interfaces/responseReservas.dart';
import 'package:flutterwebtopico/providers/Paciente.provider.dart';
import 'package:flutterwebtopico/widgets/meetingJitsin.dart';

class ListOfReservas extends StatefulWidget {
  const ListOfReservas({ Key key }) : super(key: key);

  @override
  _ListOfReservasState createState() => _ListOfReservasState();
}

class _ListOfReservasState extends State<ListOfReservas> {

  Singleton singleton;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      this.singleton = new Singleton();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
               future:   PacienteProvider.obtainReservas(8457691) ,
               builder:  (    _ , AsyncSnapshot<ResponseMisReservas> asyncSnapshot   ) {
                   if( asyncSnapshot.hasData ){
                         if( asyncSnapshot.data.status ){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount:  asyncSnapshot.data.data.length,
                                itemBuilder:  ( _ , i ) {
                                    return GestureDetector(
                                      onTap: asyncSnapshot.data.data[i].enlace.isNotEmpty ?  (){
                                            this.singleton.changeWidget( new Meeting( enlace: asyncSnapshot.data.data[i].enlace, ) );
                                      } : null,
                                      child: Card(
                                          elevation: 20,
                                          child: Column(
                                              children: [
                                                  Text("Fecha de consulta "+ asyncSnapshot.data.data[i].fecha ),
                                                  Text("Hora de consulta " + asyncSnapshot.data.data[i].hora ),
                                                  Text("Doctor "+ asyncSnapshot.data.data[i].medico.nombres),
                                                  Text("Enlace de reunion: "+ (asyncSnapshot.data.data[i].enlace.isEmpty ? "El medico aun no ha aceptado su cita" :  asyncSnapshot.data.data[i].enlace )) ,
                                                  Container(
                                                    width: 200,
                                                    height: 200,
                                                    child: Image.network(
                                                        asyncSnapshot.data.data[i].medico.foto
                                                    ),
                                                  )
                                              ],
                                          ),
                                      ),
                                    );   
                                }
                              );
                         }else{
                           return Center(
                                child:  CircularProgressIndicator() ,
                            );   
                         }
                   }

                   return Center(
                       child:  CircularProgressIndicator() ,
                   );
               },
          ),
    );
  }
}