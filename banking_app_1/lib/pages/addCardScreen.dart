import 'package:banking_app_1/utility/validations_utils.dart';
import 'package:banking_app_1/widgets/input_field.dart';
import 'package:banking_app_1/widgets/save_button.dart';
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
              InputField(
                labelText: 'ID Carta',
                onChanged: (value) => cardId = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'L\'ID della carta è obbligatorio.';
                  }
                  return null;
                },
              ),
              InputField(
                labelText: 'Scadenza Carta (MM/YY)',
                onChanged: (value) => scadenzaCarta = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La data di scadenza è obbligatoria.';
                  }
                  if (!ValidationUtils.isValidExpirationDate(value)) {
                    return 'Inserisci una data di scadenza valida (MM/YY).';
                  }
                  return null;
                },
              ),
              InputField(
                labelText: 'Saldo Carta',
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
                keyboardType: TextInputType.number,
              ),
              InputField(
                labelText: 'Numero Carta',
                onChanged: (value) => numeroCarta = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Il numero della carta è obbligatorio.';
                  }
                  if (!ValidationUtils.isValidCardNumber(value)) {
                    return 'Il numero della carta deve essere composto da 16 cifre.';
                  }
                  return null;
                },
              ),
              InputField(
                labelText: 'Tipo Account',
                onChanged: (value) => tipoAccount = value,
                validator: (value) => value == null || value.isEmpty
                    ? 'Il tipo di account è obbligatorio.'
                    : null,
              ),
              InputField(
                labelText: 'IBAN',
                onChanged: (value) => iban = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'L\'IBAN è obbligatorio.' : null,
              ),
              InputField(
                labelText: 'Tipo di Carta',
                onChanged: (value) => tipoCarta = value,
                validator: (value) => value == null || value.isEmpty
                    ? 'Il tipo di carta è obbligatorio.'
                    : null,
              ),
              InputField(
                labelText: 'Circuito',
                onChanged: (value) => circuito = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Il circuito è obbligatorio.' : null,
              ),
              const SizedBox(height: 32),
              Center(
                child: SaveButton(
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
                      Navigator.pop(context, newCard);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
