import 'package:flutter/material.dart';

import '../../domain/models/cart_item.dart';

/// カート内のアイテムを表示するウィジェット
class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 商品画像
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 80,
                height: 80,
                child:
                    cartItem.product.imageUrl != null
                        ? Image.network(
                          cartItem.product.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
                            );
                          },
                        )
                        : Container(
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.image, color: Colors.grey)),
                        ),
              ),
            ),
            const SizedBox(width: 16),
            // 商品情報
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    '¥${cartItem.product.price.toStringAsFixed(0)}',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // 数量調整と削除ボタン
                  Row(
                    children: [
                      // 数量調整
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            // 数量減少ボタン
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: onDecrement,
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              padding: EdgeInsets.zero,
                            ),
                            // 現在の数量
                            SizedBox(
                              width: 30,
                              child: Text(
                                '${cartItem.quantity}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            // 数量増加ボタン
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: onIncrement,
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // 小計
                      Text(
                        '小計: ¥${cartItem.subtotal.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // 削除ボタン
                      IconButton(icon: const Icon(Icons.delete_outline), onPressed: onRemove, color: Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
