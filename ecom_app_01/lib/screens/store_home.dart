import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import '../constants.dart';
import '../models/product_model.dart';
import '../widget/store_widgets.dart';
import 'store_notification.dart';

class StoreHome extends StatefulWidget {
  const StoreHome({super.key});

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  Color bgColor = const Color(0xFFEEEBE9);
  Color titleColor = const Color(0xFF494952);
  Color tileActive = Colors.black;
  Color tileInactive = Colors.grey[300]!;
  Color grey = Colors.grey[400]!;

  int currentSlider = 0;
  int selectedIndex = 0;

  bool isSearching = false;
  List<Product> filteredProducts = [];

  final _searchController = TextEditingController();

  void _onSearchChanged() {
    setState(() {
      isSearching = _searchController.text.isNotEmpty;
      if (isSearching) {
        String query = _searchController.text.toLowerCase();
        if (query.isEmpty) {
          filteredProducts = [];
        } else {
          filteredProducts = all
              .where((product) =>
                  product.title.toLowerCase().contains(query) ||
                  product.category.toLowerCase().contains(query))
              .toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: -10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.transparent, // Background color of the AppBar
              padding: EdgeInsets.symmetric(
                  vertical: 14, horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: screenWidth * 0.10,
                  ),
                  Text(
                    'Shop',
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 28),
                      color: Colors.grey[700],
                    ),
                  ),
                  Stack(children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StoreNotification(),
                          ),
                        );
                      },
                      icon:
                          Icon(EvaIcons.bell_outline, color: Colors.grey[700]),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.brown.shade400,
                          child: const Text(
                            "1",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: screenWidth * 0.02),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: screenWidth * 0.1,
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (input) {
                          _onSearchChanged();
                        },
                        decoration: InputDecoration(
                          hintText: 'Search..',
                          hintStyle: GoogleFonts.quicksand(
                            textStyle: const TextStyle(fontSize: 18),
                            color: Colors.grey[400],
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.02),
                          prefixIcon: const Icon(Iconsax.search_normal_outline,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: screenWidth * 0.1,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.white,
                      ),
                      child: Icon(Iconsax.setting_4_outline,
                          color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
            isSearching
                ? StoreSearch(
                    screenWidth, _searchController.text, filteredProducts)
                : StoreList(screenWidth),
          ],
        ),
      ),
    );
  }
}

class ClothingItemCard extends StatelessWidget {
  final String imagePath;
  final String itemName;
  final String description;

  const ClothingItemCard({
    super.key,
    required this.imagePath,
    required this.itemName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: const Color(0xFFFFFCF9),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image(
                image: AssetImage(imagePath),
                width: screenWidth * 0.2,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemName,
                      style: GoogleFonts.quicksand(
                        color: const Color(0xFFBCB3AA),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.favorite_border,
                  color: Color(0xFFB2ABA5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoreList extends StatefulWidget {
  final double screenWidth;
  const StoreList(this.screenWidth, {super.key});

  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  int _categoryIndex = 0;
  late Timer _timer;
  List<String> categories = [
    'All',
    ' Men ',
    'Women',
    'Kids',
  ];

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.03),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: widget.screenWidth * 0.4,
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: const [
                  HomeTileRight('Summer', '50% OFF', 'Buy Now',
                      Color(0xffacb4b9), 'assets/tile/tile1.png', 1),
                  HomeTileLeft('End of Season', '50% OFF', 'Buy Now',
                      Color(0xFFDC8A75), 'assets/tile/tile2.png', 2),
                  HomeTileRight('Winter', '50% OFF', 'Buy Now',
                      Color(0xFFE5E5EA), 'assets/tile/tile3.png', 3),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentIndex == index ? 15.0 : 5.0,
                height: 4,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? tileActive : tileInactive,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.03),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
                spacing: widget.screenWidth * 0.03,
                children: List.generate(categories.length, (index) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _categoryIndex = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.transparent,
                      backgroundColor:
                          _categoryIndex == index ? buttonColor : Colors.white,
                    ),
                    child: Text(
                      categories[index],
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: _categoryIndex == index
                            ? Colors.white
                            : buttonColor,
                      ),
                    ),
                  );
                })),
          ),
        ),
        StoreView(widget.screenWidth, all, categories[_categoryIndex]),
      ],
    );
  }
}

class StoreView extends StatelessWidget {
  final double screenWidth;
  final List<Product> products;
  final String category;
  const StoreView(this.screenWidth, this.products, this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    List<List<Product>> selectcategories = [demo];
    List<Product> filteredProducts = category == "All"
        ? products
        : products
            .where((product) =>
                product.category == category ||
                product.title.toLowerCase().contains(category.toLowerCase()))
            .toList();
    int selectedIndex = 0;
//change here
    return Column(
      mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
      children: [
        const SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 219, 215),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 260,
                width:
                    screenWidth * 3, // Constrains the width to the screen width
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: screenWidth / 2.4, // Adjust the width as needed
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ProductCard(
                        product: filteredProducts[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Text(
            "Recommended for you",
            style: GoogleFonts.quicksand(
              color: titleColor,
              textStyle:
                  const TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          // Use Flexible with FlexFit.loose
          fit: FlexFit.loose,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: selectcategories[selectedIndex].length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: selectcategories[selectedIndex][index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class StoreSearch extends StatefulWidget {
  final double screenWidth;
  final String query;
  final List<Product> products;
  const StoreSearch(this.screenWidth, this.query, this.products, {super.key});

  @override
  State<StoreSearch> createState() => _StoreSearchState();
}

class _StoreSearchState extends State<StoreSearch> {
  List<Product> filteredProducts = [];

  @override
  void didUpdateWidget(covariant StoreSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      filterProducts();
    }
  }

  void filterProducts() {
    if (widget.query.toLowerCase() == 'all') {
      setState(() {
        filteredProducts = widget.products;
      });
    } else {
      setState(
        () {
          filteredProducts = widget.products
              .where(
                (product) =>
                    product.title
                        .toLowerCase()
                        .contains(widget.query.toLowerCase()) ||
                    product.category.toLowerCase().contains(
                          widget.query.toLowerCase(),
                        ),
              )
              .toList();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    filterProducts();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.03),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Results',
            style: GoogleFonts.playfairDisplay(fontSize: 22),
          ),
          const SizedBox(height: 25),
          Flexible(
            // Use Flexible with FlexFit.loose
            fit: FlexFit.loose,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: filteredProducts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
