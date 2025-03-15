import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/cart.dart';
import '../../domain/models/product.dart';
import '../../domain/services/cart_service.dart';

part 'cart_notifier.g.dart';

/// カートの状態を管理するNotifierクラス
@riverpod
class CartNotifier extends _$CartNotifier {
  late final CartService _cartService;

  @override
  Cart build() {
    _cartService = CartService();
    return const Cart();
  }

  // カートに商品を追加
  void addProduct(Product product) {
    state = _cartService.addProductToCart(state, product);
  }

  // カートから商品を減らす（1つずつ）
  void removeProduct(String productId) {
    state = _cartService.removeProductFromCart(state, productId);
  }

  // カートから商品を完全に削除
  void removeItem(String productId) {
    state = _cartService.removeItemFromCart(state, productId);
  }

  // クーポンコードを適用
  bool applyCouponCode(String code) {
    final newCart = _cartService.applyCouponCode(state, code);
    // カートに変更があった場合は割引が適用されたということ
    final isApplied = newCart.discountRate != state.discountRate;
    state = newCart;
    return isApplied;
  }

  // 割引を削除
  void removeDiscount() {
    state = _cartService.removeDiscount(state);
  }

  // 以下のgetterはcartオブジェクトに直接アクセスして使用するよう修正
  // これらはUIから直接state.itemCountなどとしてアクセスできるようにする

  // カート内の合計金額を取得（割引適用後）
  double getTotalAmount() => _cartService.getTotalAmount(state);

  // カート内の小計を取得（割引適用前）
  double getSubtotalAmount() => _cartService.getSubtotalAmount(state);

  // 割引額を取得
  double getDiscountAmount() => getSubtotalAmount() - getTotalAmount();

  // 割引率を取得（パーセント表示用）
  int? getDiscountPercentage() {
    if (state.discountRate == null) return null;
    return (state.discountRate! * 100).round();
  }
}

// 従来のプロバイダー定義はコード生成によって不要になるため削除
