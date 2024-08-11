import 'package:ecommerce_app/views/home_screen/components/featured_buttons.dart';
import 'package:ecommerce_app/views/home_screen/components/home_buttons.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images1 = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
  ];
  List<String> images2 = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
  ];
  List<String> images3 = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
  ];
  List<String> featuredimages1 = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
  ];
  List<String> featuredimages2 = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
  ];
  List<String> featuredtitles1 = [
    "Women Dress",
    "Girl Dress",
    "Girl Watches",
  ];
  List<String> featuredtitles2 = [
    "Men Dress",
    "Boys Dress",
    "Tshirts",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                color: Colors.grey.shade500,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search anything....",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              //Carousel Slider
              CarouselSlider.builder(
                itemCount: images1.length,
                itemBuilder: (BuildContext context, int index, int realIndex) =>
                    Image.asset(
                  images1[index],
                  fit: BoxFit.cover,
                ),
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: 100,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeButtons(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    icon: Icons.calendar_month,
                    iconColor: Colors.blue,
                    title: "Today's Deal",
                    onPress: () {},
                  ),
                  HomeButtons(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    icon: Icons.flash_on,
                    iconColor: Colors.yellow,
                    title: "Flash Sale",
                    onPress: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider.builder(
                itemCount: images2.length,
                itemBuilder: (BuildContext context, int index, int realIndex) =>
                    Image.asset(
                  images2[index],
                  fit: BoxFit.cover,
                ),
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: 150,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeButtons(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.15,
                    icon: Icons.category,
                    iconColor: Colors.blue,
                    title: "Top Categories",
                    onPress: () {},
                  ),
                  HomeButtons(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.15,
                    icon: Icons.lightbulb,
                    iconColor: Colors.indigo.shade400,
                    title: "Brand",
                    onPress: () {},
                  ),
                  HomeButtons(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.15,
                    icon: Icons.cruelty_free_outlined,
                    iconColor: Colors.yellow,
                    title: "Top Sellers",
                    onPress: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Featured Categories",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    3,
                    (index) => Column(
                      children: [
                        featuredButtons(
                            icon: featuredimages1[index],
                            title: featuredtitles1[index]),
                        const SizedBox(
                          height: 20,
                        ),
                        featuredButtons(
                            icon: featuredimages2[index],
                            title: featuredtitles2[index]),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.red),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Featured Products",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            List.generate(6, (index) => featuredCategories()),
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider.builder(
                itemCount: images3.length,
                itemBuilder: (BuildContext context, int index, int realIndex) =>
                    Image.asset(
                  images3[index],
                  fit: BoxFit.cover,
                ),
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: 150,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              //ALL PRODUCTS
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 300),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          const Spacer(),
                          Text(
                            "Laptop",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Pfice",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
