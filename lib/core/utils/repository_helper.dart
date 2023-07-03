class RepositoryHelper {

  static Map<String, int> sortedByCount(Map<String, int> map) {
    List<MapEntry<String, int>> entryList = map.entries.toList();
    entryList.sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(entryList);
  }

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }

    String firstLetter = input[0].toUpperCase();
    String remainingLetters = input.substring(1).replaceAll("I", "ı").toLowerCase();

    return firstLetter + remainingLetters;
  }
}
