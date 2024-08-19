import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moonlit/screens/user_profile_Page/user_profile_page.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../provider/favorite_provider.dart';
import 'store_cart.dart';
import 'store_favorite.dart';
import 'store_home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 1;
  List screens = const [
    Scaffold(),
    StoreHome(),
    StoreCart(),
    Favorite(),
    UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    var iconColor = Colors.grey[700];
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: bgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: Icon(
                  currentIndex == 1 ? Clarity.home_solid : Clarity.home_line,
                  color: iconColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: Icon(
                  currentIndex == 2
                      ? EvaIcons.shopping_cart
                      : EvaIcons.shopping_cart_outline,
                  color: iconColor,
                ),
              ),
              Stack(children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                  icon: Icon(
                    currentIndex == 3 ? EvaIcons.heart : EvaIcons.heart_outline,
                    color: iconColor,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: provider.favorites.isNotEmpty
                      ? CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            provider.favorites.length.toString(),
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )
                      : Container(),
                ),
              ]),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 4;
                  });
                },
                icon: Icon(
                  currentIndex == 4 ? Iconsax.user_bold : Iconsax.user_outline,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
