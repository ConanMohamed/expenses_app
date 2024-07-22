import 'dart:io';

import 'package:expenses/Models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.createExpense});

  final void Function(Expense expense) createExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}



class _NewExpenseState extends State<NewExpense> {
void showDialogs(){
  Platform.isIOS?
  showCupertinoDialog(
                              context: context, 
                              builder: (contx) => CupertinoAlertDialog(
                                title: const Text('Invalid input!'),
                                  content: const Text('Please make sure valid title, amount, date and category was entered.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(contx),
                                      child: const Text('Okay'),
                                      
                                    ),
                                  ],
                              )
                              ):
                        showDialog(
                            context: context,
                            builder: (contx) => AlertDialog(
                                  title: const Text('Invalid input!'),
                                  content: const Text('Please make sure valid title, amount, date and category was entered.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(contx),
                                      child: const Text('Okay'),
                                    ),
                                  ],
                                )
                                );
}

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                        prefixText: '\$',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final firstDate =
                                DateTime(now.year - 5, now.month, now.day);
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: firstDate,
                              lastDate: now,
                            );
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  DropdownButton(
                      dropdownColor: const Color.fromARGB(255, 226, 219, 219),
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase(),),
                              ),
                            )
                            .toList(),
                        onChanged: (newCat) {
                          if (newCat == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = newCat;
                          });
                        }),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final double? enteredAmount =
                          double.tryParse(_amountController.text);
                      final bool invalidAmount =
                          enteredAmount == null || enteredAmount <= 0;
      
                      if (invalidAmount ||
                          _titleController.text.trim().isEmpty ||
                          _selectedDate == null) {
                            showDialogs();
                      } else {
                        widget.createExpense(
                          Expense(
                              category: _selectedCategory,
                              title: _titleController.text,
                              amount: enteredAmount,
                              date: _selectedDate!),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save Expense'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
