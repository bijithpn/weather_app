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
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
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
