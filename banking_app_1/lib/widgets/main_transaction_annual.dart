
import 'package:banking_app_1/models/mainAccountAnnualTransaction_model.dart';
import 'package:flutter/material.dart';

class MainTransactionsListPage extends StatelessWidget {
  final List<AnnualMainAccountTransaction> transactions;  

  const MainTransactionsListPage({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.description), 
          subtitle: Text(transaction.date), 
          trailing: Text('\$${transaction.amount.toString()}'), 
        );
      },
    );
  }
}
