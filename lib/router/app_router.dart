import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/pages/cart_page.dart';
import '../ui/pages/product_detail_page.dart';
import '../ui/pages/product_list_page.dart';

/// アプリケーションのルーティング設定
final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    // 商品一覧画面（メイン画面）
    GoRoute(
      path: '/',
      name: 'product-list',
      builder: (context, state) => const ProductListPage(),
      // サブルート
      routes: [
        // 商品詳細画面
        GoRoute(
          path: 'products/:productId',
          name: 'product-detail',
          builder: (context, state) {
            final productId = state.pathParameters['productId'] ?? '';
            return ProductDetailPage(productId: productId);
          },
        ),
        // カート画面
        GoRoute(path: 'cart', name: 'cart', builder: (context, state) => const CartPage()),
      ],
    ),
  ],
  // エラー画面
  errorBuilder:
      (context, state) =>
          Scaffold(appBar: AppBar(title: const Text('エラー')), body: Center(child: Text('ページが見つかりません: ${state.uri}'))),
);
