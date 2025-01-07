import 'package:banking_app_1/models/user_model.dart';
import 'package:banking_app_1/pages/editProfileScreen.dart';
import 'package:banking_app_1/profileSection/user_info.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Utenti user; // La variabile `user` deve essere inizializzata
  bool isLoading = true; // Flag per indicare se i dati sono in fase di caricamento

  @override
  void initState() {
    super.initState();
    // Carica l'utente all'interno di `initState()`
    loadUtentiFromJson().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          user = value.first; // Inizializza l'utente
          isLoading = false;  // Imposta `isLoading` a false quando i dati sono caricati
        });
      } else {
        setState(() {
          isLoading = false;  // Se non ci sono utenti, termina comunque il caricamento
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          isLoading
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final updatedUser = await Navigator.push<Utenti>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(user: user),
                      ),
                    );

                    if (updatedUser != null) {
                      setState(() {
                        user = updatedUser; // Aggiorna l'utente
                      });
                    }
                  },
                ),
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Mostra un caricamento finché i dati non sono pronti
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfoSection(user: user),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
