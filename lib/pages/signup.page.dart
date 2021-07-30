import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterwebtopico/pages/login.page.dart';
import 'package:flutterwebtopico/providers/Paciente.provider.dart';
import 'package:flutterwebtopico/widgets/bezierContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

 TextEditingController controladorCorreo, controladorCi , controladorNombres, controladorApellidos, controladorTelefono , controladorDateBirth, controladorPasword, controladorFoto;

  @override
  void initState() {
      super.initState();
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
                  if( title == "Fecha Nacimiento" ){
                    FocusScope.of(contexto).requestFocus(new FocusNode());
                    _mostrarDate(contexto);
                  }

                  if( title == "Subir Foto" ){  
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
      var picked = await FilePicker.platform.pickFiles( type:  FileType.image,  );
      if( picked != null ){
          var primeraFoto = picked.files.first;
          print("Recogio");
          PacienteProvider.sendData( primeraFoto );
      }else{
          print("No recogio");
      }
  }

  Widget _submitButton() {
    return Container(
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
        _entryField("Correo(Usuario)" ,  TextInputType.emailAddress , this.controladorCorreo ),
        _entryField("Ci", TextInputType.number  , this.controladorCi ),
        _entryField('Nombres', TextInputType.text , this.controladorNombres),
        _entryField('Apellidos',TextInputType.text , this.controladorApellidos),
        _entryField('Telefono', TextInputType.phone , this.controladorTelefono ),
        _entryField('Fecha Nacimiento', TextInputType.datetime , this.controladorDateBirth  , isBirth: true ,contexto: contexto   ),
        _entryField("Password", TextInputType.text , this.controladorPasword ,isPassword: true),
        _entryField("Subir Foto" ,  TextInputType.text , this.controladorFoto , isBirth:  true )  
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(context),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}