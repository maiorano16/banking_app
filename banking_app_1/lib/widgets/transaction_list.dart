import 'package:banking_app_1/models/transaction_model.dart';
import 'package:banking_app_1/utility/get_logo.dart';
import 'package:flutter/material.dart';

class TransactionsListPage extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsListPage({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: transactions.isEmpty
          ? Center(child: Text('Nessuna transazione disponibile.'))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  getLogoForCards(transaction.service),
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  transaction.service,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${transaction.typeOfTransaction}",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            Text(
                              " ${transaction.status}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 10,  
                          right: 10, 
                          child: Text(
                            "\$${transaction.costOfTransaction.toStringAsFixed(2)}",  
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: transaction.flow == 'Uscita'? Colors.red : Colors.green, 
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text(
                            transaction.dateOfTransaction,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
