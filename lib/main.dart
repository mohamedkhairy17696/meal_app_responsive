import 'package:flutter/material.dart';
import '../screens/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import './screens/themes_screen.dart';
import 'package:provider/provider.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen= (prefs.getBool('watched')??false)?TabsScreen():OnBoardingScreen();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (_) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
        ),
      ],
      child: MyApp(homeScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;

  MyApp(this.mainScreen);

  @override
  Widget build(BuildContext context) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      themeMode: tm,
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        buttonColor: Colors.black87,
        cardColor: Colors.white,
        shadowColor: Colors.black54,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        buttonColor: Colors.white70,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.white60,
              ),
              headline6: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      // default is '/'
      routes: {
        '/': (ctx) => mainScreen,
        TabsScreen.routeName: (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(),
        ThemesScreen.routeName: (ctx) => ThemesScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
