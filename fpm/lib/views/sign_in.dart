import 'package:flutter/material.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:flutter/services.dart';
import 'package:fpm/views/home.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool buttonDisable;
  String usuario="admin";
  String contra="1234";

  //formularios
  final form = new GlobalKey<FormState>();

  //Controladores
  TextEditingController _usser = TextEditingController();
  TextEditingController _pass = TextEditingController();

  bool validator() {
    bool vd = true;
    if (_usser.value.text != '' && _pass.value.text != '') {
      vd = false;
    } else {
      vd = true;
    }
    return vd;
  }

  iniciarSesion(String usser,String pass){
    if (usser==usuario){
      if(pass==contra){
        print("credenciales correctas");
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(nombreCompleto: usser,)));
      }
      else{
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Password Incorrecta",
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "Abadi",
                color: Colors.black,
                fontWeight: FontWeight.w300
              ),
            ),

            actions: <Widget>[
              TextButton(
                child: Text(
                  "Ok",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Abadi",
                    fontWeight: FontWeight.w300
                  ),
                ),
                onPressed: () => Navigator.pop(context, false)
              ),
            ]
          )
        );
      }
    }

    else{
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Credenciales Incorrectas",
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "Abadi",
              color: Colors.black,
              fontWeight: FontWeight.w300
            ),
          ),

          actions: <Widget>[
            TextButton(
              child: Text(
                "Ok",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Abadi",
                  fontWeight: FontWeight.w300
                ),
              ),
              onPressed: () => Navigator.pop(context, false)
            ),
          ]
        )
      );
    }
  }

   @override
  void initState() {
    super.initState();
    buttonDisable = true;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
      textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.4),
      // textScaleFactor:0.5,
    ),
    
    child: Scaffold(
        //backgroundColor:Color(int.parse("0xff${snapshotApp.data.colApp1}")),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/img/bg.png'),
                fit: BoxFit.cover
              )
            ),
      
            child:Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Container(
                            margin: EdgeInsets.only(top: 60),
                            height: 200,
                            width: 400,
                            // child: Image(
                            //   image: AssetImage("assets/img/logo.png"),
                            //   width: 400,
                            //   height: 200,
                            // ),
                          ),
                        ),
                        
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: form,
                            child: new Column(
                              children: <Widget>[
                                new TextFormField(
                                  controller: _usser,
                                  onChanged: (text) {
                                    setState(() {
                                      buttonDisable = validator();
                                    });
                                  },
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                  decoration: new InputDecoration(
                                    fillColor: Colors.black,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white
                                      )
                                    ),
                                    focusedBorder: UnderlineInputBorder( 
                                      borderSide: BorderSide(
                                        color: Colors.white
                                      )
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.white
                                    ),
                                    labelText: "Usuario",
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                                  //keyboardType: TextInputType.text,
                                  
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value.isEmpty) return 'Ingrese su usuario Por favor';
                                  },
                                ),
                                new TextFormField(
                                  controller: _pass,
                                  onChanged: (text) {
                                    setState(() {
                                      buttonDisable = validator();
                                    });
                                  },
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  decoration: new InputDecoration(
                                    fillColor: Colors.black,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white
                                      )
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white
                                      )
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.white
                                    ),
                                    labelText: "Contraseña",
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                                  obscureText: true,
                                  //keyboardType: TextInputType.text,
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value.isEmpty) return 'Ingrese su contraseña';
                                  },
                                ),
                                new InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  // ignore: missing_return
                                  onTap: (buttonDisable)
                                  ? null
                                  : () async {
                                    if (form.currentState.validate()) {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      iniciarSesion(_usser.value.text,_pass.value.text);
                                    }
                                  },
                                  child: new Container(
                                    margin: EdgeInsets.only(top: 20, bottom: 25),
                                    height: 50,
                                    decoration: new BoxDecoration(
                                      color: (buttonDisable)
                                      ? Color(0xFFC4C4C4)
                                      : Colors.green,
                                      borderRadius: new BorderRadius.circular(25)
                                    ),
                                    child: new Center(
                                      child: new Text(
                                        'Ingresar con mi Clave',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) 
                      ],
                    )
                  ],
                )
              ],
            ),
            
          )
        )
      )
    );
                      
  }
}