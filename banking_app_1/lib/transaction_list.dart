import 'package:banking_app_1/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionsListPage extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsListPage({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transazioni'),
      ),
      body: transactions.isEmpty
          ? Center(child: Text('Nessuna transazione disponibile.'))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("Transazione: ${transaction.transactionNumber}"),
                    subtitle: Text(
                      "${transaction.typeOfTransaction} - ${transaction.service}\n"
                      "Data: ${transaction.dateOfTransaction}\n"
                      "Flusso: ${transaction.flow}\n"
                      "Costo: \$${transaction.costOfTransaction}\n"
                      "Status: ${transaction.status}",
                      style: TextStyle(fontSize: 14),
                    ),
                    isThreeLine: true,
                    onTap: () {
                      print("Transazione selezionata: ${transaction.transactionNumber}");
                    },
                  ),
                );
              },
            ),
    );
  }
}
