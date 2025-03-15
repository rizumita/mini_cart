import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/cart_notifier.dart';
import '../../application/state/product_provider.dart';
import '../../domain/models/product.dart';
import '../widgets/cart_badge.dart';
import '../widgets/product_grid_item.dart';

/// 商品一覧画面
class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final cartItemCount = ref.watch(cartNotifierProvider).itemCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ミニカートデモ'),
        actions: [
          // カートアイコン（バッジ付き）
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CartBadge(itemCount: cartItemCount, onPressed: () => context.goNamed('cart')),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductGridItem(
            product: product,
            onTap: () => _navigateToProductDetail(context, product),
            onAddToCart: () => _addToCart(context, ref, product),
          );
        },
      ),
    );
  }

  // 商品詳細画面に遷移
  void _navigateToProductDetail(BuildContext context, Product product) {
    context.goNamed('product-detail', pathParameters: {'productId': product.id});
  }

  // カートに商品を追加
  void _addToCart(BuildContext context, WidgetRef ref, Product product) {
    ref.read(cartNotifierProvider.notifier).addProduct(product);

    // Snackbarで通知
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name}をカートに追加しました'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(label: 'カートを見る', onPressed: () => context.goNamed('cart')),
      ),
    );
  }
}
