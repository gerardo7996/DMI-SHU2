import 'package:ecoti_app_mobile/mvc/model/model.dart';
import 'package:ecoti_app_mobile/mvc/view/page_inicio.dart';
import 'package:flutter/material.dart';
import '/mvc/controller/controller.dart';

import '/mvc/controller/producto_service.dart';
import '/mvc/model/producto_model.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageProductos extends StatefulWidget {
  const PageProductos({super.key});

  @override
  State<PageProductos> createState() => _PageProductosState();
}

class _PageProductosState extends State<PageProductos> {
  @override
  Widget build(BuildContext context) {
    final UserModel? currentUser = AuthService().currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 125, 34, 1),
        centerTitle: false, // Centra el título en la AppBar
        title: const Text("Productos"),
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
      body: ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  final productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching products'));
        } else {
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.body),
                ),
              );
            },
          );
        }
      },
    );
  }
}
