import 'package:flutter/material.dart';
import '/mvc/controller/controller.dart';
import '/mvc/view/my_home_page.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageInicio extends StatefulWidget {
  const PageInicio({super.key});

  @override
  State<PageInicio> createState() => _PageInicioState();
}

class _PageInicioState extends State<PageInicio> {
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
      body: const Text("Bienvenido"),
    );
  }
}

Widget body() {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                "https://i.pinimg.com/564x/09/9a/1c/099a1c08e39ee555cc6a14d75a76bd83.jpg"),
            fit: BoxFit.cover)),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          title(),
          Container(
              padding: const EdgeInsets.all(40.0), child: const FormExample()),
        ],
      ),
    ),
  );
}

Widget title() {
  return const Text(
    "Inicio",
    style: TextStyle(
        color: Colors.black, fontSize: 35.0, fontWeight: FontWeight.bold),
  );
}
