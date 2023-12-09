import 'package:flutter/material.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';
import 'package:todo_app/core/shared/fonts/font_manager.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello,',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: ColorsManager.white,
              fontWeight: FontWeightManager.light,
                ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Farah Mohamed Eid',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: ColorsManager.white,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ],
      ),
    );
  }
}
