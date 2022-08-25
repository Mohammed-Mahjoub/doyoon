import 'package:doyoon/database/db_controller.dart';
import 'package:doyoon/provider/orders_provider.dart';
import 'package:doyoon/provider/products_provider.dart';
import 'package:doyoon/provider/users_provider.dart';
import 'package:doyoon/screens/add_product_screen.dart';
import 'package:doyoon/screens/home_screen.dart';
import 'package:doyoon/screens/launch_screen.dart';
import 'package:doyoon/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbController().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(create: (context) => ProductsProvider()),
        ChangeNotifierProvider<UsersProvider>(create: (context) => UsersProvider()),
        ChangeNotifierProvider<OrdersProvider>(create: (context) => OrdersProvider()),
      ],
      builder: (context,widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale: const Locale('ar'),
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/home_screen': (context) => const HomeScreen(),
            '/add_product_screen': (context) => const AddProductsScreen(),
            '/products_screen': (context) => const ProductsScreen(),
          },
        );
      } ,
    );
  }
}
