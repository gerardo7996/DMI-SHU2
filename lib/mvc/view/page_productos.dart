import 'package:ecoti_app_mobile/mvc/controller/producto_service.dart';
import 'package:ecoti_app_mobile/mvc/model/producto_model.dart';
import 'package:ecoti_app_mobile/mvc/view/page_inicio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa el paquete intl

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController _productController = ProductController();
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = _productController.fetchProducts();
  }

  String formatPrice(double price) {
    final formatter = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 125, 34, 1),
        centerTitle: false, // Centra el título en la AppBar
        title: const Text("Registros"),
        titleTextStyle: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontSize: 15,
          fontWeight: FontWeight.bold,
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
      body: FutureBuilder<List<Product>>(
        future: _products,
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
                return ListTile(
                  title: Text(product.title),
                  subtitle:
                      Text(formatPrice(product.price)), // Formatea el precio
                  leading: Image.network(product.imageUrl),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: ProductListScreen()));
}
