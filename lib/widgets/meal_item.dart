import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meal_app/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.complexity,
    required this.affordability,
    required this.duration,
    required this.title,
    required this.imageUrl,
    required Meal meal, required this.onSelectMeal,
  });

  final String title;
  final String imageUrl;
  final Complexity complexity;
  final Affordability affordability;
  final int duration;
  final void Function(BuildContext) onSelectMeal;

  String get complexityText {
    switch (complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  // ignore: non_constant_identifier_names
  String get AffordabilityText {
    switch (affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        child: InkWell(
          onTap: () => onSelectMeal(context),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 300,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      color: Colors.black54,
                      child: Column(
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.schedule),
                        const SizedBox(width: 6),
                        Text(
                          '$duration min',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.work),
                        const SizedBox(width: 6),
                        Text(
                          complexityText,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.attach_money),
                        const SizedBox(width: 6),
                        Text(
                          AffordabilityText,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}
