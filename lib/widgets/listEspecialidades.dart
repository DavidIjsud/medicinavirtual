import 'package:flutter/material.dart';
import 'package:flutterwebtopico/helpers/notifierValueChange.dart';
import 'package:flutterwebtopico/interfaces/responseListEspecialidadAndMedico.dart';
import 'package:flutterwebtopico/interfaces/responseListEspecialidades.dart';
import 'package:flutterwebtopico/providers/Paciente.provider.dart';
import 'package:flutterwebtopico/widgets/listMedicos.dart';

class ListEspecialidadesWidget extends StatefulWidget {
  const ListEspecialidadesWidget({ Key key }) : super(key: key);


  @override
  _ListEspecialidadesWidgetState createState() => _ListEspecialidadesWidgetState();
}

class _ListEspecialidadesWidgetState extends State<ListEspecialidadesWidget> {

  Singleton _changeMedicoHorarios;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      this._changeMedicoHorarios = new Singleton();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  FutureBuilder(
              future: PacienteProvider.especialidades() ,
              builder: (_, AsyncSnapshot<ResponseListEspecialidades> asyncSnapshot  ){
                   if( !asyncSnapshot.hasData ){
                        return Center(child: CircularProgressIndicator());
                   }else{
                        return ListView.builder(
                           itemCount: asyncSnapshot.data.data.length,
                           itemBuilder: (_,i){
                                return Padding(
                                  padding: const EdgeInsets.symmetric( horizontal: 10 ),
                                  child: GestureDetector(
                                    onTap: (){
                                         print("PAsa");
                                         this._changeMedicoHorarios.changeWidget(ListMedicosWidget(  especialidad: asyncSnapshot.data.data[i].id,  ));
                                    },
                                    child: Card(
                                        elevation: 30,
                                        child: Container(
                                          width: 350,
                                          height: 100,
                                          decoration: new BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Colors.orange[600],Colors.orange[400],Colors.orange[200]],
                                              stops: [0.5,0.5,0.8],
                                              begin: FractionalOffset.topCenter,
                                              end: FractionalOffset.bottomCenter
                                            )
                                          ),
                                         child:  Center(child: Text( asyncSnapshot.data.data[i].nombre , style : TextStyle( fontSize: 20 , fontWeight:  FontWeight.bold, color: Colors.white  ) )) , 
                                        )   
                                    ),
                                  ),
                                ); 
                            }
                          );
                   }
              }
            ), 
    );
  }
}