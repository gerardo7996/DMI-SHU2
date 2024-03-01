// controllers/product_controller.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecoti_app_mobile/mvc/model/producto_model.dart';

class ProductController {
  final String apiUrl =
      'https://api.mercadolibre.com/sites/MLA/search?q=biodegradables&limit=50';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data
          .map((product) => Product(
                id: product['id'],
                title: product['title'],
                price: product['price'].toDouble(),
                imageUrl: product['thumbnail'],
              ))
          .toList();
    } else {
      throw Exception('Error fetching products');
    }
  }
}
