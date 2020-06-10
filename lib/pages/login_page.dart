import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seetec/pages/falha.dart';
import 'package:seetec/pages/sucesso.dart';

const req = "https://seetecc.herokuapp.com/api/operador/login";

class Home extends StatelessWidget{

  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Login")
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person,size:150, color:Colors.black),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  )
              ),
              controller: email,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )
              ),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25),
              controller: senha,
              obscureText: true,
            ),
            RaisedButton(
              onPressed: (){
                retornoApi(context, email.text,senha.text);
                /*imprimir(email.text, senha.text);
                if(email.text == "admin" && senha.text == "1234"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> bemVindo()));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> erroLogin()));
                }*/
              },
              child: Text(
                  "login"
              ),
            ),
            Text(
              "Esqueci a senha",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 25),
            )
          ],
        ),
      ) ,
    );
  }
}


void retornoApi(context, String email, String senha) async{


    http.Response response = await http.post(req, body: json.encode({"email":email,"senha":senha}) ,headers: {
      "Content-Type" : "application/json",
      "accept" : "application/json",
    });
    Map mapResponse = json.decode(response.body);
    if(mapResponse['menseger']){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> bemVindo()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> erroLogin()));
    }


}