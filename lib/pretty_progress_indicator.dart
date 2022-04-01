library pretty_progress_indicator;

import 'dart:math';

import 'package:flutter/material.dart';

class PrettyProgressIndicator extends StatelessWidget {
  const PrettyProgressIndicator({
    Key? key,
    required this.progress,
    this.type = IndicatorType.radial,
    this.label,
    this.barWidth = 50.0,
    required this.colors,
    this.backgroundColor,
    this.textStyle,
  }) : super(key: key);

  final double progress;
  final IndicatorType? type;
  final String? label;
  final double barWidth;
  final List<Color> colors;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PrettyPainter(
        progress: progress,
        type: type,
        label: label,
        barWidth: barWidth,
        colors: colors,
        backgroundColor: backgroundColor,
        textStyle: textStyle,
      ),
      child: Container(),
    );
  }
}

class PrettyPainter extends CustomPainter {
  PrettyPainter({
    required this.progress,
    this.type,
    this.label,
    required this.barWidth,
    required this.colors,
    this.backgroundColor,
    this.textStyle,
  });

  final double progress;
  final IndicatorType? type;
  final String? label;
  final double barWidth;
  final List<Color> colors;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  @override
  void paint(Canvas canvas, Size size) {
    if (type == IndicatorType.radial) {
      paintRadial(canvas, size);
    } else {
      paintLinear(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant PrettyPainter oldDelegate) => oldDelegate.progress != progress;

  void paintRadial(Canvas canvas, Size size) {
    // PROGRESS TEXT
    var textSpan = TextSpan(
      text: label ?? (progress * 100).toInt().toString() + '%',
      style: textStyle ?? TextStyle(color: colors[0], fontSize: 30.0, fontWeight: FontWeight.w700),
    );

    var textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();
    var offsetText = Offset(size.width / 2 - (textPainter.width / 2), size.height / 2 - (textPainter.height / 2));
    textPainter.paint(canvas, offsetText);

    // PROGRESS ARCH
    var offsetArch = Offset(size.width / 2, size.height / 2);
    var rectArch = Rect.fromCircle(
      center: offsetArch,
      radius: min(size.width, size.height) / 2 - barWidth / 2,
    );

    double startRadians = pi;
    double sweepRadians = progress * 2 * pi;
    double endRadians = pi * 4;

    var shaderArch = SweepGradient(
      colors: colors.length < 2 ? [colors[0], colors[0]] : colors,
      startAngle: startRadians,
      endAngle: endRadians,
      tileMode: TileMode.mirror,
    ).createShader(rectArch);

    var paintArch = Paint()
      ..shader = shaderArch
      ..style = PaintingStyle.stroke
      ..strokeWidth = barWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rectArch, startRadians, sweepRadians, false, paintArch);
  }

  void paintLinear(Canvas canvas, Size size) {
    // PROGRESS TEXT
    var textSpan = TextSpan(
      text: label ?? (progress * 100).toInt().toString() + '%',
      style: textStyle ?? TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700),
    );

    var textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();
    var offsetText = Offset(size.width / 2 - (textPainter.width / 2), size.height / 2 - (textPainter.height / 2));

    // PROGRESS ARCH
    var offsetLeft = Offset(0, size.height / 2);
    var offsetRight = Offset(size.width, size.height / 2);
    var offsetProgress = Offset(size.width * progress, size.height / 2);

    var rectBar = Rect.fromPoints(offsetLeft, offsetRight);
    var shaderBar = LinearGradient(colors: colors).createShader(rectBar);

    var paintBarBG = Paint()
      ..color = backgroundColor ?? Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = barWidth
      ..strokeCap = StrokeCap.round;

    var paintBar = Paint()
      ..shader = shaderBar
      ..style = PaintingStyle.stroke
      ..strokeWidth = barWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(offsetLeft, offsetRight, paintBarBG);
    canvas.drawLine(offsetLeft, offsetProgress, paintBar);
    textPainter.paint(canvas, offsetText);
  }
}

enum IndicatorType { radial, linear }
