import 'package:e_vahak/theme/pallete.dart';
import 'package:e_vahak/theme/text_theme.dart';
import 'package:flutter/material.dart';

 ThemeData theme = ThemeData(
  primaryColor: Pallete.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.backgroundColor,
    elevation: 0,
    centerTitle: true,
  ),
  //check out the text_theme.dart file
  // use the textTheme like style: Theme.of(context).textTheme.titleLarge,
  textTheme: textTheme,
);
