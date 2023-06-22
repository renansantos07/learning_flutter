import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryc_shop/models/cart.dart';
import 'package:ryc_shop/models/order_list.dart';
import 'package:ryc_shop/models/product_list.dart';
import 'package:ryc_shop/pages/cart_page.dart';
import 'package:ryc_shop/pages/order_page.dart';
import 'package:ryc_shop/pages/product_detail_page.dart';
import 'package:ryc_shop/pages/product_form_page.dart';
import 'package:ryc_shop/pages/product_overview_page.dart';
import 'package:ryc_shop/pages/products_page.dart';
import 'package:ryc_shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(108, 206, 242, 1),
            secondary: const Color.fromRGBO(154, 172, 245, 1),
          ),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.home: (ctx) => const ProductOverviewPage(),
          AppRoutes.productDetail: (context) => const ProductDetailPage(),
          AppRoutes.cart: (context) => const CartPage(),
          AppRoutes.orders: (context) => const OrdersPage(),
          AppRoutes.products: (context) => const ProductsPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
