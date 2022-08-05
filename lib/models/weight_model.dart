import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  String? docID;
  String? uid;
  Timestamp? createdAt;
  String? name;
  int? weight;


  WeightModel({
    this.createdAt,
    this.docID,
    this.uid,
    this.name,
    this.weight,
  });

  WeightModel.mapToDuel(Map<String, dynamic> map) {
    docID = map['docID'];
    uid = map['uid'];
    name = map['name'];
    createdAt = map['createdAt'];

    weight = map['times'];
  }

  Map<String, dynamic> toMap() {
    return {
      "docID": docID,
      "uid": uid,
      "name": name,
      "createdAt": createdAt,
      "times": weight,
    };
  }
}
