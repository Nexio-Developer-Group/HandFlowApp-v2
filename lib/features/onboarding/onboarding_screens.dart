import 'package:flutter/material.dart';
import 'package:handflow/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    print(Theme.of(context).scaffoldBackgroundColor);

    return Scaffold(
      body: PageView(
        // physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Page1(controller: _pageController),
          Page2(controller: _pageController),
          Page3(controller: _pageController),
        ],
      ),
    );
  }

  Widget pageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: 3,
        effect: ExpandingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          spacing: 8,
          radius: 6,
          dotColor: Colors.grey,
          activeDotColor: orange,
        ),
      ),
    );
  }

  Widget navigationButtons() {
    final textTheme = Theme.of(context).textTheme;
    final Size screenSize = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_rounded, size: 15),
              SizedBox(width: 10),
              Text("back", style: textTheme.bodyLarge),
            ],
          ),
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Next", style: TextStyle(fontSize: 16)),
                Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Page1 extends StatelessWidget {
  final PageController controller;
  const Page1({required this.controller});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/find_qr.png',
                  width: screenSize.width * 0.75,
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 8,
                    radius: 6,
                    dotColor: Colors.grey,
                    activeDotColor: orange,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Welcome to HandFlow',
                      style: textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'To get started, scan the QR code on the back of your HandFlow device.',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.arrow_forward),
              label: Text("Next"),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center, // aligns content inside the button
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final PageController controller;
  const Page2({required this.controller});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset(
                  'assets/animation.json',
                  width: screenSize.width * 0.75,
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 8,
                    radius: 6,
                    dotColor: Colors.grey,
                    activeDotColor: orange,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Scan the QR Code',
                      style: textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Point your phone at the QR code on your Handflow Controller to link it with the app.',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.arrow_forward),
              label: Text("Open Scanner"),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center, // aligns content inside the button
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  final PageController controller;
  const Page3({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 3'));
  }
}
