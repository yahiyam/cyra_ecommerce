import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce/models/category.dart';
import 'package:cyra_ecommerce/models/product.dart';
import 'package:cyra_ecommerce/webservice/apis.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<List<CategoryModel>> fetchCategory() async {
    try {
      final response = await http.get(
        Uri.parse(Apis.getCategories),
      );
      if (response.statusCode == 200) {
        final categoriesJson = json.decode(response.body);
        return categoriesJson
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        log('API request failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<ProductModel>> fetchOfferProduct() async {
    try {
      final response = await http.get(
        Uri.parse(Apis.viewOfferproducts),
      );
      if (response.statusCode == 200) {
        final productJson = json.decode(response.body);
        return productJson
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        log('API request failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching offer products: $e');
      return [];
    }
  }
}
