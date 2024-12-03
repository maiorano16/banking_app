import 'package:banking_app_1/carousel_cards.dart';
import 'package:banking_app_1/models/card_model.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<int> cardOrder = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Example'),
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
            }
            return SizedBox(
              height: 200,
              child: Carousel(title: 'Carosello', carte: carte),
            );
          }
        },
      ),
    );
  }
}