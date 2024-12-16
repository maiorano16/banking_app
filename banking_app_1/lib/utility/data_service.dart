import 'package:banking_app_1/models/balance_model.dart';

Future<List<Balance>> loadBalanceData() async {
  return await loadBalanceFromJson();
}
