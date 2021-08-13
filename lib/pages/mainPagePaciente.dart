import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutterwebtopico/helpers/notifierValueChange.dart';
import 'package:flutterwebtopico/providers/push_notifications_providers.dart';

class HomeMainPagePaciente extends StatefulWidget {
  const HomeMainPagePaciente({ Key key }) : super(key: key);

  @override
  _HomeMainPagePacienteState createState() => _HomeMainPagePacienteState();
}

class _HomeMainPagePacienteState extends State<HomeMainPagePaciente> {

  Singleton _widgetChangeMedicoHorarios;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();

        final pushNotifcationProvider = new PushNotificationProvider();
         pushNotifcationProvider.initNotifications();

          pushNotifcationProvider.mensajes.listen( (onData) => {
                    //navigatorKey.currentState.pushNamed('mensaje', arguments:  onData  )
           } );

        this._widgetChangeMedicoHorarios = new Singleton();

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
             leading: Container(),
             title: Text("Bienvenido"),
             actions: [
               IconButton(
                   onPressed: (){},
                   color: Colors.white,
                   icon:  Icon( 
                       Icons.menu,
                        color: Colors.white,
                   ),
               ),
             ],
             backgroundColor: Colors.orange,
         ), 
         body:  Container(
              child: ChangeNotifierBuilder(
                   notifier: this._widgetChangeMedicoHorarios,
                   builder: ( _ , wc , w ){
                        return wc.widget;
                   },
              ),
         ) ,
    );
  }
}