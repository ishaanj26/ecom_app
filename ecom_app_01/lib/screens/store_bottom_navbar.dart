import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moonlit/provider/add_to_cart_provider.dart';
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

  // Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    // _requestPermission();
  }

  // _requestPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   _getCurrentLocation();
  // }

  // _getCurrentLocation() async {
  //   try {
  //     final position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //     _saveLocationToDatabase();
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // _saveLocationToDatabase() async {
  //   // Assuming you have a Firebase Authentication instance
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     final database = FirebaseDatabase.instance;
  //     final ref = database.ref('users/${user.uid}');
  //     ref.update({
  //       'address': {
  //         'latitude': _currentPosition?.latitude,
  //         'longitude': _currentPosition?.longitude,
  //       },
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavoriteProvider>(context);
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
              Stack(children: [
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
                Positioned(
                  top: 0,
                  right: 0,
                  child: cartProvider.cart.isNotEmpty
                      ? CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.orange.shade400,
                          child: Text(
                            cartProvider.cart.length.toString(),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        )
                      : Container(),
                ),
              ]),
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
                  child: favProvider.favorites.isNotEmpty
                      ? CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            favProvider.favorites.length.toString(),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
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
