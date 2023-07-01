class ControlHelper {
  static bool checkMapValue(Map<String, dynamic> map, String checkValue) {
    return map.containsKey(checkValue) &&
        map[checkValue] != null &&
        map[checkValue].toString().trim().isNotEmpty;
  }

  static dynamic checkInputValue(dynamic checkValue) {
    if (checkValue != null && checkValue.toString().trim().isNotEmpty) {
      return checkValue;
    } else {
      return "";
    }
  }
}
