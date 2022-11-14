import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newdemo/repository/crud.dart';
import '../model/todo/todo.dart';

import '../repository/auth.dart';
import '../stream/stream_controller.dart';

final combinedControllerProvider = Provider<CombinedController>(
  (ref) => CombinedController(),
);

final authProvider = Provider<AuthMain>(
  (ref) {
    final combinedController = ref.watch(combinedControllerProvider);
    return AuthMain.getInstance(combinedController: combinedController);
  },
);

final crudProvider = Provider<CrudMain>(
  (ref) {
    final combinedController = ref.watch(combinedControllerProvider);
    final User? user = ref.watch(authProvider).currUser;
    return CrudMain.getInstance(
        combinedController: combinedController, user: user);
  },
);

final userExistStreamProvider = StreamProvider<User?>(
  (ref) async* {
    yield* ref.watch(authProvider).userExistStream;
  },
);

final collectionStreamProvider =
    StreamProvider<QuerySnapshot<Todo>>((ref) async* {
  yield* ref.watch(crudProvider).collectionStream;
});
