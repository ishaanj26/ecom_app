import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moonlit/constants.dart';
import 'package:moonlit/models/product_model.dart';
import 'package:moonlit/widget/store_widgets.dart';

class StoreEvent extends StatefulWidget {
  final String image1;
  final Color bgColor;
  final String event;
  final String surprise;
  final String option;
  final int index;

  const StoreEvent(
    this.event,
    this.surprise,
    this.option,
    this.bgColor,
    this.image1,
    this.index, {
    super.key,
  });

  @override
  State<StoreEvent> createState() => _StoreEventState();
}

class _StoreEventState extends State<StoreEvent> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<List<Product>> selectcategories = [
      all
          .where((product) =>
              product.title.toLowerCase().contains('pant') ||
              product.title.toLowerCase().contains('shirt') ||
              product.title.toLowerCase().contains('skirt'))
          .toList(),
      all
          .where((product) =>
              product.title.toLowerCase().contains('shoes') ||
              (product.title.toLowerCase().contains('watch')))
          .toList(),
      all
          .where(
            (product) =>
                product.title.toLowerCase().contains('jacket') ||
                ((product.title.toLowerCase().contains('shoe')) &&
                    (product.description.toLowerCase().contains('leather'))) ||
                product.title.toLowerCase().contains(' shirt ') ||
                product.title.toLowerCase().contains('boot'),
          )
          .toList(),
    ];
    int selectedIndex = widget.index - 1;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(EvaIcons.arrow_ios_back_outline),
                  ),
                  Text(
                    'Event',
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                      ),
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.10),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  widget.index % 2 != 0
                      ? EventTileLeft(
                          '${widget.event} Sale',
                          widget.surprise,
                          'Explore now',
                          widget.bgColor,
                          widget.image1,
                        )
                      : EventTileRight(
                          '${widget.event} Sale',
                          widget.surprise,
                          'Explore now',
                          widget.bgColor,
                          widget.image1,
                        ),
                  const SizedBox(height: 20),
                  Text(
                    '${widget.event} Products',
                    style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: buttonColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventTileLeft extends StatelessWidget {
  final String image1;
  final Color bgColor;
  final String event;
  final String surprise;
  final String option;

  const EventTileLeft(
    this.event,
    this.surprise,
    this.option,
    this.bgColor,
    this.image1, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: SizedBox(
        height: 180,
        width: width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event,
                    overflow: TextOverflow.ellipsis, // Handle overflow
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    surprise,
                    overflow: TextOverflow.ellipsis, // Handle overflow
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              image1,
              fit: BoxFit.cover,
              cacheWidth: 170,
              cacheHeight: 200,
            ),
          ],
        ),
      ),
    );
  }
}

class EventTileRight extends StatelessWidget {
  final String image1;
  final Color bgColor;
  final String event;
  final String surprise;
  final String option;

  const EventTileRight(
    this.event,
    this.surprise,
    this.option,
    this.bgColor,
    this.image1, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: SizedBox(
        height: 180,
        width: width,
        child: Row(
          children: [
            // Image section
            Image.asset(
              image1,
              fit: BoxFit.cover,
            ),
            // Padding and text section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        event,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        surprise,
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
