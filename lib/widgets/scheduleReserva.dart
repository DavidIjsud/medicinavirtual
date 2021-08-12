import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutterwebtopico/helpers/notifierValueChange.dart';
import 'package:flutterwebtopico/interfaces/responseDiasMedico.dart';
import 'package:flutterwebtopico/interfaces/responseHorasMedico.dart';
import 'package:flutterwebtopico/providers/Paciente.provider.dart';
import 'package:flutterwebtopico/widgets/ListOfReservas.dart';
import 'package:flutterwebtopico/widgets/listEspecialidades.dart';
import 'package:flutterwebtopico/widgets/listMedicos.dart';

class AgendarReserva extends StatefulWidget {
  const AgendarReserva({ Key key , this.idMedico }) : super(key: key);

  final int idMedico;

  @override
  _AgendarReservaState createState() => _AgendarReservaState();
}

class _AgendarReservaState extends State<AgendarReserva> {


  String hora, dia;
  int idHora, idDia;
  var progress;

  Singleton singleton;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();

        this.hora = "Seleccione una hora";
        this.dia  = "Seleccione un dia";
        this.singleton = new Singleton();

    }

  

void showDialog() {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          child: Expanded(
               child: FutureBuilder(
                   future:  PacienteProvider.receiveDiasOfMedico(widget.idMedico) ,
                   builder:  (BuildContext c, AsyncSnapshot<ResponseDiasMedicos> asyncSnapshot ){
                          if( asyncSnapshot.hasData ){
                              if( asyncSnapshot.data.status ){
                                    return ListView.builder(
                                        itemCount: asyncSnapshot.data.data.length,
                                        itemBuilder: ( _ , i ){
                                             return GestureDetector(
                                               onTap: (){
                                                  this.setState(() {
                                                    this.idDia = asyncSnapshot.data.data[i].dia.id;
                                                    this.dia = asyncSnapshot.data.data[i].dia.nombre;                                                    
                                                  });
                                                  Navigator.of(context).pop();
                                               },
                                               child: Card(
                                                    color: Colors.white,
                                                    elevation: 10,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: Center(
                                                          child: Text( asyncSnapshot.data.data[i].dia.nombre )  ,
                                                      ),
                                                    )
                                               ),
                                             );     
                                        }
                                      );
                              }else{
                                return Center( child: CircularProgressIndicator() , );
                              }
                          }

                          return Center(child: CircularProgressIndicator());
                   },
               )  ,
          ),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

void showDialogHoras() {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          child: Expanded(
               child: FutureBuilder(
                   future:  PacienteProvider.receiveHorasOfMedico(widget.idMedico) ,
                   builder:  (BuildContext c, AsyncSnapshot<ResponseHorasMedicos> asyncSnapshot ){
                          if( asyncSnapshot.hasData ){
                              if( asyncSnapshot.data.status ){
                                    return ListView.builder(
                                        itemCount: asyncSnapshot.data.data.length,
                                        itemBuilder: ( _ , i ){
                                             return GestureDetector(
                                               onTap: (){
                                                 this.setState(() {
                                                    this.idHora = asyncSnapshot.data.data[i].horario.id;
                                                    this.hora = asyncSnapshot.data.data[i].horario.horaFijada;                                                    
                                                  });
                                                  Navigator.of(context).pop();
                                               },
                                               child: Card(
                                                    color: Colors.white,
                                                    elevation: 10,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: Center(
                                                          child: Text( asyncSnapshot.data.data[i].horario.horaFijada )  ,
                                                      ),
                                                    )
                                               ),
                                             );     
                                        }
                                      );
                              }else{
                                return Center( child: CircularProgressIndicator() , );
                              }
                          }

                          return Center(child: CircularProgressIndicator());
                   },
               )  ,
          ),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child:  Builder(
        builder: (x) {
          this.progress = ProgressHUD.of(x); 
          return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     IconButton(icon: Icon( Icons.arrow_back ), onPressed: (){
                          this.singleton.changeWidget( ListEspecialidadesWidget() );
                     }),
                     SizedBox( height: 100, ),
                     Center(
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
                         child: ElevatedButton.icon(onPressed: (){
                             showDialog();
                         }, icon: Icon(Icons.access_alarms)  , label: Text( this.dia    ,  style : TextStyle( fontSize: 20 , fontWeight:  FontWeight.bold, color: Colors.white  )  ))),
                     ),
                     
                     SizedBox( height: 20, ),

                     Center(
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
                         child: ElevatedButton.icon(onPressed: (){
                           showDialogHoras();
                         }, icon:  Icon(Icons.medical_services) , label: Text( this.hora  , style : TextStyle( fontSize: 20 , fontWeight:  FontWeight.bold, color: Colors.white  )  )  )),
                     ),
                      SizedBox( height: 40 ),
                      Center(
                        child: Container(
                          width: 350,
                          height: 100,
                          color: Colors.red,
                         child: ElevatedButton.icon(  onPressed: (){
                             
                              if( this.hora == "Seleccione una hora" || this.dia == "Seleccione un dia" ){
                                  final snackBar = SnackBar(content: Text('Debes seleccionar una hora y un dia'));

                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    
                                    return;
                              }
                              this.progress.showWithText("Guardando reserva, espera...");
                              PacienteProvider.saveNewReserva( widget.idMedico , 8457691 , this.hora  ,  this.dia )
                                    .then((value) {
                                      this.progress.dismiss();
                                        if( value ){
                                              final snackBar = SnackBar(content: Text('Reserva guardada, se le notificara cuando el medico haya aceptado'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            Future.delayed(Duration(  seconds: 3  ), () =>{
                                                this.singleton.changeWidget( ListOfReservas() )
                                            } );
                                        }else{
                                             final snackBar = SnackBar(content: Text('Error al guardar la reserva'));
                                             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                    });
                              

                         }  ,  icon: Icon(Icons.access_alarms)  , label: Text("RESERVAR CITA" , style : TextStyle( fontSize: 20 , fontWeight:  FontWeight.bold, color: Colors.white  )  ))),
                      )
                ],
          ),
      );
        }
      ) ,
    );
  }
}