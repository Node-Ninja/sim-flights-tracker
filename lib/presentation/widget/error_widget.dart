import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  const CustomErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Symbols.error, size: 200,),
              Text(errorMessage,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
