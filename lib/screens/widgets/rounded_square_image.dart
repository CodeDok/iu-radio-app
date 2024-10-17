import 'package:flutter/material.dart';

class RoundedSquareContainer extends StatelessWidget {
  final Widget imageWidget;

  const RoundedSquareContainer({
    super.key,
    required this.imageWidget
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(width: 10, color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: imageWidget,
      ),
    );
  }
}