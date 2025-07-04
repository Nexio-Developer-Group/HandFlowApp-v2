import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as ui;

class ScrollingBackground extends StatefulWidget {
  final Widget? child;
  final Widget background; // 👈 New field for external background

  const ScrollingBackground({super.key, this.child, required this.background});

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
  final double spacing = 6.0;
  final double scale = 0.8;
  final double speed = 0.02;

  ImageStream? _imageStream;
  ImageStreamListener? _imageListener;

  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
    _ticker = createTicker(_onTick)..start();
  }

  void _loadImage() {
    final imageProvider = AssetImage('assets/background.png');
    final config = ImageConfiguration();
    _imageStream = imageProvider.resolve(config);
    _imageListener = ImageStreamListener((imageInfo, _) {
      if (!mounted) return;
      setState(() {
        _image = imageInfo.image;
      });
    });
    _imageStream!.addListener(_imageListener!);
  }

  void _onTick(Duration elapsed) {
    final dt = elapsed - _lastElapsed;
    _lastElapsed = elapsed;

    if (!mounted) return;
    setState(() {
      _offset += dt.inMilliseconds * speed;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
    if (_imageStream != null && _imageListener != null) {
      _imageStream!.removeListener(_imageListener!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1️⃣ Background passed from outside
        widget.background,

        // 2️⃣ Scrolling image layer
        if (_image != null)
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: _BackgroundPainter(
              image: _image!,
              offset: _offset,
              tileWidth: tileWidth,
              tileHeight: tileHeight,
              spacing: spacing,
              scale: scale,
              opacity: 0.18,
            ),
          ),

        // 3️⃣ Foreground widget
        widget.child ?? Container(),
      ],
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final ui.Image image;
  final double offset;
  final double tileWidth;
  final double tileHeight;
  final double spacing;
  final double scale;
  final double opacity;

  _BackgroundPainter({
    required this.image,
    required this.offset,
    required this.tileWidth,
    required this.tileHeight,
    required this.spacing,
    required this.scale,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(opacity);
    final scaledW = tileWidth * scale;
    final scaledH = tileHeight * scale;
    final dx = scaledW + spacing;
    final dy = scaledH + spacing;

    final rows = (size.height / dy).ceil() + 2;
    final cols = (size.width / dx).ceil() + 1;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final dxPos = col * dx;
        final dyPos = (row * dy - (offset % dy));
        canvas.drawImageRect(
          image,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          Rect.fromLTWH(dxPos, dyPos, scaledW, scaledH),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
