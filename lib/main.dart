import 'package:ecommarceproject/Provider/theam_provider.dart';
import 'package:ecommarceproject/root_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/ViewedProdModel_provider.dart';
import 'Provider/cart_provider.dart';
import 'Provider/product_provider.dart';
import 'Provider/user_provider.dart';
import 'Provider/wish_list.dart';
import 'Screens/SearchScreen.dart';
import 'Screens/auth/registration.dart';
import 'Screens/inner_screen/order/order_screen.dart';
import 'Screens/inner_screen/product_details.dart';
import 'Screens/inner_screen/viewed_recently.dart';
import 'constant/theamdata.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/login.dart';
import 'screens/inner_screen/wishlist.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return TheamProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return ProductsProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CartProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return WishlistProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return ViewedProdProvider();
          },
        ),
        ChangeNotifierProvider(create: (_) {
          return UserProvider();
        }),
      ],
      child: Consumer<TheamProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ShopSmart EN',
            theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme,
              context: context,
            ),
            home: const RootScreen(),
            //home: const LoginScreen(),
            routes: {
              RootScreen.routeName: (context) => const RootScreen(),
              ProductDetailsScreen.routName:
                  (context) => const ProductDetailsScreen(),
              WishlistScreen.routName: (context) => const WishlistScreen(),
              ViewedRecentlyScreen.routName:
                  (context) => const ViewedRecentlyScreen(),
              RegisterScreen.routName: (context) => const RegisterScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              OrdersScreenFree.routeName: (context) => const OrdersScreenFree(),
              ForgotPasswordScreen.routeName:
                  (context) => const ForgotPasswordScreen(),
              SearchScreen.routeName: (context) => const SearchScreen(),
            },
          );
        },
      ),
    );
  }
}
