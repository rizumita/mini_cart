import 'cart_item.dart';
import 'product.dart';

// カートを表すドメインモデル
class Cart {
  final Map<String, CartItem> items;
  final double? discountRate; // 割引率（10%なら0.1）

  const Cart({this.items = const {}, this.discountRate});

  // カートに商品を追加するメソッド
  Cart addProduct(Product product) {
    final Map<String, CartItem> newItems = Map.from(items);
    if (newItems.containsKey(product.id)) {
      // 既存の商品の数量を増やす
      newItems[product.id] = newItems[product.id]!.incrementQuantity();
    } else {
      // 新しい商品をカートに追加
      newItems[product.id] = CartItem(product: product, quantity: 1);
    }
    return Cart(items: newItems, discountRate: discountRate);
  }

  // カートから商品を1つ減らす（0になったら削除）
  Cart removeProduct(String productId) {
    if (!items.containsKey(productId)) {
      return this;
    }

    final Map<String, CartItem> newItems = Map.from(items);
    final CartItem item = newItems[productId]!;

    if (item.quantity > 1) {
      // 数量が1より大きい場合は減らす
      try {
        newItems[productId] = item.decrementQuantity();
      } catch (e) {
        // エラー発生時は単に削除
        newItems.remove(productId);
      }
    } else {
      // 数量が1の場合はカートから削除
      newItems.remove(productId);
    }

    return Cart(items: newItems, discountRate: discountRate);
  }

  // カートから商品を完全に削除
  Cart removeItem(String productId) {
    if (!items.containsKey(productId)) {
      return this;
    }

    final Map<String, CartItem> newItems = Map.from(items);
    newItems.remove(productId);
    return Cart(items: newItems, discountRate: discountRate);
  }

  // 割引を適用したカートを作成
  Cart applyDiscount(double rate) {
    return Cart(items: items, discountRate: rate);
  }

  // 割引を削除したカートを作成
  Cart removeDiscount() {
    return Cart(items: items);
  }

  // カート内の合計金額（割引前）
  double get subtotal {
    return items.values.fold(0, (sum, item) => sum + item.subtotal);
  }

  // 最終的な合計金額（割引後）
  double get total {
    final subtotalAmount = subtotal;
    if (discountRate == null) {
      return subtotalAmount;
    }
    // 割引適用後の金額を計算（切り捨て）
    return subtotalAmount * (1 - discountRate!);
  }

  // カート内の商品数
  int get itemCount {
    return items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  // カートが空かどうか
  bool get isEmpty => items.isEmpty;

  // デバッグ用
  @override
  String toString() {
    return 'Cart{items: $items, discountRate: $discountRate, subtotal: $subtotal, total: $total}';
  }
}
