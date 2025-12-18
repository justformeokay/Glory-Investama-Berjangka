import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double elevation;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final void Function()? onTap;

  const CustomContainer({
    super.key,
    required this.child,
    this.borderRadius = 12,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.boxShadow,
    this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ??
        (isDark ? Colors.grey[900] : Colors.white);
    final bColor = borderColor ??
        (isDark ? Colors.grey[700] : Colors.grey[200]);

    final containerDecoration = BoxDecoration(
      color: gradient != null ? null : bgColor,
      gradient: gradient,
      border: Border.all(color: bColor!, width: borderWidth),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: boxShadow ??
          (elevation > 0
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: elevation * 2,
                    offset: Offset(0, elevation),
                  ),
                ]
              : null),
    );

    final container = Container(
      margin: margin,
      padding: padding,
      decoration: containerDecoration,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}

// Variant: Card-like container with optional header and footer
class CustomCardContainer extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? footer;
  final double borderRadius;
  final double elevation;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? backgroundColor;
  final void Function()? onTap;

  const CustomCardContainer({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.borderRadius = 12,
    this.elevation = 2,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(8),
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ??
        (isDark ? Colors.grey[900] : Colors.white);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) ...[
          header!,
          const SizedBox(height: 12),
        ],
        body,
        if (footer != null) ...[
          const SizedBox(height: 12),
          footer!,
        ],
      ],
    );

    final container = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation),
          ),
        ],
      ),
      child: content,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}

// Variant: Simple outlined container
class OutlinedContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? borderColor;
  final double borderWidth;
  final void Function()? onTap;

  const OutlinedContainer({
    super.key,
    required this.child,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.all(12),
    this.margin = EdgeInsets.zero,
    this.borderColor,
    this.borderWidth = 1.5,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bColor = borderColor ??
        (isDark ? Colors.grey[600] : Colors.grey[300]);

    final container = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: bColor!, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}
