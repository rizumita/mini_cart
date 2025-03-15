// 商品を表すドメインモデル
class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String? imageUrl;

  const Product({required this.id, required this.name, required this.price, required this.description, this.imageUrl});

  // デバッグ用
  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, description: $description, imageUrl: $imageUrl}';
  }
}
