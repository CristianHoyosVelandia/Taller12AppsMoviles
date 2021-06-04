import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse("0xff00632f")),
      body:Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("assets/img/load.png"),
              fit: BoxFit.cover
            )
          ),

          child: ListView(
            children: <Widget>[
              Column(     
                children: <Widget>[
                  // Container(
                    // child: Image(
                    //   image: AssetImage("assets/img/logo.png"),
                    //   width: 400.0,
                    //   height: 160.0,
                    // ),
                  //   margin: EdgeInsets.only(top: (width)/2),
                  //   alignment: AlignmentDirectional.center,
                  // ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    )
                  )
                ]
              )
            ]
          )
        )
      )
    
    );
  }
}

class MyProgressIndicatorNoList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          child: Image(
            image: AssetImage("assets/img/logo.png"),
            width: 160.0,
            height: 160.0,
          ),
          margin: EdgeInsets.only(top: (width/2)),
          alignment: AlignmentDirectional.center,
        ),
        Container(
          alignment: AlignmentDirectional.center,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            
          ),
        )
      ],
    );
  }
}