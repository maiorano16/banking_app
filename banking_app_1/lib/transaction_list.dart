import 'package:banking_app_1/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';

class GroupedListViewPage extends StatelessWidget {
  final Future<List<Transazioni>> Function() loadTransactions;

  GroupedListViewPage({required this.loadTransactions});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transazioni>>(
      future: loadTransactions(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Errore: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nessuna transazione disponibile.'));
        } else {
          
          List<Transazioni> transazioni = snapshot.data!;

          final groupedTransactions = groupTransactionsByCardId(transazioni);

          return GroupListView(
            sectionsCount: groupedTransactions.keys.length,
            countOfItemInSection: (int section) {
              final cardId = groupedTransactions.keys.toList()[section];
              return groupedTransactions[cardId]!.length;
            },
            itemBuilder: (BuildContext context, IndexPath index) {
              final cardId = groupedTransactions.keys.toList()[index.section];
              final transaction = groupedTransactions[cardId]![index.index];

          
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15), 
                padding: const EdgeInsets.all(12), 
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(12),  
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),  
                      spreadRadius: 2,  
                      blurRadius: 5,  
                      offset: Offset(0, 3),  
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.numeroTransazione,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${transaction.tipoTransazione} - ${transaction.servizio}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Data: ${transaction.dataTransazione}',
                            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${transaction.costoTransazione.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: transaction.direzioneTransazione == 'Uscita' ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              );
            },
            groupHeaderBuilder: (BuildContext context, int section) {
              final cardId = groupedTransactions.keys.toList()[section];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  'Card ID: $cardId',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              );
            },
            sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
          );
        }
      },
    );
  }
}
