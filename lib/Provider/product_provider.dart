import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/product_model.dart';

class ProductsProvider with ChangeNotifier {
  final List<ProductModel> _products = [];

  List<ProductModel> get getProducts => List.unmodifiable(_products);

  ProductModel? findByProdId(String productId) {
    try {
      return _products.firstWhere((element) => element.productId == productId);
    } catch (_) {
      return null;
    }
  }

  List<ProductModel> findByCategory({required String categoryName}) {
    return _products
        .where(
          (element) => element.productCategory
          .toLowerCase()
          .contains(categoryName.toLowerCase()),
    )
        .toList();
  }

  List<ProductModel> searchQuery({
    required String searchText,
    required List<ProductModel> passedList,
  }) {
    return passedList
        .where(
          (element) => element.productTitle
          .toLowerCase()
          .contains(searchText.toLowerCase()),
    )
        .toList();
  }

  // 🔧 Firestore reference
  final CollectionReference<Map<String, dynamic>> _productRef =
  FirebaseFirestore.instance.collection("products");

  // 🔄 Fetch from Firestore
  Future<void> fetchProducts() async {
    try {
      final snapshot = await _productRef.get();

      _products
        ..clear()
        ..addAll(
          snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList(),
        );

      notifyListeners();
    } catch (e, s) {
      debugPrint("fetchProducts error: $e\n$s");
      rethrow;
    }
  }
}
