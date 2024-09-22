import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:traker/model/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  Box<ExpenseModel> expenseBox = Hive.box<ExpenseModel>('expensesBox');

  List<ExpenseModel> get expenses => expenseBox.values.toList();

  void addExpense(ExpenseModel expense) {
    expenseBox.add(expense);
    notifyListeners();
  }

  void deleteExpense(int index) {
    expenseBox.deleteAt(index);
    notifyListeners();
  }

  void editExpense(int index, ExpenseModel expense) {
    expenseBox.putAt(index, expense);
    notifyListeners();
  }
}
