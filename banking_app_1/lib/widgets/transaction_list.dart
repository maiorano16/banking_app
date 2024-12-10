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
                                  getLogoForTransactionService(transaction.service),
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

  String getLogoForTransactionService(String service) {
    switch (service) {
      case 'Netflix':
        return 'assets/transactionLogos/netflix.png';
      case 'Spotify':
        return 'assets/transactionLogos/spotify.png';
      case 'Amazon':
        return 'assets/transactionLogos/amazon.png';
      case 'Disney+':
        return 'assets/transactionLogos/disney.png';
      case 'Apple Store':
        return 'assets/transactionLogos/appleStore.png';
      case 'Red Cross':
        return 'assets/transactionLogos/croceRossa.png';
      case 'Ebay':
        return 'assets/transactionLogos/ebay.png';
      case 'Google Workspace':
        return 'assets/transactionLogos/google.png';
      case 'Airbnb':
        return 'assets/transactionLogos/airbnb.png';       
      default:
        return 'assets/transactionLogos/money.png';
    }
  }
}
