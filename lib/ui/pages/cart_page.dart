import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/state/cart_notifier.dart';
import '../widgets/cart_item_tile.dart';

/// カート画面
class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final _couponController = TextEditingController();
  bool _isCouponApplied = false;
  bool _isCouponInvalid = false;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final subtotal = cartNotifier.getSubtotalAmount();
    final total = cartNotifier.getTotalAmount();
    final discountPercentage = cartNotifier.getDiscountPercentage();

    return Scaffold(
      appBar: AppBar(title: const Text('カート')),
      body:
          cart.isEmpty
              ? _buildEmptyCart()
              : Column(
                children: [
                  // カートアイテムのリスト
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final cartItem = cart.items.values.elementAt(index);
                        return CartItemTile(
                          cartItem: cartItem,
                          onIncrement: () {
                            cartNotifier.addProduct(cartItem.product);
                          },
                          onDecrement: () {
                            cartNotifier.removeProduct(cartItem.product.id);
                          },
                          onRemove: () {
                            cartNotifier.removeItem(cartItem.product.id);
                          },
                        );
                      },
                    ),
                  ),
                  // クーポンとサマリー
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withAlpha(77), blurRadius: 5, offset: const Offset(0, -2)),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // クーポン入力欄
                        TextField(
                          controller: _couponController,
                          decoration: InputDecoration(
                            labelText: 'クーポンコード',
                            hintText: '例: DISCOUNT10',
                            errorText: _isCouponInvalid ? '無効なクーポンコードです' : null,
                            border: const OutlineInputBorder(),
                            suffixIcon: TextButton(
                              onPressed: _isCouponApplied ? _removeCoupon : _applyCoupon,
                              child: Text(_isCouponApplied ? '削除' : '適用'),
                            ),
                          ),
                          enabled: !_isCouponApplied,
                        ),
                        const SizedBox(height: 16),
                        // 価格サマリー
                        _buildPriceSummary(subtotal, total, discountPercentage),
                        const SizedBox(height: 16),
                        // 注文ボタン（この実装では機能しないデモ用）
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // 注文確定処理（デモのため未実装）
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(const SnackBar(content: Text('この機能はデモ版では利用できません')));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('注文する'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }

  // 空のカート表示
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('カートは空です', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('商品をカートに追加してください'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('商品一覧に戻る'),
          ),
        ],
      ),
    );
  }

  // 価格サマリー表示
  Widget _buildPriceSummary(double subtotal, double total, int? discountPercentage) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text('小計:'), Text('¥${subtotal.toStringAsFixed(0)}')],
        ),
        if (discountPercentage != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('割引 ($discountPercentage%):'),
              Text('-¥${(subtotal - total).toStringAsFixed(0)}', style: const TextStyle(color: Colors.red)),
            ],
          ),
        ],
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('合計:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('¥${total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  // クーポンを適用
  void _applyCoupon() {
    final code = _couponController.text.trim();
    if (code.isEmpty) return;

    final isApplied = ref.read(cartNotifierProvider.notifier).applyCouponCode(code);
    setState(() {
      _isCouponApplied = isApplied;
      _isCouponInvalid = !isApplied;
    });

    if (isApplied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('クーポンが適用されました')));
    }
  }

  // クーポンを削除
  void _removeCoupon() {
    ref.read(cartNotifierProvider.notifier).removeDiscount();
    setState(() {
      _isCouponApplied = false;
      _isCouponInvalid = false;
      _couponController.clear();
    });
  }
}
