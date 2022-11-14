import 'dart:async';

import 'package:newdemo/stream/base.dart';
import 'package:newdemo/model/todo/todo.dart';
import 'package:rxdart/streams.dart';

class SingleController {
  SingleController._();
  factory SingleController.getInstance() => SingleController._();

  final todos = BaseController<List<Todo>>([].cast<Todo>());

  final userEmail = BaseController<String?>(null);
  final passwordEmail = BaseController<String?>(null);
  final todoHeader = BaseController<String?>(null);
  final todoBody = BaseController<String?>(null);
}

class CombinedController extends SingleController {
  CombinedController() : super._();
  Stream<Map<String, String>?> get loginFormValues =>
      CombineLatestStream.combine2(
        userEmail.bStream.transform<String?>(StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            if (!(data != null && data.isNotEmpty && data.contains("@"))) {
              sink.addError("email format invalidW: not added data to stream");
            } else {
              sink.add(data);
            }
          },
        )),
        passwordEmail.bStream.transform<String?>(StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            if (!(data != null && data.isNotEmpty && data.length > 6)) {
              sink.addError(
                  "password format invalidW: not added data to stream");
            } else {
              sink.add(data);
            }
          },
        )),
        (a, b) {
          return {
            "email": a ?? "",
            "password": b ?? "",
          };
        },
      );

  Stream<Todo> get todoFormValues => CombineLatestStream.combine2(
        todoHeader.bStream,
        todoBody.bStream,
        (a, b) => Todo(header: a ?? "", body: b ?? ""),
      );
}
