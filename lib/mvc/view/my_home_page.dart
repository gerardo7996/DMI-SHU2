import 'package:flutter/material.dart';
import '/mvc/controller/controller.dart';
import '/mvc/view/page_registro.dart';
import '/mvc/view/page_inicio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 125, 34, 1),
        centerTitle: false, // Centra el título en la AppBar
        title: const Text(
          'EcoTI Mobile',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cuerpo(),
    );
  }
}

Widget cuerpo() {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                "https://i.pinimg.com/736x/c7/8d/82/c78d821fbb0a38da9e299eb92e2b8fe4.jpg"),
            fit: BoxFit.cover)),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          titulo(),
          Container(
              padding: const EdgeInsets.all(40.0), child: const FormExample()),
        ],
      ),
    ),
  );
}

Widget titulo() {
  return const Text(
    "Iniciar Sesión",
    style: TextStyle(
        color: Colors.black, fontSize: 35.0, fontWeight: FontWeight.bold),
  );
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Correo Electronico',
              border: OutlineInputBorder(), // Bordes del campo de texto
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor Ingrese su Correo';
              }
              return null;
            },
            onChanged: (value) {
              _email = value;
            },
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.key),
              hintText: 'Contraseña',
              border: OutlineInputBorder(), // Bordes del campo de texto
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor Ingrese su Contraseña';
              }
              return null;
            },
            onChanged: (value) {
              _password = value;
            },
          ),
          const SizedBox(
            height: 15,
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
                if (_formKey.currentState!.validate()) {
                  // Llamada a la función signUpUser del AuthService
                  final authService = AuthService();
                  final user = await authService.signInUser(_email, _password);

                  // Verificación del usuario y acciones adicionales si es necesario
                  if (user != null) {
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PageInicio()),
                    );
                    // Usuario autenticado con éxito
                    //_showAlert('Éxito', 'Usuario autenticado con éxito: ${user.id}');
                  } else {
                    // Manejar el caso en el que la autenticación falla
                    _showAlert(
                        'Error de Autentificación', 'Credenciales Invalidas');
                  }
                }
              },
              child: const Text('Ingresar'),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        1.0), // Ajusta los bordes del botón
                  ),
                ),
                child: const Text("Crear Cuenta"),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PageRegistro()));
                }),
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
