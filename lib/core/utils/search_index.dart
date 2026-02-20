/// Utility function to build a search index from a given text. 
/// This is used to create a list of all possible prefixes of the text,
/// which can be used for efficient searching.
List<String> buildSearchIndex(String text) {
  final lower = text.toLowerCase();
  List<String> index = [];

  for (int i = 1; i <= lower.length; i++) {
    index.add(lower.substring(0, i));
  }

  return index;
}
