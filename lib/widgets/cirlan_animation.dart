import 'package:flutter/cupertino.dart';

class CirlanAnimation extends StatefulWidget {
  final Widget child;
  const CirlanAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<CirlanAnimation> createState() => _CirlanAnimationState();
}

class _CirlanAnimationState extends State<CirlanAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 5000,
      ),
    );
    controller.forward();
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: widget.child,
    );
  }
}
