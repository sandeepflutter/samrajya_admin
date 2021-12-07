import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance.collection("Elec").add(blogData).catchError((e) {
      print(e);
    });
  }

  Future<void> addData1(blogData) async {
    FirebaseFirestore.instance.collection("Mech").add(blogData).catchError((e) {
      print(e);
    });
  }

  Future<void> addData2(blogData) async {
    FirebaseFirestore.instance.collection("Indus").add(blogData).catchError((e) {
      print(e);
    });
  }

  Future<void> addData3(blogData) async {
    FirebaseFirestore.instance.collection("Slide").add(blogData).catchError((e) {
      print(e);
    });
  }

  Future<void> addData4(blogData) async {
    FirebaseFirestore.instance.collection("Offer").add(blogData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("Elec").snapshots();
  }

  getData1() async {
    return await FirebaseFirestore.instance.collection("Mech").snapshots();
  }
  getData2() async {
    return await FirebaseFirestore.instance.collection("Indus").snapshots();
  }
}

getData3() async {
  return await FirebaseFirestore.instance.collection("Slide").snapshots();
}

getData4() async {
  return await FirebaseFirestore.instance.collection("Offer").snapshots();
}
