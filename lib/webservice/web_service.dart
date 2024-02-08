import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce/models/category.dart';
import 'package:cyra_ecommerce/models/order.dart';
import 'package:cyra_ecommerce/models/product.dart';
import 'package:cyra_ecommerce/models/user.dart';
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

  Future<List<ProductModel>> fetchCategoryProduct(int catId) async {
    try {
      final response = await http.post(
        Uri.parse(Apis.getCategoryProducts),
        body: {"catid": catId.toString()},
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
      log('Error fetching Category products: $e');
      return [];
    }
  }

  Future<List<OrderModel>> fetchOrderDetails(String username) async {
    try {
      final response = await http.post(
        Uri.parse(Apis.getOrderDetails),
        body: {"username": username},
      );
      if (response.statusCode == 200) {
        final productJson = json.decode(response.body);
        return productJson
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        log('API request failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching Order products: $e');
      return [];
    }
  }

  Future<UserModel> fetchUser(String username) async {
    try {
      final response = await http.post(
        Uri.parse(Apis.getUser),
        body: {"username": username},
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching User details: $e');
    }
  }
}
