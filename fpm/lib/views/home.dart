
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpm/views/infoAlertas.dart';
import 'package:fpm/views/infoNodos.dart';

class Home extends StatefulWidget {
  final nombreCompleto;
  Home({Key key, this.nombreCompleto}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _nodo = new TextEditingController();
  Image appLogo = new Image(
    image: new ExactAssetImage("assets/img/head.png"),
    height: 70.0,
    width: 150.0,
    alignment: FractionalOffset.center
  );

  Widget saludoNombre(String nombreCompleto, double height){
      return Column(
        children: <Widget> [
          
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: height/8, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text( "Hola ",
                  style: TextStyle(
                    
                    fontFamily: "Abadi",
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 25,
                  )
                ),
                Text( "$nombreCompleto",
                  style: TextStyle(
                    
                    fontFamily: "Abadi",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                  )                  
                ),
                Text( ",",
                  style: TextStyle(
                    
                    fontFamily: "Abadi",
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 25,
                  )                  
                )
              ],
            )   
          ),

          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Text(
              "Aqui podras seleccionar o ver las alertas de un nodo.",
              style: TextStyle(
                fontFamily: "Abadi",
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 20,
              )
            )
          ),
        ],
      );
  }


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: appLogo,
        leading: new IconButton(
          //icono de cerrar sesion
          icon: new Icon(
            Icons.logout,
            size: 25,
          ),
          color: Colors.white,
          tooltip: "Cerrar Sesión",
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  "¿Desea cerrar sesión ahora?",
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
                      "No",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Abadi",
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, false)
                  ),
                  TextButton(
                    child: Text(
                      "Si",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Abadi",
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
                    }
                  )
                ]
              )
            );
          }
        )
      ),

      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/img/bg.png'),
              fit: BoxFit.cover
            )
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        
                        saludoNombre(widget.nombreCompleto, height),
                        
                        Column(
                          
                          children: [
                            
                            Container(
                              margin: EdgeInsets.only( left: 20, top: 40),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Seleccione el nodo:",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                              )
                            ),

                            Container(
                              margin: EdgeInsets.only( left: 20, top: 10),
                              child: TextFormField(
                                controller: _nodo,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                  labelText: "Nodo",
                                  labelStyle: TextStyle(
                                    color: Colors.white
                                  )
                                ),
                                keyboardType: TextInputType.number,
                                
                              ),
                            ),
                            
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              // ignore: missing_return
                              onTap:() async {
                                if(_nodo.text==""){
                                  print("mando ruta sin nada adentro");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoNodos()));
                                }
                                if(_nodo.text!=""){
                                  print("mando ruta con el valor del nodo");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InfoNodos(
                                    nodo: _nodo.text,
                                  )));
                                }
                              },
                              child: new Container(
                                margin: EdgeInsets.only(right:20, left: 20, top: 50, bottom: 25),
                                height: 50,
                                decoration: new BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: new BorderRadius.circular(25)
                                ),
                                child: new Center(
                                  child: new Text(
                                    'Ver información del Nodo',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              // ignore: missing_return
                              onTap:() async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => InfoAlertas()));
                              },
                              child: new Container(
                                margin: EdgeInsets.only(right:20, left: 20, top: 25, bottom: 25),
                                height: 50,
                                decoration: new BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: new BorderRadius.circular(25)
                                ),
                                child: new Center(
                                  child: new Text(
                                    'Ver información de alertas',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    
                          ]
                        ),
                              
                      ],
                    ), 
                  ],
                )
              ]
          ),
        )       
      )
    );
  
  }
}