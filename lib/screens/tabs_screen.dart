// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kIntialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState <TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  Map<Filter, bool> _selectedfilters = kIntialFilter;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedfilters,
          ),
        ),
      ).then(
          (value) => setState(() => _selectedfilters = value ?? kIntialFilter));
    }
  }

  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Removed from favorites');
      } else {
        _favoriteMeals.add(meal);
        _showInfoMessage('Added to favorites');
      }
    });
  }
 
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ava = ref.watch(mealsProvider);
    final List <Meal> availableMeals = ava.where((meal) {
      if (_selectedfilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedfilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedfilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedfilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    Widget ActivePage = CategoriesScreen(
      onToggleFavorite: _toggleFavorite,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'pick your category';
    if (_selectedPageIndex == 1) {
      ActivePage = Mealsscreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavorite,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: ActivePage,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category), 
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
