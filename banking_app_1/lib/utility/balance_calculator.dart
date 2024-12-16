import 'package:banking_app_1/models/balance_model.dart';
import 'package:banking_app_1/widgets/flippableCard.dart';

List<BalanceData> generateBalanceData(List<Balance> balances) {
  return balances.map((balance) {
    return BalanceData(
      balance.startPeriod,
      balance.finalPeriod,
      balance.income,
      balance.cost,
    );
  }).toList();
}
