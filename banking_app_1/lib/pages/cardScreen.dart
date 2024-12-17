import 'package:banking_app_1/pages/addCardScreen.dart';
import 'package:banking_app_1/widgets/carousel_cards.dart';
import 'package:banking_app_1/models/card_model.dart';
import 'package:banking_app_1/models/transaction_model.dart';
import 'package:banking_app_1/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<Carta> carte = [];
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
    loadCarteFromJson().then((loadedCards) {
      setState(() {
        carte = loadedCards;
      });
    }).catchError((e) {
      print("Errore durante il caricamento delle carte: $e");
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
            onPressed: () async {
              final newCard = await Navigator.push<Carta>(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCardScreen(),
                ),
              );

              if (newCard != null) {
                setState(() {
                  carte.add(newCard);
                  selectedCardId = newCard.cardId; 
                });
              }
            },
          ),
        ],
      ),
      body: Column(
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
      ),
    );
  }

  List<Transaction> filterTransactionsByCardId(String cardId) {
    return transactions.where((transaction) => transaction.cardId == cardId).toList();
  }
}
