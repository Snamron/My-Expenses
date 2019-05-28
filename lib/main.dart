import 'package:expenses/expenseform.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: "expenses",
      home: ExpenseForm(),
    ),
  );
}
