import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/product.dart';
import '../../domain/services/product_repository.dart';

part 'product_provider.g.dart';

/// 全商品リストを提供するプロバイダー
@riverpod
List<Product> products(Ref ref) {
  final repository = ProductRepository();
  return repository.getAllProducts();
}

/// 特定IDの商品を提供するプロバイダー
@riverpod
Product? product(Ref ref, String productId) {
  final repository = ProductRepository();
  return repository.getProductById(productId);
}
