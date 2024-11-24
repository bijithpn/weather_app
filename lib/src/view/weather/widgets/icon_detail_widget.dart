import 'package:flutter/material.dart';

class IconDetailWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final String title;

  const IconDetailWidget({
    super.key,
    this.icon = Icons.sunny,
    this.text = '',
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Theme.of(context).primaryColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
    return Container(
      width: 130,
      padding: const EdgeInsets.all(
        25,
      ),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: color,
                fontSize: 12,
              )),
          const SizedBox(height: 10),
          Icon(icon, size: 25, color: color),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style:
                theme.textTheme.bodySmall!.copyWith(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
