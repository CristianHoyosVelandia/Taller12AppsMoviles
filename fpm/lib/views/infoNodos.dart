

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpm/model/ruta.dart';
import 'package:http/http.dart' as http;

//probando el git del repositorio
class InfoNodos extends StatefulWidget {
  
  final String nodo;
  
  InfoNodos(
    {
      Key key, 
      this.nodo
    }
  ) : super(key: key);

  @override
  _InfoNodosState createState() => _InfoNodosState();
}

class _InfoNodosState extends State<InfoNodos> {
  
  Rutas objRutas = Rutas();
  var _baseNodos;
  // var _baseAlarmas="http://192.168.1.12:3000/alertas";

  Future<List<Nodos>> _listaNodos;

  Future<List<Nodos>> _getNodos() async {
    
    final response = await http.get(_baseNodos);

    if(response.statusCode == 200){
      
      String body= utf8.decode(response.bodyBytes);
      final jsonData= jsonDecode(body);
      // print(jsonData);
      
      List<Nodos> _lista=[];
      
      for (var item in jsonData){
        if(widget.nodo==null){
        _lista.add(
          Nodos(
            item['idnodo'], 
            item['voltaje'], 
            item['corriente'], 
            item['pactiva'], 
            item['eactiva'],
            item['horafecha']));
        }
        else{
          if(widget.nodo==item['idnodo'].toString()){
            _lista.add(
              Nodos(
                item['idnodo'], 
                item['voltaje'], 
                item['corriente'], 
                item['pactiva'], 
                item['eactiva'],
                item['horafecha']
              )
            );
          }
        }
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
    _baseNodos="http://"+objRutas.getrutaIpv4()+"/datos";
    print(_baseNodos);
    _listaNodos= _getNodos();
    
    
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

            future: _listaNodos,
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                // print(snapshot.data);
                return 
                ListView(
                  children: 
                  [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dividerThickness: 2,
                        dataRowHeight: 50,
                        headingRowHeight: 50,
                        sortColumnIndex: 0,
                        sortAscending: true,
                        columns: [
                          DataColumn( label: Text( "ID Nodo", style: TextStyle( fontSize: 15, color: Colors.white ),),),
                          DataColumn( label: Text( "Voltaje", style: TextStyle( fontSize: 15, color: Colors.white ),), ),
                          DataColumn( label: Text( "Corriente", style: TextStyle( fontSize: 15, color: Colors.white ),), ),
                          DataColumn( label: Text( "P activa", style: TextStyle( fontSize: 15, color: Colors.white ),),),
                          DataColumn( label: Text( "e activa", style: TextStyle( fontSize: 15, color: Colors.white ),),),
                          DataColumn( label: Text( "Fecha", style: TextStyle( fontSize: 15, color: Colors.white ),),),
                          
                        ], 
                        rows: List<DataRow>.generate(
                        snapshot.data.length,
                        (index) => DataRow(cells: [
                          DataCell(Text(snapshot.data[index].idnodo.toString(), style: TextStyle( fontSize: 15, color: Colors.white ))),
                          DataCell(Text(snapshot.data[index].voltaje.toString(), style: TextStyle( fontSize: 15, color: Colors.white ))),
                          DataCell(Text(snapshot.data[index].corriente.toString(), style: TextStyle( fontSize: 15, color: Colors.white ))),
                          DataCell(Text(snapshot.data[index].pactiva.toString(), style: TextStyle( fontSize: 15, color: Colors.white ))),
                          DataCell(Text(snapshot.data[index].eactiva.toString(), style: TextStyle( fontSize: 15, color: Colors.white ))),
                          DataCell(Text(snapshot.data[index].horafecha.toString(), style: TextStyle( fontSize: 15, color: Colors.white ))),
                        ])),
                      ),
                    ),
                  ]
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

class Nodos {

  var idnodo;
  var voltaje;
  var corriente;
  var pactiva;
  var eactiva;
  var horafecha;


  Nodos(idnodo, voltaje,corriente,pactiva,eactiva, horafecha){
  // Nodos(idnodo, horafecha){
    this.idnodo=idnodo;
    this.voltaje=voltaje;
    this.corriente=corriente;
    this.pactiva=pactiva;
    this.eactiva=eactiva;
    this.horafecha=horafecha;
  }

 
}