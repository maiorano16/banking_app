class Data {
  final String month;
  final int value;

  Data({required this.month, required this.value});

  // Metodo per creare un oggetto Data da un Map (dati JSON)
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      month: json['month'],
      value: json['value'],
    );
  }

  // Metodo per convertire un oggetto Data in Map (per serializzazione)
  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'value': value,
    };
  }
}

class ChartData {
  final List<Data> data;

  ChartData({required this.data});

  // Metodo per creare un oggetto ChartData da un Map (dati JSON)
  factory ChartData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return ChartData(
      data: dataList,
    );
  }

  // Metodo per convertire un oggetto ChartData in Map (per serializzazione)
  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
