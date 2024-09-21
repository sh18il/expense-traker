import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel {
  @HiveField(0)
  final String amount;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String? description;

  ExpenseModel({
    required this.amount,
    required this.date,
    required this.category,
    this.description,
  });
}
