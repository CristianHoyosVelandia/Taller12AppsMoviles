

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpm/model/ruta.dart';
import 'package:http/http.dart' as http;


class InfoAlertas extends StatefulWidget {
  InfoAlertas({Key key}) : super(key: key);

  @override
  _InfoAlertasState createState() => _InfoAlertasState();
}

class _InfoAlertasState extends State<InfoAlertas> {
  
  Rutas objRutas = Rutas();
  var _baseAlarmas;
  // var _baseAlarmas="http://192.168.1.12:3000/alertas";

  Future<List<Alarmas>> _listaAlarmas;

  Future<List<Alarmas>> _getAlarmas() async {
    
    final response = await http.get(_baseAlarmas);

    if(response.statusCode == 200){
      
      String body= utf8.decode(response.bodyBytes);
      final jsonData= jsonDecode(body);
      print(jsonData);
      
      List<Alarmas> _lista=[];
      
      for (var item in jsonData){
        _lista.add(Alarmas(item["idnodo"], item["alerta"], item["fecha"]));
      }
      return _lista;
    }
    else{
      throw Exception("Fallo la conexión");
    }
  }
  
  @override
  void initState() { 
    super.initState();
    _baseAlarmas="http://"+objRutas.getrutaIpv4()+"/alertas";
    _listaAlarmas= _getAlarmas();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        centerTitle: true,
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
          child: FutureBuilder(

            future: _listaAlarmas,
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                print(snapshot.data.length);
                return Center(
                  child:ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                      
                        return ListTile(
                          title: Container( 
                            margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
                            child: Text(
                              'Fecha: '+snapshot.data[index].fecha,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              ),
                            )
                          ),
                          subtitle: Container( 
                            margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                            child:Text(
                              snapshot.data[index].alerta,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                                ),
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Text(snapshot.data[index].idnodo.toString()),
                          ),
                        );
                      } 
                  )
                );
              }
              else if (snapshot.hasError){
                print(snapshot.error);
                return Text("error");
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
          )
        )
        
      )
    
    );   
  }
}

class Alarmas {

  int idnodo;
  String alerta;
  String fecha;


  Alarmas(idnodo, alerta, fecha){
    this.idnodo=idnodo;
    this.fecha=fecha;
    if(alerta==null){
      this.alerta=" No se registro alerta";
    }
    else{
      this.alerta= alerta;
    }
  }

 
}

