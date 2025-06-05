import 'package:ecommarceproject/services/my_app_function.dart';
import 'package:ecommarceproject/widgets/app_name.dart';
import 'package:ecommarceproject/widgets/subtitle_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../Provider/theam_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/title_text.dart';
import 'auth/login.dart';
import 'inner_screen/order/order_screen.dart';
import 'inner_screen/viewed_recently.dart';
import 'inner_screen/wishlist.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<TheamProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.shoppingCart,
          ),
        ),
        title: const AppNameText(fontSize: 20),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: TitlesTextWidget(
                  label: "Please login to have unlimited access",
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.background,
                            width: 3),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitlesTextWidget(label: "Hadi Kachmar"),
                        SizedBox(
                          height: 6,
                        ),
                        subtitlewidgets(label: "Coding.with.hadi@gmail.com")
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitlesTextWidget(
                    label: "General",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomListTile(
                    text: "All Order",
                    imagePath: AssetsManager.orderSvg,
                    function: () {
                      Navigator.pushNamed(
                        context,
                        OrdersScreenFree.routeName,
                      );
                    },
                  ),
                  CustomListTile(
                    text: "Wishlist",
                    imagePath: AssetsManager.wishlistSvg,
                    function: () {
                      Navigator.pushNamed(context, WishlistScreen.routName);
                    },
                  ),
                  CustomListTile(
                    text: "Viewed recently",
                    imagePath: AssetsManager.recent,
                    function: () {
                      Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routName);
                    },
                  ),
                  CustomListTile(
                    text: "Address",
                    imagePath: AssetsManager.address,
                    function: () {},
                  ),
                  const SizedBox(height: 6),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 6),
                  const TitlesTextWidget(
                    label: "Settings",
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    secondary: Image.asset(
                      AssetsManager.theme,
                      height: 34,
                    ),
                    title: Text(themeProvider.getIsDarkTheme
                        ? "Dark Mode"
                        : "Light Mode"),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                  ),
                ),
                icon: Icon(user == null ? Icons.login : Icons.logout),
                label: Text(user == null ? "Login" : "Logout"),
                onPressed: () async {
                  if (user == null) {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  } else {
                    await MyappFunction.showErrorOrWarningDialog(
                      context: context,
                      subtitle: "Are you sure you want to signout",
                      fct: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      isError: false,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: subtitlewidgets(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
