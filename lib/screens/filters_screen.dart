// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/filters_provider.dart';
//import 'package:meal_app/screens/tabs_screen.dart';
//import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // ignore: duplicate_ignore
      // ignore: deprecated_member_use
      body: Column(
        children: [
          customSwitch(
            context,
            'Gluten-free',
            'Only include gluten-free meals',
            activeFilters[Filter.glutenFree]!,
            (bool value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilters(Filter.glutenFree, value);
            },
          ),
          customSwitch(
            context,
            'Lactose-free',
            'Only include Lactose-free meals',
            activeFilters[Filter.lactoseFree]!,
            (bool value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilters(Filter.lactoseFree, value);
            },
          ),
          customSwitch(
            context,
            'Vegan-free',
            'Only include Vegan-free meals',
            activeFilters[Filter.vegan]!,
            (bool value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilters(Filter.vegan, value);
            },
          ),
          customSwitch(
            context,
            'Vegetarian-free',
            'Only include Vegetarian-free meals',
            activeFilters[Filter.vegetarian]!,
            (bool value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilters(Filter.vegetarian, value);
            },
          ),
        ],
      ),
    );
  }

  SwitchListTile customSwitch(
    BuildContext context,
    String title,
    String subtitle,
    bool filter,
    Function(bool newValue) onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 30, right: 30),
      value: filter,
      onChanged: onChanged,
    );
  }
}
