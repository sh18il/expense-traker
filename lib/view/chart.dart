import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traker/model/expense_model.dart';

class ChartScreen extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const ChartScreen({required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Get expenses by category
    Map<String, double> categoryExpenses = getExpensesByCategory(expenses);

    // Get daily expenses
    Map<String, double> dailyExpenses = getDailyExpenses(expenses);

    // Prepare data for the bar chart (category expenses)
    List<BarChartGroupData> barGroups = [];
    int index = 0;
    categoryExpenses.forEach((category, amount) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [BarChartRodData(toY: amount, color: Colors.blue)],
        ),
      );
      index++;
    });

    // Prepare data for the line chart (daily expenses)
    List<FlSpot> lineSpots = [];
    index = 0;
    dailyExpenses.forEach((date, amount) {
      lineSpots.add(FlSpot(index.toDouble(), amount));
      index++;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Overview'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bar chart for expenses by category
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value >= 0 && value < categoryExpenses.length) {
                              return Text(
                                categoryExpenses.keys.elementAt(value.toInt()),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: barGroups,
                  ),
                ),
              ),
            ),
            // Line chart for daily expenses
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 250,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles( 
                        sideTitles: SideTitles(
                          interval: 1,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value >= 0 && value < dailyExpenses.length) {
                              return Text(
                                DateFormat('MMM dd').format(
                                  DateTime.parse(dailyExpenses.keys
                                      .elementAt(value.toInt())),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: lineSpots,
                        isCurved: true,
                        color: Colors.green,
                        barWidth: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, double> getExpensesByCategory(List<ExpenseModel> expenses) {
    Map<String, double> categoryExpenses = {};
    for (var expense in expenses) {
      String category = expense
          .category; // Assuming `category` is a field in your ExpenseModel
      double amount = double.tryParse(expense.amount) ?? 0.0;

      if (categoryExpenses.containsKey(category)) {
        categoryExpenses[category] = categoryExpenses[category]! + amount;
      } else {
        categoryExpenses[category] = amount;
      }
    }
    return categoryExpenses;
  }

  Map<String, double> getDailyExpenses(List<ExpenseModel> expenses) {
    Map<String, double> dailyExpenses = {};
    for (var expense in expenses) {
      String day =
          "${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}-${expense.date.day.toString().padLeft(2, '0')}";
      double amount = double.tryParse(expense.amount) ?? 0.0;

      if (dailyExpenses.containsKey(day)) {
        dailyExpenses[day] = dailyExpenses[day]! + amount;
      } else {
        dailyExpenses[day] = amount;
      }
    }
    return dailyExpenses;
  }
}
