import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> saveScore(int score, int total) async {
    await _db.collection('scores').add({
      'score': score,
      'total': total,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<int>> fetchRecentScores() async {
    final snap = await _db
        .collection('scores')
        .orderBy('timestamp', descending: true)
        .limit(3)
        .get();
    return snap.docs.map((d) => d['score'] as int).toList();
  }

  Future<List<int>> fetchTopScores() async {
    final snap = await _db
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(3)
        .get();
    return snap.docs.map((d) => d['score'] as int).toList();
  }
}
