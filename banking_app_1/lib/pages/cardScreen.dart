import 'package:banking_app_1/carousel_cards.dart';
import 'package:banking_app_1/models/card_model.dart';
import 'package:banking_app_1/models/transaction_model.dart';
import 'package:banking_app_1/transaction_list.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<int> cardOrder = [];
  List<Transaction> transactions = [];
   String selectedCardId = '';

   @override
  void initState() {
    super.initState();
    loadTransactionFromJson().then((loadedTransactions) {
      setState(() {
        transactions = loadedTransactions; 
      });
    }).catchError((e) {
      print("Errore durante il caricamento delle transazioni: $e");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CardScreen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              print('IconButton cliccato');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Carta>>(
        future: loadCarteFromJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nessuna carta disponibile.'));
          } else {
            List<Carta> carte = snapshot.data!;
            if (cardOrder.isEmpty) {
               cardOrder = List.generate(carte.length, (index) => index);
               selectedCardId = carte[0].cardId;
            }
            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Carousel(
                    title: 'Carosello',
                    carte: carte,
                    selectedCardId: selectedCardId,
                    onCardSelected: (cardId) {
                      setState(() {
                        selectedCardId = cardId;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 40),
                selectedCardId.isNotEmpty
                    ? Expanded(
                        child: TransactionsListPage(
                          transactions: filterTransactionsByCardId(selectedCardId),
                        ),
                      )
                    : const Center(child: Text('Seleziona una carta per vedere le transazioni.')),
              ],
            );
          }
        },
      ),
    );
  }

  List<Transaction> filterTransactionsByCardId(String cardId) {
    return transactions.where((transaction) => transaction.cardId == cardId).toList();
  }
}