import 'package:flutter/material.dart';

class LayoutToggleButton extends StatelessWidget {
  final bool isGrid;
  final VoidCallback onPressed;

  const LayoutToggleButton({
    super.key,
    required this.isGrid,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded),
    );
  }
}
