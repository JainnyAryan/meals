import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/meal_detail_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> favouriteMeals = [];
  List<Meal> availableMeals = DUMMY_MEALS;

  void setFilters(Map<String, bool> boolData) {
    setState(() {
      filters = boolData;
      availableMeals = DUMMY_MEALS.where((element) {
        if (filters['gluten'] && !element.isGlutenFree) return false;
        if (filters['lactose'] && !element.isLactoseFree) return false;
        if (filters['vegan'] && !element.isVegan) return false;
        if (filters['vegetarian'] && !element.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void toggleFav(String mealId) {
    final existingIndex =
        favouriteMeals.indexWhere((element) => mealId == element.id);
    if (existingIndex >= 0) {
      setState(() {
        favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouriteMeals.add(
          DUMMY_MEALS.firstWhere((element) => mealId == element.id),
        );
      });
    }
  }

  bool isFav(String id) {
    return favouriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyMedium: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            titleMedium: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold)),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(toggleFav,isFav),
        FilterScreen.routeName: (context) => FilterScreen(filters, setFilters),
      },
      // ignore: missing_return
      onGenerateRoute: (settings) {
        //when route not found in routes table , this function runs
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        //when route generation failed or onGenerateRoute not defined, this runs (acts as error page)
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
