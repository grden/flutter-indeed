import 'dart:math';

import 'package:flutter/material.dart';

class FlipLoadingWidget extends StatefulWidget {
  // Sets an [AnimationController] is case you need to do something
  final AnimationController? controller;
  final BoxShape _shape; // Default color is set to [Colors.blueGrey].
  final Color backgroundColor; // Default color is set to [Colors.transparent].
  final Color borderColor;
  final double size;
  final double? borderSize;
  final Duration duration;
  final IndexedWidgetBuilder?
      itemBuilder; // Sets an [IndexedWidgetBuilder] function to return

  //LoadingFlipping animation with a circle shape
  const FlipLoadingWidget.circle({
    super.key,
    this.controller,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.size = 36.0,
    this.borderSize,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 2400),
  })  : assert(borderSize != null ? borderSize <= size / 2 : true,
            'loading_animations: property [borderSize] must not be greater than half the widget size'),
        _shape = BoxShape.circle;

  @override
  _FlipLoadingWidgetState createState() => _FlipLoadingWidgetState();
}

class _FlipLoadingWidgetState extends State<FlipLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    _animation = CurveTween(curve: Curves.easeInOut).animate(_controller)
      ..addListener(
        () => setState(() {}),
      );

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, widget._shape == BoxShape.circle ? 0.002 : 0.005)
      ..rotateY(_animation.value * 2 * -pi);

    return Center(
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: SizedBox.fromSize(
          size: Size.square(widget.size),
          child: _itemBuilder(0),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) {
    return widget.itemBuilder != null
        ? widget.itemBuilder!(context, index)
        : DecoratedBox(
            decoration: BoxDecoration(
              shape: widget._shape,
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 101, 179, 245),
                Color.fromARGB(255, 30, 98, 190)
              ], begin: Alignment.topLeft),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderSize ?? widget.size / 8,
                style: BorderStyle.solid,
              ),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
