import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryc_shop/models/auth_notifier.dart';
import 'package:ryc_shop/models/cart.dart';
import 'package:ryc_shop/models/order_list.dart';
import 'package:ryc_shop/models/product_list.dart';
import 'package:ryc_shop/pages/auth_or%20home_page.dart';
import 'package:ryc_shop/pages/cart_page.dart';
import 'package:ryc_shop/pages/order_page.dart';
import 'package:ryc_shop/pages/product_detail_page.dart';
import 'package:ryc_shop/pages/product_form_page.dart';
import 'package:ryc_shop/pages/product_overview_page.dart';
import 'package:ryc_shop/pages/products_page.dart';
import 'package:ryc_shop/utils/app_routes.dart';
import 'dart:io';

import 'package:ryc_shop/utils/custom_route.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (context, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color.fromRGBO(108, 206, 242, 1),
              secondary: const Color.fromRGBO(154, 172, 245, 1),
            ),
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionsBuilder(),
              TargetPlatform.iOS: CustomPageTransitionsBuilder(),
            })),
        routes: {
          AppRoutes.authOrHome: (ctx) => const AuthOrHomePage(),
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
