import 'package:ecommerce_app/views/auth_screen/login_screen.dart';
import 'package:ecommerce_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});
  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> with TickerProviderStateMixin {
  final _titles = [
    "Here you pick up clothes that fits all your criteria",
    "Welcome to the world of fashion",
    "Explore our collection of stylish clothes",
  ];

  final _subtitles = [
    "Welcome the the World of Clothes",
    "Where fashion meets comfort",
    "Discover your new favorite outfit",
  ];

  final _currentIndexNotifier = ValueNotifier(0);

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  void _nextText() {
    if (_currentIndexNotifier.value < _titles.length - 1) {
      _currentIndexNotifier.value++;
      _animationController.reset();
      _animationController.forward();
    } else {
      // Navigate to the next page
      Get.to(const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation =
        Tween<double>(begin: 0.1, end: 0).animate(_animationController);
    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
    
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _currentIndexNotifier,
                builder: (context, value, child) {
                  return AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                            0,
                            _animation.value *
                                MediaQuery.of(context).size.height),
                        child: Opacity(
                          opacity: _opacityAnimation.value,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 220),
                                  Text(
                                    _subtitles[value],
                                    style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    _titles[value],
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 48, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Button(
                    color: Colors.red,
                    title: "Next",
                    onPress: () {
                      _nextText();
                    },
                    textColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
