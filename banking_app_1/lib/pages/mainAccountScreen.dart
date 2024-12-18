import 'dart:convert';
import 'package:banking_app_1/models/card_model.dart';
import 'package:banking_app_1/widgets/carousel_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAccountPage extends StatefulWidget {
  const MainAccountPage({Key? key}) : super(key: key);

  @override
  _MainAccountPageState createState() => _MainAccountPageState();
}

class _MainAccountPageState extends State<MainAccountPage> {
  List<Carta> carte = []; 
  String selectedCardId = '';

  @override
  void initState() {
    super.initState();
    _loadCarteFromJson();
  }

  Future<void> _loadCarteFromJson() async {
    final String response = await rootBundle.loadString('assets/fileJson/card.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> carteList = data['cards'];
    
    setState(() {
      carte = carteList.map((json) => Carta.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainAccountCards = carte.where((card) => card.tipoAccount == 'Main account').toList();
    if (mainAccountCards.length > 1) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Main Account Cards'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Carousel(
                title: "Carosello main account",
                carte: mainAccountCards,
                selectedCardId: selectedCardId,
                onCardSelected: (cardId) {
                  setState(() {
                    selectedCardId = cardId;
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else if (mainAccountCards.isNotEmpty) {
      final card = mainAccountCards.first;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Main Account Card'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Container(
                    width: 350, 
                    height: 250,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32),
                            Text(
                              '\$${card.saldoCarta}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              '${card.numeroCarta}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              card.scadenzaCarta,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              card.tipoCarta,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Main Account Cards'),
        ),
        body: Center(
          child: const Text('No main account cards available'),
        ),
      );
    }
  }
}
