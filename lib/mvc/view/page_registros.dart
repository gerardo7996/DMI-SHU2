import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoti_app_mobile/mvc/model/model.dart';
import 'package:ecoti_app_mobile/mvc/view/page_inicio.dart';
import 'package:flutter/material.dart';
import '/mvc/controller/controller.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageRegistros extends StatefulWidget {
  const PageRegistros({super.key});

  @override
  State<PageRegistros> createState() => _PageRegistrosState();
}

class _PageRegistrosState extends State<PageRegistros> {
  @override
  Widget build(BuildContext context) {
    final UserModel? currentUser = AuthService().currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 125, 34, 1),
        centerTitle: false, // Centra el título en la AppBar
        title: const Text("Registros"),
        titleTextStyle: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 15,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PageInicio()));
              },
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('registros').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black,
                    ),
                    child: ListTile(
                      title: Text(user['user'],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 29, 198, 105))),
                      subtitle: Text(user['peso'],
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
