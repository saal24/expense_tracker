import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

final formatter = intl.DateFormat.yMd();

String _generateUuid() {
  final random = Random();
  final values = List<int>.generate(16, (i) => random.nextInt(256));
  return values.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
}

String _uuid() => _generateUuid();

enum Category { food, leisure, travel, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = _uuid();

  final String id;
  final String title;
  final double amount; // 1.99
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses
          .where((expense) => expense.category == category)
          .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }
    return sum;
  }
}
