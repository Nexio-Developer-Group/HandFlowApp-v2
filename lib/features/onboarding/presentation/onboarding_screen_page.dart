import 'package:flutter/material.dart';
import 'package:handflow/shared/widgets/scrolling_image_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/onboarding_screen_model.dart';
import '../../../shared/widgets/title_subtitle_text.dart';
import '../../../shared/widgets/gradient_elevated_button.dart';

class OnboardingScreenPage extends StatelessWidget {
  final OnboardingScreenModel model;

  const OnboardingScreenPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final outerPadding = EdgeInsets.symmetric(
      horizontal: size.width * 51 / 402,
      vertical: size.height * 46 / 874,
    );

    final lowerHeight = size.height * 0.36;
    final upperHeight = size.height - lowerHeight;

    return Scaffold(
      body: ScrollingBackground(
        background: Container(), // your orange/gradient background if needed
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient overlay (already present)
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withAlpha(0),
                      Colors.white.withAlpha(194),
                      Colors.white,
                    ],
                    stops: [0.0, 0.5, 0.5],
                  ),
                ),
              ),
            ),
            // Your main content goes here, for example:
            Padding(
              padding: outerPadding,
              child: Column(
                children: [
                  Flexible(flex: 64, child: Center(child: model.child)),
                  Flexible(
                    flex: 36,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleSubtitleText(
                          title: model.title,
                          subtitle: model.description,
                        ),
                        Spacer(),
                        SmoothPageIndicator(
                          effect: WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 8,
                            dotColor: Colors.black12,
                            activeDotColor: Color(0xFFF13B09), // your orange
                            paintStyle: PaintingStyle.fill,
                            type: WormType.normal,
                          ),

                          controller: model.pageController,
                          count: model.pageCount,
                        ),
                        SizedBox(height: 17),
                        GradientElevatedButton(
                          onPressed: model.onButtonClick,
                          child: Text(model.buttonText),
                        ),
                      ],
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
