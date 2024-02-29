import 'package:ecoti_app_mobile/mvc/model/model.dart';
import 'package:ecoti_app_mobile/mvc/view/page_productos.dart';
import 'package:flutter/material.dart';
import '/mvc/controller/controller.dart';
import '/mvc/view/my_home_page.dart';

import '/mvc/controller/producto_service.dart';
import '/mvc/model/producto_model.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageInicio extends StatefulWidget {
  const PageInicio({super.key});

  @override
  State<PageInicio> createState() => _PageInicioState();
}

class _PageInicioState extends State<PageInicio> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final UserModel? currentUser = AuthService().currentUser;

    String user = '';
    String peso = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 125, 34, 1),
        centerTitle: false, // Centra el título en la AppBar
        title: currentUser != null
            ? Text('${currentUser.email}')
            : const Text('User Invalid'),
        titleTextStyle: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 15,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await AuthService().signOutUser();

                Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
              },
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 4, 125, 4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Ajusta los bordes del botón
              ),
            ), // foreground
            onPressed: () {
              Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PageProductos()));
            },
            child: const Text('Catalogo de Productos'),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Usuario',
                      border: OutlineInputBorder(), // Bordes del campo de texto
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Porfavor Ingrese un Usuario';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      user = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.scale),
                      hintText: 'Usuario',
                      border: OutlineInputBorder(), // Bordes del campo de texto
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Porfavor Ingrese una Cantidad';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      peso = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 125, 4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Ajusta los bordes del botón
                        ),
                      ),
                      onPressed: () async {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (formKey.currentState!.validate()) {
                          // Llamada a la función signUpUser del AuthService
                          _showAlert('Dato Introducido', user + peso);
                        }
                      },
                      child: const Text('Ingresar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
