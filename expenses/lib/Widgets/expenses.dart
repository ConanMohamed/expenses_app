import 'package:expenses/Models/expense.dart';
import 'package:expenses/Widgets/Expenses_list/expenses_list.dart';
import 'package:expenses/Widgets/create_expense.dart';
import 'package:expenses/cart/chart.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      category: Category.college,
      title: 'transport',
      amount: 1000,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.saving,
      title: 'Overdue',
      amount: 2000,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.food,
      title: 'food',
      amount: 3500,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.personals,
      title: 'leisure activities',
      amount: 500,
      date: DateTime.now(),
    ),
  ];

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Expense Tracker'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled:MediaQuery.of(context).size.width>=600? true:false,
                  useSafeArea: true,
                  context: context,
                  builder: (ctx) => NewExpense(createExpense: addExpense),
                );
              },
            ),
          ]),
      body: Center(
        child: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Cahrt(expenses: _registeredExpenses)),
                  Expanded(
                    child: EpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: removeExpense,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Cahrt(expenses: _registeredExpenses),
                  ),
                  Expanded(
                    child: EpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: removeExpense,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
