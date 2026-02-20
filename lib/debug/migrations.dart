import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/utils/search_index.dart';

// List<String> buildSearchIndex(String text) {
//   final lower = text.toLowerCase();
//   final index = <String>[];

//   for (int i = 1; i <= lower.length; i++) {
//     index.add(lower.substring(0, i));
//   }

//   return index;
// }

Future<void> rebuildSearchIndexes() async {
  final snap =
      await FirebaseFirestore.instance.collection('users').get();

  for (final doc in snap.docs) {
    final data = doc.data();

    final index = [
      ...buildSearchIndex(data['username'] ?? ''),
      ...buildSearchIndex(data['firstName'] ?? ''),
      ...buildSearchIndex(data['lastName'] ?? ''),
      ...buildSearchIndex(data['email'] ?? ''),
    ];

    await doc.reference.update({'searchIndex': index});
  }

  print('✅ Firestore searchIndex rebuilt for ${snap.docs.length} users');
}