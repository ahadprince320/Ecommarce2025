import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/wish_list.dart';
import '../../services/assets_manager.dart';
import '../../services/my_app_function.dart';
import '../../widgets/Product/product_widgets.dart';
import '../../widgets/empty_bag.dart';
import '../../widgets/title_text.dart';

class WishlistScreen extends StatelessWidget {
  static const routName = "/WishlistScreen";
  const WishlistScreen({super.key});
  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return wishlistProvider.getWishlists.isEmpty
        ? Scaffold(
      body: EmptyBagWidget(
        imagePath: AssetsManager.bagWish,
        title: "Nothing in ur wishlist yet",
        subtitle:
        "Looks like your cart is empty add something and make me happy",
        buttonText: "Shop now",
      ),
    )
        : Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.shoppingCart,
          ),
        ),
        title: TitlesTextWidget(
            label: "Wishlist (${wishlistProvider.getWishlists.length})"),
        actions: [
          IconButton(
            onPressed: () {
              MyappFunction.showErrorOrWarningDialog(
                isError: false,
                context: context,
                subtitle: "Clear cart?",
                fct: () {
                  wishlistProvider.clearLocalWishlist();
                },
              );
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: DynamicHeightGridView(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        builder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductWidget(
              productId: wishlistProvider.getWishlists.values
                  .toList()[index]
                  .productId,
            ),
          );
        },
        itemCount: wishlistProvider.getWishlists.length,
        crossAxisCount: 2,
      ),
    );
  }
}
