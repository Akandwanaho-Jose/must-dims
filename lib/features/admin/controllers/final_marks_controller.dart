import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../results/final_marks_model.dart';

final finalMarksProvider = StreamProvider<List<FinalMarksModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('finalMarks')
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => FinalMarksModel.fromFirestore(doc, null))
            .toList(),
      );
});
