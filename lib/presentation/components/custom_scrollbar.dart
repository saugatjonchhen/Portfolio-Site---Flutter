import 'package:flutter/material.dart';

class CustomScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController controller;

  const CustomScrollbar({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return RawScrollbar(
      controller: controller,
      thumbColor: theme.colorScheme.primary.withOpacity(0.3),
      radius: const Radius.circular(20),
      thickness: 6,
      interactive: true,
      minThumbLength: 40,
      thumbVisibility: false, // Only show on scroll
      child: child,
    );
  }
}
