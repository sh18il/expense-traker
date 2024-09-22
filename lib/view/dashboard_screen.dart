import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traker/controller/expense_provider.dart';
import 'package:traker/view/history_screen.dart';
import 'add_expense_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var totalExpense = Provider.of<ExpenseProvider>(context, listen: false)
        .expenses
        .fold<double>(0, (sum, expense) => sum + double.parse(expense.amount));

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(),
                    ));
              },
              icon: Icon(Icons.history))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://tallysolutions.com/us/wp-content/uploads/2021/11/cogs-vs-expenses-whats-the-difference.jpg"))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Expenses: \$${totalExpense.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            ),
                            Container(
                              height: 450,
                              padding: EdgeInsets.all(16),
                              child:
                                  AddExpenseScreen(), // Show the AddExpenseScreen here
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text("Add Expense"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
