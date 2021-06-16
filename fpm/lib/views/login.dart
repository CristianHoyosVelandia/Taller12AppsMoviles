import 'package:flutter/material.dart';
import 'package:fpm/views/sign_in.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  //atributos
  double height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    return myScaffold(context, height);

  }

  Widget myScaffold(BuildContext context, double height) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
      textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.4),
      // textScaleFactor:0.5,
      ),
    
      child:Scaffold(
        //backgroundColor: Color(int.parse("0xff$color1")),
        backgroundColor: Colors.white,
        body:Center(
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
                  
                  Container(
                    child: Container(
                      margin: EdgeInsets.only(top: height/4, bottom: 20),
                      child: new Image(
                        image: AssetImage("assets/img/logo.png"),
                        width: 150,
                        height: 150,
                      ),
                    )
                  ),
                  
                  InkWell(
                    
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                    },

                    child: new Container(
                      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                      height: 50,
                      decoration: new BoxDecoration(
                        color: Colors.green,
                        borderRadius: new BorderRadius.circular(25),
                      ),
                      child: new Center(
                        child: new Text(
                          'Ingresar a mi cuenta',
                          style: TextStyle(fontSize: 18, color: Colors.white)
                        ),
                      ),
                    ),
                  ),
                  
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "No tengo cuenta",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20, left: 5, bottom: 20),
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Text(
                              "Registrarme",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            onTap: () {
                              // Navigator.push(context,MaterialPageRoute(builder: (context) => RegistroUsuario()));
                            },
                          )
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          )
        ),
      )
    );
  }
} 