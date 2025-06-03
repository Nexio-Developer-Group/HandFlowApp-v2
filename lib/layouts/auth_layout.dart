import 'package:flutter/material.dart';
import 'package:handflow/theme.dart';

class Authlayout extends StatefulWidget {
  final Widget? child;

  const Authlayout({super.key, this.child});

  @override
  State<Authlayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<Authlayout> {
  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                if (!keyboardOpen) const _AuthHeaderDesign(),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            margin: EdgeInsets.symmetric(
                              horizontal: 25,
                              // vertical: 100,
                            ),
                            // child: AnimatedSwitcher(
                            //   duration: Duration(milliseconds: 300),
                            //   transitionBuilder: (child, animation) {
                            //     return FadeTransition(
                            //       opacity: animation,
                            //       child: child,
                            //     );
                            //   },
                            child: widget.child,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AuthHeaderDesign extends StatelessWidget {
  const _AuthHeaderDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 🔽 1. BACK CIRCLE (goes under everything)
        Positioned(
          bottom: -35,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Theme.of(
                      context,
                    ).scaffoldBackgroundColor, // Match background
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(51),
                    blurRadius: 10,
                    offset: Offset(0, 4), // Downward shadow
                  ),
                ],
              ),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: orange,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(38),
                blurRadius: 15,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'HandFlow',
              style: theme.textTheme.headlineLarge!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),

        // 🔽 3. FRONT CIRCLE (image container)
        Positioned(
          bottom: -35,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ClipOval(
                  child: Image.asset('assets/icon1.png', fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
