import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newdemo/stream/stream_controller.dart';

import '../model/todo/todo.dart';

class CrudMain {
  final CombinedController combinedController;
  final FirebaseFirestore ins = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get collection =>
      ins.collection("todos");

  Stream<QuerySnapshot<Todo>> get collectionStream => collection
      .withConverter<Todo>(
        fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
        toFirestore: (todo, _) => todo.toJson(),
      )
      .snapshots();

  late var body = <String, dynamic>{};
  User? user;

  CrudMain._({required this.combinedController, this.user}) {
    combinedController.todoFormValues
        .listen((Todo todo) => body = todo.toJson());
  }

  factory CrudMain.getInstance(
          {required CombinedController combinedController, User? user}) =>
      CrudMain._(combinedController: combinedController, user: user);

  Future<void> postTodo() async {
    await collection.add({
      ...body,
      "uid": user?.uid ?? "",
    }).catchError(
      (e) => throw Exception("Err: Add Todo"),
    );
  }

  Future<String> getDocIdByFilters(String header) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        await collection
            .where("uid", isEqualTo: user?.uid) // search writer's docs
            .where("header", isEqualTo: header) // search header == header
            .get()
            .then((value) => value.docs);
    return docs.first.id;
  }

  Future<void> delete(String header) async {
    final docId = await getDocIdByFilters(header);
    await collection
        .doc(docId)
        .delete()
        .catchError((e) => throw Exception("Err: Delete Todo"));
  }

  Future<void> update(String header) async {
    final docId = await getDocIdByFilters(header);
    final doc = collection.doc(docId);

    final bool isCompletedStatus =
        await doc.get().then((d) => d.data()!["isCompleted"]);
    await doc.update(
      {"isCompleted": !isCompletedStatus},
    ).catchError((e) => Exception("Err: Update Todo"));
  }
}
