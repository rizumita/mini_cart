import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/models/product.dart';

/// 商品一覧画面でのグリッドアイテム表示ウィジェット
class ProductGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductGridItem({super.key, required this.product, required this.onTap, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 商品画像
            AspectRatio(
              aspectRatio: 1,
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
            // 商品情報（名前、価格）
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '¥${product.price.toStringAsFixed(0)}',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // カートに追加ボタン - 固定高さに変更
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                  child: const Text('カートに追加'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
