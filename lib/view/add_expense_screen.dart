import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traker/controller/expense_provider.dart';
import 'package:traker/model/expense_model.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _category = 'Food';
  DateTime _selectedDate = DateTime.now();

  // Method to submit the expense data
  void _submitData() {
    final enteredAmount = _amountController.text;
    if (enteredAmount.isEmpty) {
      return;
    }

    Provider.of<ExpenseProvider>(context, listen: false).addExpense(
      ExpenseModel(
        amount: enteredAmount,
        date: _selectedDate,
        category: _category,
        description: _descriptionController.text,
      ),
    );

    Navigator.of(context).pop();
  }

  // Method to present a date picker
  void _presentDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Amount input field
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),

            // Description input field
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: _descriptionController,
            ),
            SizedBox(height: 10),

            // Date picker button
            Row(
              children: [
                Text(
                  'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text('Change Date'),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Dropdown for category selection
            DropdownButton<String>(
              value: _category,
              onChanged: (newValue) {
                setState(() {
                  _category = newValue!;
                });
              },
              items: <String>['Food', 'Transport', 'Entertainment']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Submit button
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
