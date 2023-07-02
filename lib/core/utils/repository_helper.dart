class RepositoryHelper {

  static Map<String, int> sortedByCount(Map<String, int> map) {
    List<MapEntry<String, int>> entryList = map.entries.toList();
    entryList.sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(entryList);
  }
}
