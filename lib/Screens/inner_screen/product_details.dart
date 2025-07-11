import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/cart_provider.dart';
import '../../Provider/product_provider.dart';
import '../../widgets/Product/heart_btn.dart';
import '../../widgets/app_name.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routName = "/ProductDetailsScreen";
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrProduct = productsProvider.findByProdId(productId!);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Navigator.canPop(context) ? Navigator.pop(context) : null;
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        // automaticallyImplyLeading: false,
        title: const AppNameText(fontSize: 20),
      ),
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: getCurrProduct.productImage,
              height: size.height * 0.38,
              width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          getCurrProduct.productTitle,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      subtitlewidgets(
                        label: "${getCurrProduct.productPrice}\$",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeartButtonWidget(
                          bkgColor: Colors.blue.shade100,
                          productId: getCurrProduct.productId,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30.0,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (cartProvider.isProdinCart(
                                    productId:
                                    getCurrProduct.productId)) {
                                  return;
                                }
                                cartProvider.addProductToCart(
                                    productId: getCurrProduct.productId);
                              },
                              icon: Icon(
                                cartProvider.isProdinCart(
                                    productId:
                                    getCurrProduct.productId)
                                    ? Icons.check
                                    : Icons.add_shopping_cart_outlined,
                              ),
                              label: Text(cartProvider.isProdinCart(
                                  productId: getCurrProduct.productId)
                                  ? "In cart"
                                  : "Add to cart"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitlesTextWidget(label: "About this item"),
                      subtitlewidgets(
                          label: "In ${getCurrProduct.productCategory}"),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  subtitlewidgets(
                    label: getCurrProduct.productDescription,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
