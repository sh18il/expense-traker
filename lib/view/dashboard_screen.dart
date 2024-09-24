import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:traker/controller/expense_provider.dart';
import 'package:traker/model/expense_model.dart';
import 'package:traker/view/chart.dart';
import 'package:traker/view/history_screen.dart';
import 'add_expense_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalExpense = Provider.of<ExpenseProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromARGB(0, 175, 177, 177),
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
          color: Color(0xFFFDF1F5),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color(0xFF8FB9A8),
                  child: Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Consumer<ExpenseProvider>(
                                builder: (context, totalExpense, _) {
                              var amount = totalExpense.expenses.fold<double>(
                                  0,
                                  (sum, expense) =>
                                      sum + double.parse(expense.amount));
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Total Expenses: \$',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      ' ${amount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => showDialog(
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
                                child: AddExpenseScreen(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    child: Card(
                      color: Color(0xFFF305F72),
                      child: Container(
                        height: 100,
                        width: 110,
                        child: Center(
                            child: Text(
                          "Add Expense",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChartScreen(expenses: totalExpense.expenses),
                        )),
                    child: Card(
                      color: Color(0xFFF305F72),
                      child: Container(
                        height: 100,
                        width: 110,
                        child: Center(
                            child: Text(
                          "Charts",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryScreen(),
                          ));
                    },
                    child: Card(
                      color: Color(0xFFF305F72),
                      child: Container(
                        height: 100,
                        width: 110,
                        child: Center(
                            child: Text(
                          "History",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    ),
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
