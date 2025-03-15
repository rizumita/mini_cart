import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/cart_notifier.dart';
import '../../application/state/product_provider.dart';
import '../widgets/cart_badge.dart';

/// 商品詳細画面
class ProductDetailPage extends ConsumerWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider(productId));
    final cartItemCount = ref.watch(cartNotifierProvider).itemCount;

    // 商品が見つからない場合
    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('商品が見つかりません')),
        body: const Center(child: Text('指定された商品は存在しないか、削除された可能性があります。')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CartBadge(itemCount: cartItemCount, onPressed: () => context.goNamed('cart')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 商品画像
            AspectRatio(
              aspectRatio: 16 / 9,
              child:
                  product.imageUrl != null
                      ? Hero(
                        tag: 'product-image-${product.id}',
                        flightShuttleBuilder: (
                          flightContext,
                          animation,
                          flightDirection,
                          fromHeroContext,
                          toHeroContext,
                        ) {
                          return Material(
                            color: Colors.transparent,
                            child: CachedNetworkImage(imageUrl: product.imageUrl!, fit: BoxFit.cover),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl!,
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 100),
                          placeholder:
                              (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(child: CircularProgressIndicator()),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                                ),
                              ),
                        ),
                      )
                      : Container(
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                      ),
            ),
            // 商品情報
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 商品名
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // 価格
                  Text(
                    '¥${product.price.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 説明
                  Text(product.description, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 32),
                  // カートに追加ボタン
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(context, ref, product.id),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text('カートに追加する'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final product = ref.read(productProvider(productId));
          if (product != null) {
            ref.read(cartNotifierProvider.notifier).addProduct(product);
          }
        },
        label: const Text('カートに追加'),
      ),
    );
  }

  // カートに商品を追加
  void _addToCart(BuildContext context, WidgetRef ref, String productId) {
    final product = ref.read(productProvider(productId));
    if (product == null) return;

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
