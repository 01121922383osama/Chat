import 'package:flutter/material.dart';

import 'media_query.dart';

class AnimationButtonWidget extends StatefulWidget {
  final String text;
  final void Function()? function;
  const AnimationButtonWidget(
      {Key? key, required this.text, required this.function})
      : super(key: key);

  @override
  State<AnimationButtonWidget> createState() => AnimationButtonWidgetState();
}

class AnimationButtonWidgetState extends State<AnimationButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomMediaQuery(context).screenHeight / 20,
      width: CustomMediaQuery(context).screenWidth / 1.1,
      child: ScaleTransition(
        alignment: Alignment.center,
        scale: Tween<double>(
          begin: 1.0,
          end: 0.8,
        ).animate(_controller),
        child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
          ),
          onPressed: () {
            widget.function != null
                ? _controller.forward().whenComplete(() => _controller
                    .reverse()
                    .whenComplete(() => widget.function!()))
                : null;
          },
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
