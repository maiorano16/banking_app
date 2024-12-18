import 'package:banking_app_1/models/user_model.dart';
import 'package:banking_app_1/pages/editProfileScreen.dart';
import 'package:banking_app_1/widgets/user_info.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<Utenti>> utentiFuture;
  bool showMoreInfo = false;

  @override
  void initState() {
    super.initState();
    utentiFuture = loadUtentiFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          FutureBuilder<List<Utenti>>(
            future: utentiFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data!.isNotEmpty) {
                final Utenti user = snapshot.data!.first;
                return IconButton(
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
                        utentiFuture = Future.value([updatedUser]);
                      });
                    }
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: FutureBuilder<List<Utenti>>(
        future: utentiFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nessun utente trovato.'));
          } else {
            final Utenti user = snapshot.data!.first;
            return SingleChildScrollView(
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
            );
          }
        },
      ),
    );
  }
}
