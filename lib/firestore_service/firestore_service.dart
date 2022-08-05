import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weight_app/utils/constants.dart';

import '../models/weight_model.dart';
import '../widgets/toast.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addItem(WeightModel weightModel) async {
    weightModel.uid = FirebaseAuth.instance.currentUser!.uid;
    weightModel.docID = getRandomString(25);
    try {
      await _firestore
          .doc('weight/${weightModel.docID}')
          .set(weightModel.toMap());
    } on FirebaseException catch (e) {
      ToastOverlay().showToast(e.code);
      debugPrint(e.message);
    }
  }

  Future<void> updateWeight(WeightModel weightModel) async {
    try {
      await _firestore
          .doc('weight/${weightModel.docID}')
          .update(weightModel.toMap());
      ToastOverlay().showToast('Updated');
    } on FirebaseException catch (e) {
      ToastOverlay().showToast('cant update weight ${e.code}');

    }
  }

  Future<void> deleteWeight(WeightModel weightModel) async {
    try {
      await _firestore.doc('weight/${weightModel.docID}').delete();
      ToastOverlay().showToast('Deleted');
    } on FirebaseException catch (e) {
      ToastOverlay().showToast('cant delete ${e.code}');
    }
  }

}
