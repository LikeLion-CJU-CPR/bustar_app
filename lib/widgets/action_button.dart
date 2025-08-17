import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.side,
    this.onPressed,
    this.isExpanded = true,
    this.height,
    this.padding,
    this.fontSize = 14.0,
    this.iconSize = 16.0,
  });

  final IconData icon;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? side;
  final VoidCallback? onPressed;
  final bool isExpanded;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final button = SizedBox(
      height: height,
      child: OutlinedButton.icon(
        icon: Icon(icon, size: iconSize),
        label: Text(label, style: TextStyle(fontSize: fontSize)),
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: side,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          disabledBackgroundColor:
              backgroundColor?.withValues(alpha: .5) ?? Colors.grey.shade300,
          disabledForegroundColor:
              foregroundColor?.withValues(alpha: .5) ?? Colors.grey.shade600,
        ),
      ),
    );

    return isExpanded ? Expanded(child: button) : button;
  }
}
