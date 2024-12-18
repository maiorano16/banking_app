class ValidationUtils {
  
 static bool validateDateFormat(String date) {
  final parsedDate = DateTime.tryParse(date);
  return parsedDate != null && date == parsedDate.toIso8601String().split('T')[0];
}


  static int calculateAge(String birthDate) {
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

  static bool isValidExpirationDate(String date) {
    RegExp exp = RegExp(r"^(0[1-9]|1[0-2])\/([0-9]{2})$");
    return exp.hasMatch(date);
  }

  static bool isValidCardNumber(String number) {
    return number.length == 16 && RegExp(r'^\d+$').hasMatch(number);
  }
}

