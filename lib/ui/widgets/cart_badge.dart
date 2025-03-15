import 'package:flutter/material.dart';

/// カートアイコンにバッジを表示するウィジェット
class CartBadge extends StatelessWidget {
  final int itemCount;
  final VoidCallback onPressed;

  const CartBadge({super.key, required this.itemCount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(icon: const Icon(Icons.shopping_cart), onPressed: onPressed),
        if (itemCount > 0)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                itemCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
