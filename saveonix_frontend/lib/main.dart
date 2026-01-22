import 'package:flutter/material.dart';

void main() {
  runApp(const SaveOnixApp());
}

class SaveOnixApp extends StatelessWidget {
  const SaveOnixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ExpenseHome(),
    );
  }
}

class Expense {
  final String category;
  final double amount;
  final DateTime date;

  Expense(this.category, this.amount, this.date);
}

class ExpenseHome extends StatefulWidget {
  const ExpenseHome({super.key});

  @override
  State<ExpenseHome> createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final List<Expense> expenses = [];

  void addExpense() {
    if (amountController.text.isEmpty ||
        categoryController.text.isEmpty) {
      return;
    }

    setState(() {
      expenses.insert(
        0,
        Expense(
          categoryController.text,
          double.parse(amountController.text),
          DateTime.now(),
        ),
      );
    });

    amountController.clear();
    categoryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SaveOnix Expenses")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // INPUT CARD
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Amount",
                        prefixText: "Rs ",
                      ),
                    ),
                    TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                        labelText: "Category",
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: addExpense,
                      child: const Text("Add Expense"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // EXPENSE LIST
            Expanded(
              child: expenses.isEmpty
                  ? const Center(child: Text("No expenses yet"))
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.money),
                            title: Text(expense.category),
                            subtitle: Text(
                              expense.date.toLocal().toString().split('.')[0],
                            ),
                            trailing: Text(
                              "Rs ${expense.amount.toStringAsFixed(2)}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}