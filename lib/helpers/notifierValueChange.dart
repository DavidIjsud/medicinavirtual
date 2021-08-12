import 'package:flutter/material.dart';
import 'package:flutterwebtopico/widgets/listEspecialidades.dart';

class WidgetChangeMedicoHorarios extends ChangeNotifier{
    
     Widget _widget;
     WidgetChangeMedicoHorarios(){
         this._widget = ListEspecialidadesWidget();
     }

     void changeWidget( Widget w ){
          _widget = w;
          notifyListeners();
     }

     Widget get widget => _widget;

}



class Singleton extends ChangeNotifier {
  static final Singleton _singleton = Singleton._internal();
  Widget widget = new ListEspecialidadesWidget();

  factory Singleton() {
   
    return _singleton;
  }

  Singleton._internal();

  void changeWidget( Widget w ){
          this.widget = w;
          notifyListeners();
  }
}