import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonlit/screens/store_event.dart';

import '../constants.dart';
import '../models/product_model.dart';
import '../provider/favorite_provider.dart';
import '../screens/store_product.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: kcontentColor,
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {},
          icon: Image.asset(
            "assets/icon.png",
            height: 20,
          ),
        ),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: kcontentColor,
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {},
          iconSize: 30,
          icon: const Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }
}

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlide;
  const ImageSlider({
    super.key,
    required this.currentSlide,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView(
              scrollDirection: Axis.horizontal,
              allowImplicitScrolling: true,
              onPageChanged: onChange,
              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "assets/slider.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/image1.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/slider3.png",
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => AnimatedContainer(
                  duration: const Duration(microseconds: 300),
                  width: currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentSlide == index
                          ? Colors.black
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoreProduct(product: product),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kcontentColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Center(
                  child: Hero(
                    tag: product.image1,
                    child: Image.asset(
                      product.image1,
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "₹${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
              child: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: kprimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  provider.toggleFavorite(product);
                },
                child: Icon(
                  provider.isExist(product)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class MySearchBAR extends StatelessWidget {
  const MySearchBAR({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kcontentColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          const SizedBox(width: 10),
          const Flexible(
            flex: 4,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search...", border: InputBorder.none),
            ),
          ),
          Container(
            height: 25,
            width: 1.5,
            color: Colors.grey,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTileRight extends StatelessWidget {
  final String image1;
  final Color bgColor;
  final String event;
  final String surprise;
  final String option;
  final int index;
  const HomeTileRight(this.event, this.surprise, this.option, this.bgColor,
      this.image1, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => StoreEvent(
                    event, surprise, option, bgColor, image1, index)));
      },
      child: Container(
        decoration: BoxDecoration(color: bgColor),
        child: SizedBox(
          height: 150,
          width: width,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$event Sale',
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      surprise,
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size(100, 30),
                      ),
                      child: Text(
                        option,
                        style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Image.asset(
                image1,
                fit: BoxFit.fitHeight,
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTileLeft extends StatelessWidget {
  final String image1;
  final Color bgColor;
  final String event;
  final String surprise;
  final String option;
  final int index;
  const HomeTileLeft(this.event, this.surprise, this.option, this.bgColor,
      this.image1, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: SizedBox(
        height: 150,
        width: width,
        child: Row(
          children: [
            Image.asset(
              image1,
              fit: BoxFit.fitHeight,
              cacheWidth: 170,
              cacheHeight: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$event Sale',
                    style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800)),
                  ),
                  Text(
                    surprise,
                    style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => StoreEvent(event, surprise,
                                  option, bgColor, image1, index)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      minimumSize: const Size(100, 30),
                    ),
                    child: Text(
                      option,
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCircle extends StatelessWidget {
  final IconData icon;
  final String text;
  const CategoryCircle(this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey[100]),
            iconSize: WidgetStateProperty.all(32),
            padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
            shape: WidgetStateProperty.all(
              const CircleBorder(),
            ),
            iconColor: WidgetStateProperty.all(Colors.black),
          ),
          child: Icon(icon),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          text,
          style: GoogleFonts.quicksand(
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({super.key});

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.amber;
    double width = MediaQuery.of(context).size.width - 40;
    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: SizedBox(
        height: 150,
        width: width,
      ),
    );
  }
}

class ProductStore extends StatelessWidget {
  final String title;
  final String image1;
  final double price;
  const ProductStore(this.image1, this.title, this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 170,
            width: 160,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image1),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.quicksand(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
          ),
          Wrap(
            spacing: 5,
            children: [
              Text(
                "₹$price",
                style: GoogleFonts.quicksand(
                    color: Colors.brown[400],
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
