import 'dart:convert';
import 'package:http/http.dart' as http;
import '/mvc/model/producto_model.dart';

class ProductService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching products');
    }
  }
}
