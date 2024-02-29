import 'package:ecoti_app_mobile/mvc/model/model.dart';
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
    final UserModel? currentUser = AuthService().currentUser;

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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ProductList(),
      ),
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
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching products'));
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
