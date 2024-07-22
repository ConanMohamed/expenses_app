import 'package:expenses/Models/expense.dart';
import 'package:expenses/Widgets/Expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class EpensesList extends StatelessWidget {
  const EpensesList({
    super.key,
    required this.expenses, required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) =>
            Dismissible(
              background: Container(color: Theme.of(context).colorScheme.error.withOpacity(.7),margin: Theme.of(context).cardTheme.margin,),
              key: ValueKey(expenses[index]),
            onDismissed: (direction) => onRemoveExpense(expenses[index]),
            child: ExpensesItem(expense: expenses[index])));
  }
}
