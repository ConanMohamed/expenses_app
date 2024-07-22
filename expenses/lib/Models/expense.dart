import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatDate = DateFormat.yMd();

enum Category { food, college, travels, personals, saving }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.personals: Icons.person,
  Category.college: Icons.book,
  Category.saving: Icons.attach_money,
  Category.travels: Icons.flight_takeoff,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatDate.format(date);
  }

  Expense(
      {required this.category,
      required this.title,
      required this.amount,
      required this.date})
      : id = uuid.v4();
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket(this.category, this.expenses);
  ExpenseBucket.forCategory(this.category, List<Expense> allExpenses)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpense {
    double sum = 0;

    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
