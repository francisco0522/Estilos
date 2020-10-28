import 'package:estilos/addEditRopa.dart';
import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';
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
  List<String> countList = [];
  List<String> selectedCountList = [];

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
            child: Container(
          color: Color.fromRGBO(255, 255, 255, 1),
          child: grid(itemWidth, itemHeight),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddEditRopaPage(function: "Agregar", idRopa: "");
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
                    Image.network(
                      ropa[index].imagen,
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
        countList.add(result.data().toString());
        print(countList);
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

   void _openFilterDialog() async {
    await FilterListDialog.display(
      context,
      allTextList: countList,
      height: 480,
      borderRadius: 20,
      headlineText: "Select Count",
      searchFieldHintText: "Search Here",
      selectedTextList: selectedCountList,
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            selectedCountList = List.from(list);
          });
        }
        Navigator.pop(context);
      });
  }
}
