class ThaiNumberToText {
  ThaiNumberToText._();
  static String convert(String number) {
    number = number.replaceAll(RegExp(r'๐'), '0');
    number = number.replaceAll(RegExp(r'๑'), '1');
    number = number.replaceAll(RegExp(r'๒'), '2');
    number = number.replaceAll(RegExp(r'๓'), '3');
    number = number.replaceAll(RegExp(r'๔'), '4');
    number = number.replaceAll(RegExp(r'๕'), '5');
    number = number.replaceAll(RegExp(r'๖'), '6');
    number = number.replaceAll(RegExp(r'๗'), '7');
    number = number.replaceAll(RegExp(r'๘'), '8');
    number = number.replaceAll(RegExp(r'๙'), '9');

    //return number;
    return arabicNumberToText(number);
  }
}

String arabicNumberToText(String number) {
  String checkNumber = _checkNumber(number);
  List<String> numberArray = ["ศูนย์", "หนึ่ง", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า", "สิบ"];
  List<String> digitArray = ["", "สิบ", "ร้อย", "พัน", "หมื่น", "แสน", "ล้าน"];
  String bahtText = "";

  if (num.tryParse(checkNumber) == null) {
    return "ข้อมูลนำเข้าไม่ถูกต้อง";
  } else {
    double numVal = double.parse(checkNumber);
    if (numVal > 9999999.9999) {
      return "ข้อมูลนำเข้าเกินขอบเขตที่ตั้งไว้";
    } else {
      List<String> splitNum = checkNumber.split(".");
      if (splitNum[1].isNotEmpty) {
        splitNum[1] = splitNum[1].substring(0, 2);
      }
      int numberLen = splitNum[0].length;
      for (int i = 0; i < numberLen; i++) {
        int tmp = int.parse(splitNum[0][i]);
        if (tmp != 0) {
          if (i == (numberLen - 1) && tmp == 1) {
            bahtText += "เอ็ด";
          } else if (i == (numberLen - 2) && tmp == 2) {
            bahtText += "ยี่";
          } else if (i == (numberLen - 2) && tmp == 1) {
            bahtText += "";
          } else {
            bahtText += numberArray[tmp];
          }
          bahtText += digitArray[numberLen - i - 1];
        }
      }
      bahtText += "บาท";
      if (splitNum[1] == "0" || splitNum[1] == "00") {
        bahtText += "ถ้วน";
      } else {
        int decimalLen = splitNum[1].length;
        for (int i = 0; i < decimalLen; i++) {
          int tmp = int.parse(splitNum[1][i]);
          if (tmp != 0) {
            if (i == (decimalLen - 1) && tmp == 1) {
              bahtText += "เอ็ด";
            } else if (i == (decimalLen - 2) && tmp == 2) {
              bahtText += "ยี่";
            } else if (i == (decimalLen - 2) && tmp == 1) {
              bahtText += "";
            } else {
              bahtText += numberArray[tmp];
            }
            bahtText += digitArray[decimalLen - i - 1];
          }
        }
        bahtText += "สตางค์";
      }
      return bahtText;
    }
  }
}

String _checkNumber(String number) {
  bool decimal = false;
  number = number.toString().replaceAll(RegExp(r" |,|บาท|฿"), '');
  for (int i = 0; i < number.length; i++) {
    if (number[i] == '.') {
      decimal = true;
    }
  }
  if (!decimal) {
    number = "$number.00";
  }
  return number;
}
