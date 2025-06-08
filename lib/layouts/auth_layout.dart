import 'package:flutter/material.dart';
import '../components/title_subtitle_text.dart';
import '../../components/scrolling_image_widget.dart';

class Authlayout extends StatefulWidget {
  final Widget? child;

  const Authlayout({super.key, this.child});

  @override
  State<Authlayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<Authlayout> {
  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollingBackground(
        background: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE96A32), Color(0xFFF13B09)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  'Handflow',
                  style: TextStyle(
                    fontFamily: 'EduSABeginner',
                    fontWeight: FontWeight.w600,
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -14,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.84,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(112),
                          borderRadius: BorderRadius.circular(45),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(20),
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.vertical(
                        top: Radius.circular(45),
                        bottom: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            (MediaQuery.of(context).size.width * 51) / 402,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.037,
                            ),
                            child: const TitleSubtitleText(
                              title: 'Get Started now',
                              subtitle:
                                  'Create an account or log in to explore\nabout our app',
                            ),
                          ),
                          SizedBox(height: 16),

                          // Use KeyedSubtree for persistence
                          Expanded(
                            child: KeyedSubtree(
                              key: ValueKey(widget.child?.runtimeType),
                              child: widget.child ?? const SizedBox(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.032,
                            ),
                            child: Image.asset('assets/logo.png'),
                          ),
                        ],
                      ),
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
