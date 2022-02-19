import 'package:flutter/material.dart';
import 'package:flutter_menu_app/dummy_data.dart';
import 'package:flutter_menu_app/screens/filters_screen.dart';

import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import 'models/meal.dart';
import 'screens/meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _meals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;

      _meals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(254, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        ).copyWith(
          titleMedium: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        MealsScreen.routeName: (ctx) => MealsScreen(_meals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              _toggleFavorite,
              _isMealFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
