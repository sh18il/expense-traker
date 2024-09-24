import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traker/controller/expense_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense History"),
      ),
      body: Container(
        child:
            Consumer<ExpenseProvider>(builder: (context, expenseProvider, _) {
          return ListView.builder(
            itemCount: expenseProvider.expenses.length,
            itemBuilder: (context, index) {
              final expense = expenseProvider.expenses[index];

              return ListTile(
                title: Text(expense?.description ?? ""),
                subtitle: Text(
                    'Amount: \$${expense.amount} | Category: ${expense.category} |  ${expense.date.toLocal().toString().split(' ')[0]}'),
                trailing: IconButton(
                    onPressed: () {
                      expenseProvider.deleteExpense(index);
                    },
                    icon: Icon(Icons.delete)),
              );
            },
          );
        }),
      ),
    );
  }
}
