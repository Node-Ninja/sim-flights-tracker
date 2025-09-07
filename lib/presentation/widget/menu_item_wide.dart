import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../util/space_utils.dart';

class MenuItemWide extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final IconData itemIcon;
  final bool isAvailable;

  const MenuItemWide({super.key,
    required this.title,
    required this.location,
    required this.itemIcon,
    this.isAvailable = true,
    this.description = ''
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => isAvailable ? context.push(location) : null,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: (isAvailable) ? Colors.transparent : const Color(0xff0f121a),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(itemIcon),
                  horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.bodyLarge,),
                      Text(description, style: Theme.of(context).textTheme.labelSmall,),
                    ],
                  )
                ],
              ),
            ),
            (isAvailable) ? const Icon(Icons.chevron_right,) : Text('Coming soon', style: Theme.of(context).textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
