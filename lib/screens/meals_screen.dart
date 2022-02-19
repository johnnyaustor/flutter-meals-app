import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> meals;

  const MealsScreen(this.meals, {Key? key}) : super(key: key);

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late String _categoryTitle;
  late List<Meal> _displayMeals;
  bool _loadInitdata = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies()');
    if (!_loadInitdata) {
      print('inside condition');
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      _categoryTitle = routeArgs['title'] as String;
      _displayMeals = widget.meals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadInitdata = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final meal = _displayMeals[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imageUrl: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
          );
        },
        itemCount: _displayMeals.length,
      ),
    );
  }
}
