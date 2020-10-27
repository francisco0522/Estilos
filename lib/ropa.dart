
import 'package:estilos/addRopa.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sign_in.dart';


class RopaPage extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
    

    final title = 'Lista de Ropa';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 1,
          children: List.generate(100, (index) {
            return Center(
              child: Column(
                children: [
                  FlutterLogo(size: 150),
                  Text(
                'Nombre $index',
                 style: TextStyle(fontSize: 20.0),
              ),
               Text(
                'talla $index',
                style: TextStyle(fontSize: 20.0),
              ),
               Text(
                'precio $index',
                style: TextStyle(fontSize: 20.0),
              ),
               Text(
                'género $index',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                'tipo de prenda $index',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                'descripción $index',
                style: TextStyle(fontSize: 20.0),
              ),
                ],
              )              
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddRopaPage();
                },
              ),
            );
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
    ),
      ),
    );



  }
}