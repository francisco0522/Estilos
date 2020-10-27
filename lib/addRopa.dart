import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estilos/ropa.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AddRopa {
  final String nombre;
  final String talla;
  final int precio;
  final String genero;
  final String tipo;
  final String descripcion;

  AddRopa(this.nombre, this.talla, this.precio, this.genero, this.tipo,
      this.descripcion);
}

final firestoreInstance = FirebaseFirestore.instance;

final TextEditingController _nombreController = TextEditingController();
final TextEditingController _precioController = TextEditingController();
final TextEditingController _tipoController = TextEditingController();
final TextEditingController _descripcionController = TextEditingController();
String dropdownValueTalla = 'Talla';
String dropdownValueGenero = 'Género';

class AddRopaPage extends StatefulWidget {
  @override
  _AddRopaPage createState() => _AddRopaPage();
}

class _AddRopaPage extends State<AddRopaPage> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  String imagePath = "";

  var retrievedName;  

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final title = 'Agregar Ropa';

    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: SafeArea(
              child: Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            child: ListView(
              children: <Widget>[
                widgetRopa(),
              ],
            ),
          )),
        ));
  }

  

  widgetRopa() {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(children: <Widget>[
          Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  hintText: 'Nombre del producto',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              )),
          Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(children: <Widget>[
              RaisedButton(
                onPressed: () {
                  chooseImage();
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Seleccionar archivo",
                    style: TextStyle(
                        color: Color.fromRGBO(193, 29, 27, 1), fontSize: 18),
                  ),
                ),
              ),
              FutureBuilder<File>(
                future: file,
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      null != snapshot.data) {
                    tmpFile = snapshot.data;
                    imagePath = tmpFile.path;
                    base64Image = base64Encode(snapshot.data.readAsBytesSync());
                    return Flexible(
                      child: Image.file(
                        snapshot.data,
                        fit: BoxFit.scaleDown,
                      ),
                    );
                  } else if (null != snapshot.error) {
                    return const Text(
                      ' Error',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return const Text(
                      ' No ha seleccionado',
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
            ]),
          ),
           Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                  height: 60.0,
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(120, 120, 120, 1),
                      ),
                      left: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(120, 120, 120, 1),
                      ),
                      right: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(120, 120, 120, 1),
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(120, 120, 120, 1),
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0) //         <--- border radius here
                        ),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValueTalla,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 30,
                    style: TextStyle(
                        color: Color.fromRGBO(120, 120, 120, 1), fontSize: 15),
                    onChanged: (String newTalla) {
                      setState(() {
                        dropdownValueTalla = newTalla;
                      });
                    },
                    items: <String>[
                      'Talla',
                      'XS',
                      'S',
                      'M',
                      'L'
                    ].map<DropdownMenuItem<String>>((String talla) {
                      return DropdownMenuItem<String>(
                        value: talla,
                        child: Text(talla),
                      );
                    }).toList(),
                  ))),
                  Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                  height: 60.0,
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(120, 120, 120, 1),
                      ),
                      left: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(120, 120, 120, 1),
                      ),
                      right: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(120, 120, 120, 1),
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(120, 120, 120, 1),
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0) //         <--- border radius here
                        ),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValueGenero,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 30,
                    style: TextStyle(
                        color: Color.fromRGBO(120, 120, 120, 1), fontSize: 15),
                    onChanged: (String newGenero) {
                      setState(() {
                        dropdownValueGenero = newGenero;
                      });
                    },
                    items: <String>[
                      'Género',
                      'Hombre',
                      'Mujer',
                      'Unisex'
                    ].map<DropdownMenuItem<String>>((String genero) {
                      return DropdownMenuItem<String>(
                        value: genero,
                        child: Text(genero),
                      );
                    }).toList(),
                  ))),
          Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(
                  hintText: 'Precio del producto',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              )),
              Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: _tipoController,
                decoration: const InputDecoration(
                  hintText: 'Tipo de producto',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              )),
              Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  hintText: 'Descripción del producto',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              )),
          RaisedButton(
            color: Color.fromRGBO(20, 120, 200, 1),
            onPressed: () {
              if(_nombreController.text != "" ||
              _precioController.text != "" ||
              dropdownValueTalla != "Talla" ||
              dropdownValueGenero != "Género" ||
              _tipoController.text != "" ||
              _descripcionController.text != ""
              ){
              crearProducto(dropdownValueTalla, dropdownValueGenero);
              }else{
                _campoVacio();
              }
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Crear Producto",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1), fontSize: 18),
              ),
            ),
          ),
        ]));
  }

  void crearProducto(dropdownValueTalla, dropdownValueGenero) {
    firestoreInstance.collection("ropas").add({
      "nombre": _nombreController.text,
      "precio": _precioController.text,
      "talla": dropdownValueTalla.toString(),
      "tipo": _tipoController.text,
      "genero" : dropdownValueGenero.toString(),
      "descripcion" : _descripcionController.text,

    }).then((value) {
      _ropaCreada();
    });
  }

  Future<void> _ropaCreada() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Se creo correctamente la ropa'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Se creo ' + _nombreController.text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return RopaPage();
                },
              ),
            );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _campoVacio() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hay un campo vacio'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Por favor llene todos los campos'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
