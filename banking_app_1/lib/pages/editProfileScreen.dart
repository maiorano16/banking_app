import 'package:banking_app_1/utility/validations_utils.dart';
import 'package:flutter/material.dart';
import 'package:banking_app_1/models/user_model.dart';
import 'package:banking_app_1/widgets/custom_text_field.dart';
import 'package:banking_app_1/widgets/save_button.dart';

class EditProfileScreen extends StatefulWidget {
  final Utenti user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late String nome;
  late String cognome;
  late String residenza;
  late String professione;
  late String dataNascita;
  late String luogoNascita;
  late String gender;

  @override
  void initState() {
    super.initState();
    nome = widget.user.nome;
    cognome = widget.user.cognome;
    residenza = widget.user.residenza;
    professione = widget.user.professione;
    dataNascita = widget.user.dataNascita;
    luogoNascita = widget.user.luogoNascita;
    gender = widget.user.sesso;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica Profilo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Nome',
                  initialValue: nome,
                  onChanged: (value) => nome = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Il nome è obbligatorio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Cognome',
                  initialValue: cognome,
                  onChanged: (value) => cognome = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Il cognome è obbligatorio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Residenza',
                  initialValue: residenza,
                  onChanged: (value) => residenza = value,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Professione',
                  initialValue: professione,
                  onChanged: (value) => professione = value,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Luogo di nascita',
                  initialValue: luogoNascita,
                  onChanged: (value) => luogoNascita = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Il luogo di nascita è obbligatorio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Data di nascita (aaaa-mm-gg)',
                  initialValue: dataNascita,
                  onChanged: (value) {
                    if (ValidationUtils.validateDateFormat(value)) {
                      setState(() {
                        dataNascita = value;
                        widget.user.eta = ValidationUtils.calculateAge(value);
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La data di nascita è obbligatoria.';
                    } else if (!ValidationUtils.validateDateFormat(value)) {
                      return 'Formato data non valido (usa aaaa-mm-gg).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: const InputDecoration(labelText: 'Sesso'),
                  items: ['Maschio', 'Femmina', 'Altro']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      gender = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Seleziona il sesso.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SaveButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(
                        context,
                        Utenti(
                          nome: nome,
                          cognome: cognome,
                          residenza: residenza,
                          professione: professione,
                          eta: ValidationUtils.calculateAge(dataNascita),
                          sesso: gender,
                          dataNascita: dataNascita,
                          luogoNascita: luogoNascita,
                          userId: widget.user.userId,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
