import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryc_shop/models/product.dart';
import 'package:ryc_shop/components/product_grid_item.dart';
import 'package:ryc_shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    List<Product> listProduct = provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: listProduct.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: listProduct[index],
        child: const ProductGridItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}