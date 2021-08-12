import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutterwebtopico/interfaces/response.dart';
import 'package:flutterwebtopico/pages/login.page.dart';
import 'package:flutterwebtopico/providers/Paciente.provider.dart';
import 'package:flutterwebtopico/widgets/bezierContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

 TextEditingController  controladorValidarPinField ,controladorSeguro, controladorGrupoSanguineo  ,controladorCorreo, controladorCi , controladorNombres, controladorApellidos, controladorTelefono , controladorDateBirth, controladorPasword, controladorFoto;
 XFile fotoFile;

  @override
  void initState() {
      super.initState();
      this.fotoFile = null;
      inicializarControlers();
  }

  void inicializarControlers(){
      this.controladorCorreo = new TextEditingController(text: "");
      this.controladorCi = new TextEditingController(text: "");
      this.controladorNombres = new TextEditingController(text: "");
      this.controladorApellidos = new TextEditingController(text: "");
      this.controladorTelefono = new TextEditingController(text: "");
      this.controladorDateBirth = new TextEditingController(text: "");
      this.controladorPasword = new TextEditingController(text: "");
      this.controladorFoto = new TextEditingController(text: "");   
      this.controladorGrupoSanguineo = new TextEditingController(text: "");
      this.controladorSeguro = new TextEditingController(text: "");
      this.controladorValidarPinField = new TextEditingController(text: "");
   }

  Widget _backButton() {    
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Atras',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  void _mostrarDate(BuildContext context) {
          
          DateFormat dateFormat = DateFormat("yyyy-MM-dd");
         showDatePicker(
          locale: Locale('es'),
          context: context,
          firstDate: DateTime(1900,0),
          initialDate: DateTime.now(),
          lastDate: new DateTime(2101),
          builder: ( BuildContext contexto , Widget child ) {
              return Theme(
                  data: ThemeData.light().copyWith(
                     buttonTheme: ButtonThemeData(
                          textTheme: ButtonTextTheme.primary
                        ),
                    colorScheme: ColorScheme.light( primary  : Colors.red ),
                    primaryColor: Colors.red,//Head background
                    accentColor: Colors.red//selection color
                    //dialogBackgroundColor: Colors.white,//Background color
                    ),     
                    child: child,
              );
          } 
        ).then( (DateTime fecha){
             if( fecha != null ){
                  String valor =  dateFormat.format(fecha);
                  ///esto se hara solo para mostrar en la vista pero al servidor se manda otro
                  DateFormat formaToVisual = DateFormat("yyyy-MM-dd");
                  String formatoVisualString = formaToVisual.format(fecha);
                  this.controladorDateBirth.text = formatoVisualString;
             }
   
        } );
   }

  Widget _entryField(String title, TextInputType inputType , TextEditingController controller , {bool isPassword = false , bool isBirth = false , BuildContext contexto }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller:  controller,
              obscureText: isPassword,
              keyboardType:  inputType,
              enableInteractiveSelection: isBirth,
              onTap: () async {
                  if( title == "* Fecha Nacimiento" ){
                    FocusScope.of(contexto).requestFocus(new FocusNode());
                    _mostrarDate(contexto);
                  }

                  if( title == "* Subir Foto" ){  
                       //FocusScope.of(contexto).requestFocus(new FocusNode());
                      FocusManager.instance.primaryFocus?.unfocus();
                      await _pickFile();
                   }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

   _pickFile()  async {

     final ImagePicker _picker = ImagePicker();
      XFile foto  = await _picker.pickImage( source: ImageSource.camera );
      if( foto != null ){
          this.fotoFile = foto;
          this.controladorFoto.text = this.fotoFile.path;
      }
     
  }

  bool _validateFields() {
       if( this.controladorCorreo.text == null || this.controladorCorreo.text == "" ||
           this.controladorCi.text == null || this.controladorCi.text == "" ||
           this.controladorNombres.text == null || this.controladorNombres.text == "" ||
           this.controladorApellidos.text == null || this.controladorApellidos.text == "" ||
           this.controladorTelefono.text == null || this.controladorTelefono.text == "" ||
           this.controladorDateBirth.text == null || this.controladorDateBirth.text == "" ||
           this.controladorPasword.text == null || this.controladorPasword.text == "" ||
           this.controladorFoto.text == null || this.controladorFoto.text == ""

        ) return false;

        return true;
  }


  _enviarInformacion( BuildContext contexto ){
        Map<String, String> informacion = {
            "fechaNacimiento" : this.controladorDateBirth.text,
            "ci" : this.controladorCi.text,
            "apellidos" : this.controladorApellidos.text,
            "nombres" : this.controladorNombres.text,
            "telefono" : this.controladorTelefono.text,
            "email" : this.controladorCorreo.text,
            "contrasena" : this.controladorPasword.text,
            "seguro" : this.controladorSeguro.text,
            "gruposanguieo" : this.controladorGrupoSanguineo.text   
        };
        final progress = ProgressHUD.of(contexto);
        progress.showWithText('Verificar pin en su correo, no cerrar app');
        PacienteProvider.sendData(informacion,  this.fotoFile )
           .then((value) {
                  print(value['status']);
                  progress.dismiss();
                  if( value['status'] == 'true' ){
                      _dialogForPin(contexto);
                  }else{
                      final snackBar = SnackBar(content: Text('Something went wrong'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar); 
                  } 
                  
           });
  }

  Widget _btnValidarPin( BuildContext cont ){
      return RaisedButton(
             onPressed: (){
                  final progress = ProgressHUD.of(cont);
                  if( this.controladorValidarPinField == null || this.controladorValidarPinField.text == "" ){
                      final snackBar = SnackBar(content: Text('Debe ingresar un pin, verificar su correo ingresado'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar); 
                       
                  }else{
                      progress.showWithText('Validando pin, no cerrar app'); 
                        Navigator.of(cont).pop();
                        PacienteProvider.validatePin(  int.parse(this.controladorValidarPinField.text) , int.parse( this.controladorCi.text ) , this.controladorCorreo.text     )
                             .then((value) {
                                   if( value['status'] == 'true' ){
                                      progress.dismiss();
                                      final snackBar = SnackBar(content: Text('Pin Correcto'));
                                       ScaffoldMessenger.of(cont).showSnackBar(snackBar);
                                        Future.delayed( Duration( seconds: 1 ) , () => {
                                             Navigator.pop(
                                                context, MaterialPageRoute(builder: (context) => LoginPage()))
                                       });
                                   }else{
                                       progress.dismiss();
                                       final snackBar = SnackBar(content: Text('Pin incorrecto vuelva a intentarlo'));
                                       ScaffoldMessenger.of(cont).showSnackBar(snackBar);
                                       Future.delayed( Duration( seconds: 2 ) , () => {
                                             _dialogForPin(cont)
                                       });
                                   }
                             });
                  }
             },
             child: Container(
                 child: Text("Verificar"),
                 padding: EdgeInsets.symmetric( horizontal: 50, vertical: 10 ),
                 
             ),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                elevation: 0.0,
                color:  Colors.white ,
                textColor: Colors.red,
         );
  }

  void _dialogForPin( BuildContext contextox ){
     showDialog(
                barrierDismissible: false,
                context: contextox,
                builder: ( BuildContext contexto ) {
                      return Dialog(
                           backgroundColor:  Colors.transparent,
                           shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all( Radius.circular(20.0) )
                           ),
                           child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: TextField(
                                    controller:  this.controladorValidarPinField ,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20.0)),

                                      filled: true,
                                      fillColor: Colors.white,

                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Ingresar Pin",
                                    ),
                                    onChanged: (value) {
                                    },
                                  ),
                               ),
                               SizedBox( height: 20, ),
                               _btnValidarPin( contextox )
                              
                              ],
                           ),
                      );       
                }
     );    

  }

  Widget _submitButton( BuildContext contexto ) {
    return GestureDetector(
      onTap: (){
         bool validados = _validateFields();
          if( validados == false ){
              print('object');
              final snackBar = SnackBar(content: Text('Llenar todos los campos'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
          }
          _enviarInformacion( contexto );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Registrarse',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ya tienes una cuenta ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Ingresa',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Top',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ico',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' Avanzado',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget( BuildContext contexto ) {
    return Column(
      children: <Widget>[
        _entryField("* Correo(Usuario)" ,  TextInputType.emailAddress , this.controladorCorreo ),
        _entryField("* Ci", TextInputType.number  , this.controladorCi ),
        _entryField('* Nombres', TextInputType.text , this.controladorNombres),
        _entryField('* Apellidos',TextInputType.text , this.controladorApellidos),
        _entryField('* Telefono', TextInputType.phone , this.controladorTelefono ),
        _entryField('* Fecha Nacimiento', TextInputType.datetime , this.controladorDateBirth  , isBirth: true ,contexto: contexto   ),
        _entryField("* Password", TextInputType.text , this.controladorPasword ,isPassword: true),
        _entryField( "Seguro" , TextInputType.text , this.controladorSeguro   ),  
        _entryField("Grupo Sanguineo",  TextInputType.text , this.controladorGrupoSanguineo ),
        _entryField("* Subir Foto" ,  TextInputType.text , this.controladorFoto , isBirth:  true ),
       
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ProgressHUD(
        barrierEnabled: false,
        indicatorColor: Colors.red,
        child: Builder(
          builder:( contextProgress ) => Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(contextProgress).size.height * .15,
                right: -MediaQuery.of(contextProgress).size.width * .4,
                child: BezierContainer(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .1),
                      
                      _title(),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Campos * son obligatorios"),
                      SizedBox(
                        height: 20,
                      ),
                      _emailPasswordWidget(contextProgress),
                      SizedBox(
                        height: 10,
                      ),
                      _submitButton(contextProgress),
                      SizedBox(height: height * .01),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ),
       )
      ),
    );
  }
}