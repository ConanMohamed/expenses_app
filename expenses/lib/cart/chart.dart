import 'package:expenses/cart/chart_bar.dart';
import 'package:flutter/material.dart';

import '../Models/expense.dart';

class Cahrt extends StatelessWidget {
  const Cahrt({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(Category.food, expenses),
      ExpenseBucket.forCategory(Category.saving, expenses),
      ExpenseBucket.forCategory(Category.college, expenses),
      ExpenseBucket.forCategory(Category.personals, expenses),
      ExpenseBucket.forCategory(Category.travels, expenses),
    ];
  }

  double get maxTotalExpenses {
    double maxTotalExpenses = 0;

    for (var element in buckets) {
      if (element.totalExpense > maxTotalExpenses) {
        maxTotalExpenses = element.totalExpense;
      }
    }

    return maxTotalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(
      builder: (ctx, constraint){
        return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        width: double.infinity,
        height: constraint.maxHeight*0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.primary.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final ele in buckets)
                    ChartBar(
                      fill: ele.totalExpense == 0
                          ? 0
                          : ele.totalExpense / maxTotalExpenses,
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: buckets
                  .map((e) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Icon(
                            categoryIcons[e.category],
                            color: isDarkMode? Colors.white:Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      );
      } 
    );
  }
}
