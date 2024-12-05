import 'package:banking_app_1/models/card_model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final String title;
  final List<Carta> carte;

  const Carousel({Key? key, required this.title, required this.carte}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        itemCount: widget.carte.length, 
        itemBuilder: (context, index) {
          Carta card = widget.cards[index]; 
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          '£${card.saldoCarta}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          '${carta.numeroCarta}',
                          '${card.numeroCarta}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 150,
                    right: 16,
                    child: Text(
                      card.scadenzaCarta,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 16,
                    child: Text(
                      card.circuito,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 15,
                    child: Text(
                      card.tipoCarta,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemHeight: 250.0,
        itemWidth: 300.0,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
