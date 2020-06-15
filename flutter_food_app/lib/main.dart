  import 'package:flutter/material.dart';
  import './screens/filter_screen.dart';
  import './screens/meal_detail_screen.dart';
  import './screens/category_meals_screen.dart';
  import './screens/categories_screen.dart';
  import './screens/tabs_screen.dart';
  import './dummy_data.dart';
  import './models/meal.dart';

  void main() => runApp(MyApp());

  class MyApp extends StatefulWidget {
    // This widget is the root of your application.
    @override
    _MyAppState createState() => _MyAppState();
  }

  class _MyAppState extends State<MyApp> {
    Map<String, bool> _filters = {
      'gluten': false,
      'lactose': false,
      'vegetarian': false,
      'vegan': false
    };

    List<meal> _availableMeals = DUMMY_MEALS;

    void _setFilters( Map<String, bool> filterData) {
      setState(() {
        _filters = filterData;

        _availableMeals = DUMMY_MEALS.where((meal) {
          if (_filters['gluten'] && !meal.isGlutenFree) {
            return false;
          }
          if (_filters['vegan'] && !meal.isVegan) {
            return false;
          }
          if (_filters['lactose'] && !meal.isLactoseFree) {
            return false;
          }
          if (_filters['Vegetarian'] && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
      });
    }
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'DancingScript',
          textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),
            ),
          title: TextStyle(
          fontSize: 24,
          fontFamily: 'Raleway'
          ),),
        ),
        //home: CategoriesScreen() ,
        initialRoute: '/',       //default is'/
        routes: {
          '/': (ctx) => TabsSreen(),
          CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
          MealDetailScreen.routename: (ctx) =>MealDetailScreen(),
          FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilters),
        },
        onGenerateRoute: (settings){
          print(settings.arguments);
          },
        onUnknownRoute: (settings){
          return MaterialPageRoute(builder:(ctx) => CategoriesScreen());
          },
      );
    }
  }


