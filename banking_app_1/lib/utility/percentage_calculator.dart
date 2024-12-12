import 'package:banking_app_1/models/balance_model.dart';

List<double> calculatePercentages(Balance balance) {
  double total = balance.totalMoneyInBank + balance.totalSavings + balance.cost;
  double moneyInBankPercentage = balance.totalMoneyInBank / total * 100;
  double incomePercentage = balance.income / total * 100;
  double costPercentage = balance.cost / total * 100;
  double savingsPercentage = balance.totalSavings / total * 100;

  return [
    moneyInBankPercentage,
    incomePercentage,
    savingsPercentage,
    costPercentage
  ];
}
