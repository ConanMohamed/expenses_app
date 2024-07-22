import 'package:expenses/Widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

var myColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 57, 171, 183));
var myDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 57, 171, 183));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData().copyWith(
        colorScheme: myColorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: myColorScheme.onPrimaryContainer,
          foregroundColor: myColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme(
          color: myColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: myColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: myColorScheme.onSecondaryContainer,
              fontSize: 17),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: myDarkColorScheme,
        useMaterial3: true,
        bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: myDarkColorScheme.tertiaryContainer,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: myDarkColorScheme.onPrimaryContainer,
          foregroundColor: myDarkColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme(
          color: myDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: myDarkColorScheme.onPrimaryContainer,
              foregroundColor: myDarkColorScheme.primaryContainer,
              ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: myDarkColorScheme.onSecondaryContainer,
              fontSize: 17),
        ),
      ),
      home: const Expenses(),
    );
  }
}
