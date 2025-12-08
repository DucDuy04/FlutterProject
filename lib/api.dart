import 'package:dio/dio.dart';
import 'package:flutter_nhom6/model/product.dart';

class API {
  Future<List<Product>> getAllProduct() async {
    var dio = Dio();
    var response = await dio.request('https://fakestoreapi.com/products');
    List<Product> listsProduct = [];
    if (response.statusCode == 200) {
      List ls = response.data;
      listsProduct = ls.map((json) => Product.fromJson(json)).toList();
    } else {
      print("Loi roi");
    }
    return listsProduct;
  }
}

var test_api = API();
