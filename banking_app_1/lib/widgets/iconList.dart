import 'package:banking_app_1/models/balance_model.dart';
import 'package:banking_app_1/widgets/build_icon_with_text.dart';
import 'package:flutter/material.dart';

class IconList extends StatelessWidget {
  final Balance balance;

  const IconList({
    Key? key,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconWithText(
          text: 'In banca: \$${balance.totalMoneyInBank}',
          iconColor: Colors.blue,
        ),
        const SizedBox(height: 16),
        IconWithText(
          text: 'Entrate: \$${balance.income}',
          iconColor: const Color.fromARGB(255, 0, 255, 38),
        ),
        const SizedBox(height: 16),
        IconWithText(
          text: 'Risparmi: \$${balance.totalSavings}',
          iconColor: const Color.fromARGB(255, 212, 255, 0),
        ),
        const SizedBox(height: 16),
        IconWithText(
          text: 'Spese: \$${balance.cost}',
          iconColor: Colors.red,
        ),
      ],
    );
  }
}
