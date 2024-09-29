import 'package:flutter/material.dart';
//import 'package:meal_app/screens/tabs_screen.dart';
//import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();

  final Map<Filter, bool> currentFilters;
}

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilter = false;
  bool _lactoseFreeFilter = false;
  bool _veganFilter = false;
  bool _vegetarianFilter = false;

  @override
  void initState() {
    _glutenFreeFilter = widget.currentFilters[Filter.glutenFree] ?? false;
    _lactoseFreeFilter = widget.currentFilters[Filter.lactoseFree] ?? false;
    _veganFilter = widget.currentFilters[Filter.vegan] ?? false;
    _vegetarianFilter = widget.currentFilters[Filter.vegetarian] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      /*   drawer: MainDrawer(
        onSelectScreen: (identifier) {
          if (identifier == 'meals') {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => const TabsScreen(),
              ),
            );
          } else {
            Navigator.of(context).pop();
          }
        },
      ),*/
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilter,
            Filter.lactoseFree: _lactoseFreeFilter,
            Filter.vegan: _veganFilter,
            Filter.vegetarian: _vegetarianFilter,
          });
          return false;
        },
        child: Column(
          children: [
            customSwitch(
              context,
              'Gluten-free',
              'Only include gluten-free meals',
              _glutenFreeFilter,
              (bool value) {
                setState(() => _glutenFreeFilter = value);
              },
            ),
            customSwitch(
              context,
              'Lactose-free',
              'Only include Lactose-free meals',
              _lactoseFreeFilter,
              (bool value) {
                setState(() {
                  _lactoseFreeFilter = value;
                });
              },
            ),
            customSwitch(
              context,
              'Vegan-free',
              'Only include Vegan-free meals',
              _veganFilter,
              (bool value) {
                setState(() {
                  _veganFilter = value;
                });
              },
            ),
            customSwitch(
              context,
              'Vegetarian-free',
              'Only include Vegetarian-free meals',
              _vegetarianFilter,
              (bool value) {
                setState(() => _vegetarianFilter = value);
              },
            ),
          ],
        ),
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
