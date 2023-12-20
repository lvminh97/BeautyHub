import 'package:flutter/material.dart';

class ItemUse extends StatelessWidget {
  final String use;
  const ItemUse({super.key, required this.use});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(
        use,
        maxLines: 3,
        style: const TextStyle(
          fontSize: 14.0,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
