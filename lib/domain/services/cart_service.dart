import '../models/cart.dart';
import '../models/product.dart';

/// カートに関するドメインロジックを扱うサービスクラス
class CartService {
  // クーポンコードと割引率のマッピング
  static const Map<String, double> _couponCodes = {
    'DISCOUNT10': 0.1, // 10%割引
  };

  // クーポンコードが有効かチェックし、有効なら割引率を返す
  double? validateCouponCode(String code) {
    // 大文字・小文字を区別しないために大文字に変換
    final upperCode = code.toUpperCase();
    return _couponCodes[upperCode];
  }

  // カートに商品を追加
  Cart addProductToCart(Cart cart, Product product) {
    return cart.addProduct(product);
  }

  // カートから商品を削除（数量を1つ減らす）
  Cart removeProductFromCart(Cart cart, String productId) {
    return cart.removeProduct(productId);
  }

  // 商品をカートから完全に削除
  Cart removeItemFromCart(Cart cart, String productId) {
    return cart.removeItem(productId);
  }

  // クーポンコードを適用
  Cart applyCouponCode(Cart cart, String code) {
    final discountRate = validateCouponCode(code);
    if (discountRate != null) {
      return cart.applyDiscount(discountRate);
    }
    return cart;
  }

  // 割引を削除
  Cart removeDiscount(Cart cart) {
    return cart.removeDiscount();
  }

  // カートの合計金額を取得（割引適用後）
  double getTotalAmount(Cart cart) {
    return cart.total;
  }

  // カートの小計を取得（割引適用前）
  double getSubtotalAmount(Cart cart) {
    return cart.subtotal;
  }
}
