import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui';

class ScrollingBackground extends StatefulWidget {
  final Widget child;

  const ScrollingBackground({super.key, required this.child});

  @override
  State<ScrollingBackground> createState() => _ScrollingBackgroundState();
}

class _ScrollingBackgroundState extends State<ScrollingBackground>
    with SingleTickerProviderStateMixin {
  double _offset = 0.0;
  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  final double tileWidth = 356;
  final double tileHeight = 191;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final dt = elapsed - _lastElapsed;
    _lastElapsed = elapsed;

    setState(() {
      _offset -= dt.inMilliseconds * 0.02; // Speed multiplier
      if (_offset <= -tileHeight) {
        _offset += tileHeight;
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cols = (size.width / tileWidth).ceil() + 1;
    final rows = (size.height / tileHeight).ceil() + 2;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1️⃣ Gradient at bottom
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE96A32), Color(0xFFF13B09)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),

        // 2️⃣ Scrolling images above gradient
        Positioned(
          top: _offset,
          left: 0,
          child: Column(
            children: List.generate(rows, (row) {
              return Row(
                children: List.generate(cols, (col) {
                  return Padding(
                    padding: const EdgeInsets.all(
                      6.0,
                    ), // 👈 control the gap here
                    child: Opacity(
                      opacity: 0.18,
                      child: Image.asset(
                        'assets/background.png',
                        width: tileWidth,
                        height: tileHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ),

        // 3️⃣ Foreground UI (child widget)
        widget.child,
      ],
    );
  }
}
