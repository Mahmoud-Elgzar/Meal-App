// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/widgets/meal_item.dart';

class Mealsscreen extends StatelessWidget {
  const Mealsscreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return title == null
        ? content(context)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content(context),
          );
  }

  SingleChildScrollView content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: meals
            .map((meal) => MealItem(
                  complexity: meal.complexity,
                  affordability: meal.affordability,
                  imageUrl: meal.imageUrl,
                  duration: meal.duration,
                  title: meal.title,
                  // ignore: duplicate_ignore
                  // ignore: avoid_types_as_parameter_names
                  meal: meal,
                  onSelectMeal: (BuildContext) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => MealDetailScreen(
                          meal: meal,
                        ),
                      ),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
