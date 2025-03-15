import 'product.dart';

// カート内の商品アイテムを表すクラス
class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  // 小計を計算するメソッド
  double get subtotal => product.price * quantity;

  // 数量を増やしたインスタンスを作成
  CartItem incrementQuantity() {
    return CartItem(product: product, quantity: quantity + 1);
  }

  // 数量を減らしたインスタンスを作成
  CartItem decrementQuantity() {
    if (quantity <= 1) {
      throw Exception('数量は1未満にできません');
    }
    return CartItem(product: product, quantity: quantity - 1);
  }
}
