import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'addEditRopa.dart';
import 'sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ropaList.dart';

class InfoRopaPage extends StatefulWidget {
  InfoRopaPage({Key key, this.ropa}) : super(key: key);

  var ropa;

  @override
  _InfoRopaPage createState() => _InfoRopaPage();
}

class _InfoRopaPage extends State<InfoRopaPage> {
  @override
  @override
  void initState() {
    super.initState();
    print(widget.ropa.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ropa.nombre),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            cardRopa(),
          ],
        ),
      ),
    );
  }

  cardRopa() {
    return Container(
      child: Column(
        children: [
          Image.network(
            widget.ropa.imagen,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '' + widget.ropa.nombre,
              style: TextStyle(color: Colors.black54, fontSize: 40.0),
              children: <TextSpan>[
                TextSpan(
                    text: '\n\$' + widget.ropa.precio,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0)),
                TextSpan(
                    text: '\n\n' + widget.ropa.descripcion,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25.0)),
                TextSpan(
                    text: '\n\nTalla: ' + widget.ropa.talla,
                    style: TextStyle(color: Colors.black, fontSize: 30.0)),
                if (widget.ropa.genero == "Hombre")
                  TextSpan(
                      text: '\n' + widget.ropa.genero,
                      style:
                          TextStyle(color: Color(0xFF0B00A5), fontSize: 15.0)),
                if (widget.ropa.genero == "Mujer")
                  TextSpan(
                      text: ' ' + widget.ropa.genero,
                      style:
                          TextStyle(color: Color(0xFFC53EC5), fontSize: 15.0)),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                textColor: const Color(0xFF00B6EE),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AddEditRopaPage(
                            function: "Editar", idRopa: widget.ropa.id);
                      },
                    ),
                  );
                },
                child: const Text('Editar'),
              ),
              FlatButton(
                textColor: const Color(0xFFEE0000),
                onPressed: () {
                  setState(() {
                    _delete(widget.ropa.id);
                  });
                },
                child: const Text('Eliminar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _delete(id) {
    firestoreInstance.collection("ropas").doc(id).delete().then((_) {
      print("success!");
      setState(() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return RopaListPage();
            },
          ),
        );
      });
    });
  }
}
