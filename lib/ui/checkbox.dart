import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final Color color;
  final Function toggleChange;
  final int duration;
  CustomCheckbox(
      {required this.isChecked,
      required this.color,
      required this.toggleChange,
      required this.duration});
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  void toggleCheckbox() {
    widget.toggleChange();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCheckbox,
      child: AnimatedCheckbox(
        isChecked: widget.isChecked,
        color: widget.color,
        duration: widget.duration,
      ),
    );
  }
}

class AnimatedCheckbox extends StatefulWidget {
  final bool isChecked;
  final Color color;
  final int duration;

  AnimatedCheckbox(
      {required this.isChecked, required this.color, required this.duration});

  @override
  _AnimatedCheckboxState createState() => _AnimatedCheckboxState();
}

class _AnimatedCheckboxState extends State<AnimatedCheckbox>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _painColorDouble;

  late AnimationController _controllerIcon;
  late Animation<double> _iconDouble;

  (int, int) setDuration() {
    int durationShape = (widget.duration * 0.7).round();
    int durationIcon = (widget.duration * 0.3).round();

    return (durationShape, durationIcon);
  }

  @override
  void initState() {
    super.initState();
    // var (durationShape, durationIcon) = setDuration();
    var (durationShape, durationIcon) = (0, 0);

    _controller = AnimationController(
      vsync: this,
      reverseDuration: Duration(milliseconds: durationShape),
      duration: Duration(milliseconds: durationShape), // Длительность анимации
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerIcon.forward();
        }
      });
    _painColorDouble = Tween<double>(
      begin: 1.0, // Начальный масштаб
      end: 0.0, // Конечный масштаб
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 1),
        reverseCurve: Interval(0, 1),
        // Эффект easeInOutBack
      ),
    );

    _controllerIcon = AnimationController(
        reverseDuration: Duration(milliseconds: durationIcon),
        duration: Duration(milliseconds: durationIcon),
        vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.reverse();
        }
      });

    _iconDouble = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controllerIcon,
        curve: Interval(0, 1),
        reverseCurve: Interval(0, 1),
      ),
    );

    if (widget.isChecked) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    var (durationShape, durationIcon) = setDuration();
    _controller.duration = Duration(milliseconds: durationShape);
    _controller.reverseDuration = Duration(milliseconds: durationShape);
    _controllerIcon.duration = Duration(milliseconds: durationIcon);
    _controllerIcon.reverseDuration = Duration(milliseconds: durationIcon);
    if (widget.isChecked ) {
      _controller.forward();
    } else if (widget.isChecked == false ) {
      if(_controller.status == AnimationStatus.forward) {
        _controller.reset();
      }
      _controllerIcon.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerIcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return AnimatedBuilder(
            animation: _controllerIcon,
            builder: (context, child) {
              return CustomPaint(
                size: Size(25, 25), // Размер чекбокса
                painter: CheckboxPainter(
                    isChecked: widget.isChecked,
                    scale: _painColorDouble.value,
                    iconDouble: _iconDouble.value,
                    color: widget.color),
              );
            });
      },
    );
  }
}

class CheckboxPainter extends CustomPainter {
  final bool isChecked;
  final double scale;
  final double iconDouble;
  final Color color;

  CheckboxPainter(
      {required this.isChecked,
      required this.scale,
      required this.iconDouble,
      required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final midX = size.width / 2;
    final midY = size.height / 2;
    final radius = size.width / 2;

    // Рисуем круглую обводку чекбокса
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Рисуем круглую область чекбокса с анимацией цвета в активном состоянии
    final fillPaint = (Color? colorArg) => Paint()
      ..color = colorArg != null ? colorArg : color
      ..style = PaintingStyle.fill;

    // Рисуем галочку внутри чекбокса с анимаци
    // Рисуем галочку внутри чекбокса с анимацией увеличения размера в активном состоянии
    final checkPaint = Paint()
      ..color = Colors.white // Галочка всегда белая в активном состоянии
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Рисуем круглую обводку чекбокса
    canvas.drawCircle(Offset(midX, midY), radius, borderPaint);

    // Рисуем круглую область чекбокса с анимацией цвета в активном состоянии
    canvas.drawCircle(Offset(midX, midY), radius, fillPaint(null));
    canvas.drawCircle(
        Offset(midX, midY), (radius - 1) * scale, fillPaint(Colors.white));

    if (scale == 0) {
      // Рисуем галочку внутри чекбокса с анимацией увеличения размера в активном состоянии

      final path = Path();
      path.moveTo(midX - (midX / 2) * iconDouble, midY + 1 * iconDouble);
      path.lineTo(
          midX - (midX / 6) * iconDouble, midY + (midY / 2.5) * iconDouble);
      path.lineTo(
          midX + (midX / 1.5) * iconDouble, midY - (midY / 4) * iconDouble);

      canvas.drawPath(path, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
