import 'package:banking_app_1/models/mainAccountAnnualTransaction_model.dart';
import 'package:flutter/material.dart';

class MainTransactionsListPage extends StatelessWidget {
  final List<MainCardTransaction> transactions;

  const MainTransactionsListPage({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Log per debuggare i dati delle transazioni
    print("Transazioni: ${transactions.length}");
    transactions.forEach((transaction) {
      print("Transazione: ${transaction.description}, ${transaction.transactionCost}");
    });

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
                                // Puoi sostituire l'icona con un logo per categoria
                                Icon(Icons.account_balance_wallet, size: 40, color: Colors.blue),
                                SizedBox(width: 10),
                                Text(
                                  transaction.serviceType, // Categoria della transazione
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              transaction.description, // Descrizione della transazione
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Metodo di pagamento: ${transaction.transactionType}", // Metodo di pagamento
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
                            "${transaction.transactionCost.toStringAsFixed(2)} ${transaction.currency}",  // Importo della transazione
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: transaction.transactionCost < 0 ? Colors.red : Colors.green, // Colore in base all'importo
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text(
                            transaction.transactionDate, // Data della transazione
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
