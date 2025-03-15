// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsHash() => r'e6d5f31caf43e53dffc274dab4e80d1e0e8d7dd7';

/// 全商品リストを提供するプロバイダー
///
/// Copied from [products].
@ProviderFor(products)
final productsProvider = AutoDisposeProvider<List<Product>>.internal(
  products,
  name: r'productsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsRef = AutoDisposeProviderRef<List<Product>>;
String _$productHash() => r'bab657cfe936e490aa10337c6268181c99c93363';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 特定IDの商品を提供するプロバイダー
///
/// Copied from [product].
@ProviderFor(product)
const productProvider = ProductFamily();

/// 特定IDの商品を提供するプロバイダー
///
/// Copied from [product].
class ProductFamily extends Family<Product?> {
  /// 特定IDの商品を提供するプロバイダー
  ///
  /// Copied from [product].
  const ProductFamily();

  /// 特定IDの商品を提供するプロバイダー
  ///
  /// Copied from [product].
  ProductProvider call(String productId) {
    return ProductProvider(productId);
  }

  @override
  ProductProvider getProviderOverride(covariant ProductProvider provider) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productProvider';
}

/// 特定IDの商品を提供するプロバイダー
///
/// Copied from [product].
class ProductProvider extends AutoDisposeProvider<Product?> {
  /// 特定IDの商品を提供するプロバイダー
  ///
  /// Copied from [product].
  ProductProvider(String productId)
    : this._internal(
        (ref) => product(ref as ProductRef, productId),
        from: productProvider,
        name: r'productProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productHash,
        dependencies: ProductFamily._dependencies,
        allTransitiveDependencies: ProductFamily._allTransitiveDependencies,
        productId: productId,
      );

  ProductProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(Product? Function(ProductRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: ProductProvider._internal(
        (ref) => create(ref as ProductRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Product?> createElement() {
    return _ProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductRef on AutoDisposeProviderRef<Product?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductProviderElement extends AutoDisposeProviderElement<Product?>
    with ProductRef {
  _ProductProviderElement(super.provider);

  @override
  String get productId => (origin as ProductProvider).productId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
