import '../models/product.dart';

/// 商品データの取得を担当するリポジトリクラス
/// 実際のアプリではAPIやDBから取得するが、ここではサンプルデータを返す
class ProductRepository {
  // サンプル商品リスト
  static final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'ハイクオリティTシャツ',
      price: 2500,
      description: '着心地の良い高品質なTシャツです。様々な場面で活躍する定番アイテム。',
      imageUrl: 'https://picsum.photos/seed/tshirt123/400/400',
    ),
    Product(
      id: 'p2',
      name: 'デニムジーンズ',
      price: 5800,
      description: '丈夫で長く愛用できるデニムパンツ。カジュアルからきれいめまで幅広いスタイルに対応。',
      imageUrl: 'https://picsum.photos/seed/jeans456/400/400',
    ),
    Product(
      id: 'p3',
      name: 'スニーカー',
      price: 7200,
      description: 'スポーティでありながらファッション性も高い万能スニーカー。クッション性に優れた履き心地。',
      imageUrl: 'https://picsum.photos/seed/sneakers789/400/400',
    ),
    Product(
      id: 'p4',
      name: 'トートバッグ',
      price: 3200,
      description: '収納力抜群のキャンバストートバッグ。デイリーユースにぴったりの実用的なデザイン。',
      imageUrl: 'https://picsum.photos/seed/totebag012/400/400',
    ),
    Product(
      id: 'p5',
      name: 'サングラス',
      price: 9800,
      description: 'UV加工を施した高級サングラス。スタイリッシュなフレームデザインでどんな服装にも合います。',
      imageUrl: 'https://picsum.photos/seed/sunglasses345/400/400',
    ),
  ];

  // 全ての商品を取得
  List<Product> getAllProducts() {
    return List.from(_products);
  }

  // IDで商品を検索
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
