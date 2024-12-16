import 'package:flutter/material.dart';
import 'package:banking_app_1/models/card_model.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();

  late String cardId;
  late String scadenzaCarta;
  late double saldoCarta;
  late String numeroCarta;
  late String tipoAccount;
  late String iban;
  late String tipoCarta;
  late String circuito;

  @override
  void initState() {
    super.initState();
    cardId = '';
    scadenzaCarta = '';
    saldoCarta = 0.0;
    numeroCarta = '';
    tipoAccount = '';
    iban = '';
    tipoCarta = '';
    circuito = '';
  }

  bool isValidExpirationDate(String date) {
    RegExp exp = RegExp(r"^(0[1-9]|1[0-2])\/([0-9]{2})$");
    return exp.hasMatch(date);
  }

  bool isValidCardNumber(String number) {
    return number.length == 16 && RegExp(r'^\d+$').hasMatch(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi Carta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ID Carta'),
                onChanged: (value) => cardId = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'L\'ID della carta è obbligatorio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Scadenza Carta (MM/YY)'),
                onChanged: (value) => scadenzaCarta = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La data di scadenza è obbligatoria.';
                  }
                  if (!isValidExpirationDate(value)) {
                    return 'Inserisci una data di scadenza valida (MM/YY).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Saldo Carta'),
                onChanged: (value) {
                  saldoCarta = double.tryParse(value) ?? 0.0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il saldo della carta è obbligatorio.';
                  }
                  if (saldoCarta <= 0) {
                    return 'Il saldo deve essere un numero positivo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Numero Carta'),
                onChanged: (value) => numeroCarta = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il numero della carta è obbligatorio.';
                  }
                  if (!isValidCardNumber(value)) {
                    return 'Il numero della carta deve essere composto da 16 cifre.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tipo Account'),
                onChanged: (value) => tipoAccount = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il tipo di account è obbligatorio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'IBAN'),
                onChanged: (value) => iban = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'L\'IBAN è obbligatorio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tipo di Carta'),
                onChanged: (value) => tipoCarta = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il tipo di carta è obbligatorio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Circuito'),
                onChanged: (value) => circuito = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il circuito è obbligatorio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                      Carta newCard = Carta(
                        cardId: cardId,
                        scadenzaCarta: scadenzaCarta,
                        saldoCarta: saldoCarta,
                        numeroCarta: numeroCarta,
                        tipoAccount: tipoAccount,
                        iban: iban,
                        tipoCarta: tipoCarta,
                        circuito: circuito,
                      );

                      Navigator.pop(
                          context, newCard); 
                    }
                  },
                  child: const Text('Salva Carta'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
