import 'package:estilos/addEditRopa.dart';
import 'package:flutter/material.dart';
import 'infoRopa.dart';

class RopaListPage extends StatefulWidget {
  @override
  _RopaListPage createState() => _RopaListPage();
}

class RopaInfo {
  String id;
  String nombre;
  String talla;
  String precio;
  String genero;
  String tipo;
  String descripcion;
  String imagen;

  RopaInfo(id, nombre, talla, precio, genero, tipo, descripcion, imagen) {
    this.id = id;
    this.nombre = nombre;
    this.precio = precio;
    this.talla = talla;
    this.genero = genero;
    this.tipo = tipo;
    this.descripcion = descripcion;
    this.imagen = imagen;
  }
}

class _RopaListPage extends State<RopaListPage> {
  @override
  void initState() {
    obtenerRopa().then((result) {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<RopaInfo> ropa = [];
  bool tallaXSVal = false;
  bool tallaSVal = false;
  bool tallaMVal = false;
  bool tallaLVal = false;
  bool generoHombreVal = false;
  bool generoMujerVal = false;
  bool generoUnisexVal = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    final title = 'Lista de Ropa';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              filtros(),
              Container(
                height: MediaQuery.of(context).size.height - 180,
                color: Color.fromRGBO(255, 255, 255, 1),
                child: grid(itemWidth, itemHeight),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddEditRopaPage(function: "Agregar", idRopa: "");
                },
              ),
            );
          },
          icon: Icon(Icons.add),
          backgroundColor: Colors.blue,
          label: Text('Agregar Ropa'),
        ),
      ),
    );
  }

  filtros() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Talla"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("XS"),
                Checkbox(
                  value: tallaXSVal,
                  onChanged: (bool value) {
                    setState(() {
                      tallaXSVal = value;
                      if (tallaXSVal == false &&
                          tallaSVal == false &&
                          tallaMVal == false &&
                          tallaLVal == false &&
                          generoHombreVal == false &&
                          generoMujerVal == false &&
                          generoUnisexVal == false) {
                        ropa = [];
                        obtenerRopa();
                      } else {
                        obtenerRopaPorTalla("XS");
                      }
                    });
                  },
                ),
                Text("S"),
                Checkbox(
                  value: tallaSVal,
                  onChanged: (bool value) {
                    setState(() {
                      tallaSVal = value;
                      if (tallaXSVal == false &&
                          tallaSVal == false &&
                          tallaMVal == false &&
                          tallaLVal == false &&
                          generoHombreVal == false &&
                          generoMujerVal == false &&
                          generoUnisexVal == false) {
                        ropa = [];
                        obtenerRopa();
                      } else {
                        if (tallaSVal == true) {
                        obtenerRopaPorTalla("S");
                        }else{
                          setState(() {
                          ropa.removeWhere((item) => item.talla == "S");
                        });
                        }
                      }
                    });
                  },
                ),
                Text("M"),
                Checkbox(
                  value: tallaMVal,
                  onChanged: (bool value) {
                    setState(() {
                      tallaMVal = value;
                      if (tallaXSVal == false &&
                          tallaSVal == false &&
                          tallaMVal == false &&
                          tallaLVal == false &&
                          generoHombreVal == false &&
                          generoMujerVal == false &&
                          generoUnisexVal == false) {
                        ropa = [];
                        obtenerRopa();
                      } else {
                        if (tallaMVal == true) {
                        obtenerRopaPorTalla("M");
                        }else{
                          setState(() {
                          ropa.removeWhere((item) => item.talla == "M");
                        });
                        }
                      }
                    });
                  },
                ),
                Text("L"),
                Checkbox(
                  value: tallaLVal,
                  onChanged: (bool value) {
                    setState(() {
                      tallaLVal = value;
                      if (tallaXSVal == false &&
                          tallaSVal == false &&
                          tallaMVal == false &&
                          tallaLVal == false &&
                          generoHombreVal == false &&
                          generoMujerVal == false &&
                          generoUnisexVal == false) {
                        ropa = [];
                        obtenerRopa();
                      } else {
                        if (tallaLVal == true) {
                        obtenerRopaPorTalla("L");
                        }else{
                          setState(() {
                          ropa.removeWhere((item) => item.talla == "L");
                        });
                        }
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Genero"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Hombre"),
                Checkbox(
                  value: generoHombreVal,
                  onChanged: (bool value) {
                    setState(() {
                      generoHombreVal = value;
                      if (tallaXSVal == false &&
                          tallaSVal == false &&
                          tallaMVal == false &&
                          tallaLVal == false &&
                          generoHombreVal == false &&
                          generoMujerVal == false &&
                          generoUnisexVal == false) {
                        ropa = [];
                        obtenerRopa();
                      } else {
                        if (generoHombreVal == true) {
                        obtenerRopaPorGenero("Hombre");
                        }else{
                          setState(() {
                          ropa.removeWhere((item) => item.genero == "Hombre");
                        });
                        }
                      }
                    });
                  },
                ),
                Text("Mujer"),
                Checkbox(
                  value: generoMujerVal,
                  onChanged: (bool value) {
                    setState(() {
                      generoMujerVal = value;
                      if (tallaXSVal == false &&
                          tallaSVal == false &&
                          tallaMVal == false &&
                          tallaLVal == false &&
                          generoHombreVal == false &&
                          generoMujerVal == false &&
                          generoUnisexVal == false) {
                        ropa = [];
                        obtenerRopa();
                      } else {
                        if (generoMujerVal == true) {
                        obtenerRopaPorGenero("Mujer");
                        }else{
                          setState(() {
                          ropa.removeWhere((item) => item.genero == "Mujer");
                        });
                        }
                      }
                    });
                  },
                ),
                Text("Unisex"),
                Checkbox(
                  value: generoUnisexVal,
                  onChanged: (bool value) {
                    setState(() {
                      generoUnisexVal = value;
                      if (tallaXSVal == false &&
                          tallaSVal == false &&
                          tallaMVal == false &&
                          tallaLVal == false &&
                          generoHombreVal == false &&
                          generoMujerVal == false &&
                          generoUnisexVal == false) {
                        ropa = [];
                        obtenerRopa();
                      } else {
                        if (generoUnisexVal == true) {
                        obtenerRopaPorGenero("Unisex");
                        }else{
                          setState(() {
                          ropa.removeWhere((item) => item.genero == "Unisex");
                        });
                        }
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ],
    );
    ;
  }

  grid(itemWidth, itemHeight) {
    if (ropa.length == 0) {
      return Text("No hay ropa para mostrar");
    }
    return Container(
        child: GridView.count(
      childAspectRatio: (itemWidth / itemHeight),
      crossAxisCount: 2,
      children: List.generate(ropa.length, (index) {
        return Center(
            child: Column(
          children: [
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return InfoRopaPage(ropa: ropa[index]);
                    },
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child:
                    Image.network(
                      ropa[index].imagen,
                    ),
                    ),
                    
                    ListTile(
                      title: Text(ropa[index].nombre),
                      subtitle: RichText(
                        text: TextSpan(
                          text: ropa[index].talla,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                          children: <TextSpan>[
                            if (ropa[index].genero == "Hombre")
                              TextSpan(
                                  text: ' ' + ropa[index].genero,
                                  style: TextStyle(color: Color(0xFF0B00A5))),
                            if (ropa[index].genero == "Mujer")
                              TextSpan(
                                  text: ' ' + ropa[index].genero,
                                  style: TextStyle(color: Color(0xFFC53EC5))),
                            TextSpan(
                                text: '\n\$' + ropa[index].precio,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            TextSpan(
                                text: '\n Ver detalles...',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                          ],
                        ),
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
                                      function: "Editar",
                                      idRopa: ropa[index].id);
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
                              _delete(ropa[index].id);
                            });
                          },
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
      }),
    ));
  }

  obtenerRopa() async {
    firestoreInstance.collection("ropas").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          ropa.add(RopaInfo(
              result.id,
              result["nombre"],
              result["talla"],
              result["precio"],
              result["genero"],
              result["tipo"],
              result["descripcion"],
              result["imagen"]));
        });
      });
    });
  }

  obtenerRopaPorTalla(talla) async {
    firestoreInstance
        .collection('ropas')
        .where('talla', isEqualTo: talla)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {


        if (ropa
            .where((item) => result.id.contains(item.id))
            .isEmpty) {
          setState(() {
            ropa.add(RopaInfo(
                result.id,
                result["nombre"],
                result["talla"],
                result["precio"],
                result["genero"],
                result["tipo"],
                result["descripcion"],
                result["imagen"]));
          });
        } else {
          setState(() {
            ropa = [];
            print("borre");
            ropa.add(RopaInfo(
                result.id,
                result["nombre"],
                result["talla"],
                result["precio"],
                result["genero"],
                result["tipo"],
                result["descripcion"],
                result["imagen"]));
          });
        }
      });
    });
  }

  obtenerRopaPorGenero(genero) async {


    firestoreInstance
        .collection('ropas')
        .where('genero', isEqualTo: genero)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {

        if (ropa
            .where((item) => result.id.contains(item.id))
            .isEmpty) {
        setState(() {
          ropa.add(RopaInfo(
              result.id,
              result["nombre"],
              result["talla"],
              result["precio"],
              result["genero"],
              result["tipo"],
              result["descripcion"],
              result["imagen"]));
        });} else {
          setState(() {
            ropa = [];
            print("borre");
            ropa.add(RopaInfo(
                result.id,
                result["nombre"],
                result["talla"],
                result["precio"],
                result["genero"],
                result["tipo"],
                result["descripcion"],
                result["imagen"]));
          });
        }
      });
    });
  }

  _delete(id) {
    firestoreInstance.collection("ropas").doc(id).delete().then((_) {
      print("success!");
      setState(() {
        ropa.removeWhere((item) => item.id == id);
      });
    });
  }
}
