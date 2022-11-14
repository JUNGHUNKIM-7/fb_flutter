import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:newdemo/local/providers.dart';
import 'package:newdemo/stream/base.dart';
import 'package:newdemo/stream/stream_controller.dart';

class CrudPage extends ConsumerStatefulWidget {
  const CrudPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CrudPageState();
}

class _CrudPageState extends ConsumerState<CrudPage> {
  late TextEditingController _headerController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _headerController = TextEditingController();
    _bodyController = TextEditingController();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CombinedController combinedController =
        ref.watch(combinedControllerProvider);
    final crud = ref.watch(crudProvider);

    return Column(
      children: [
        TextField(
          controller: _headerController,
          onChanged: (String val) {
            receivingStrings(val, combinedController.todoHeader);
          },
        ),
        TextField(
          controller: _bodyController,
          onChanged: (String val) {
            receivingStrings(val, combinedController.todoBody);
          },
        ),
        ElevatedButton(
          onPressed: () async {
            await crud.postTodo();
          },
          child: Text(
            "add todo".toUpperCase(),
          ),
        ),
      ],
    );
  }

  void receivingStrings(String value, BaseController controller) {
    controller.setState = value;
  }
}
