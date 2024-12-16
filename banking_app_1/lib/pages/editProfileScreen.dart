import 'package:flutter/material.dart';
import 'package:banking_app_1/models/user_model.dart';

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

  bool _validateDateFormat(String date) {
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(date)) {
      return false; 
    }

    try {
      final parts = date.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      final parsedDate = DateTime(year, month, day);

      if (parsedDate.year != year ||
          parsedDate.month != month ||
          parsedDate.day != day) {
        return false;
      }

      return true;
    } catch (e) {
      return false; 
    }
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
                TextFormField(
                  initialValue: nome,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  onChanged: (value) => nome = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Il nome è obbligatorio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: cognome,
                  decoration: const InputDecoration(labelText: 'Cognome'),
                  onChanged: (value) => cognome = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Il cognome è obbligatorio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: residenza,
                  decoration: const InputDecoration(labelText: 'Residenza'),
                  onChanged: (value) => residenza = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: professione,
                  decoration: const InputDecoration(labelText: 'Professione'),
                  onChanged: (value) => professione = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: luogoNascita,
                  decoration:
                      const InputDecoration(labelText: 'Luogo di nascita'),
                  onChanged: (value) => luogoNascita = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Il luogo di nascita è obbligatorio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: dataNascita,
                  decoration: const InputDecoration(
                      labelText: 'Data di nascita (aaaa-mm-gg)'),
                  onChanged: (value) {
                    if (_validateDateFormat(value)) {
                      setState(() {
                        dataNascita = value;
                        widget.user.eta = _calculateAge(value);
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La data di nascita è obbligatoria.';
                    } else if (!_validateDateFormat(value)) {
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
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          Utenti(
                            nome: nome,
                            cognome: cognome,
                            residenza: residenza,
                            professione: professione,
                            eta: _calculateAge(
                                dataNascita),
                            sesso: gender,
                            dataNascita: dataNascita,
                            luogoNascita: luogoNascita,
                            userId: widget.user.userId,
                          ),
                        );
                      }
                    },
                    child: const Text('Salva'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _calculateAge(String birthDate) {
    final parts = birthDate.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    final birthDateTime = DateTime(year, month, day);
    final today = DateTime.now();

    int age = today.year - birthDateTime.year;

    if (today.month < birthDateTime.month ||
        (today.month == birthDateTime.month && today.day < birthDateTime.day)) {
      age--;
    }

    return age;
  }
}

bool _validateDateFormat(String date) {
  final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  if (!dateRegex.hasMatch(date)) return false;

  try {
    final parts = date.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    final dateTime = DateTime(year, month, day);
    return dateTime.year == year &&
        dateTime.month == month &&
        dateTime.day == day;
  } catch (e) {
    return false;
  }
}
