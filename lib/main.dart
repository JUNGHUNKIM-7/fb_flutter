import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:newdemo/local/providers.dart';
import 'components/crud.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/todo/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user$ = ref.watch(userExistStreamProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(12),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
      home: user$.when(
        data: (User? u$) => u$ != null
            ? const App()
            : GestureDetector(
                onTap: () => FocusScope.of(context).focusedChild?.unfocus(),
                child: const SignInScreen(
                  providerConfigs: [
                    EmailProviderConfiguration(),
                  ],
                ),
              ),
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  static final List<Widget> homes = [
    const TodoList(),
    const CrudPage(),
    const Home3()
  ];

  static const List<Widget> tabs = [
    Tab(icon: Icon(Icons.abc, size: 40), text: "1"),
    Tab(icon: Icon(Icons.abc, size: 40), text: "2"),
    Tab(icon: Icon(Icons.abc, size: 40), text: "3"),
  ];

  @override
  ConsumerState createState() => _AppState();
}

class _AppState extends ConsumerState<App> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: App.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: App.homes.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              for (Widget t in App.tabs) t,
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            for (Widget h in App.homes) h,
          ],
        ),
      ),
    );
  }
}

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection$ = ref.watch(collectionStreamProvider);
    final crud = ref.watch(crudProvider);

    return collection$.when(
      data: (QuerySnapshot c$) {
        return ListView.builder(
          itemCount: c$.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot doc = c$.docs[index];
            final Todo data = doc.data() as Todo;
            return GestureDetector(
              onLongPress: () async {
                await crud.update(data.header);
              },
              onTap: () async {
                await crud.delete(data.header);
              },
              child: ListTile(
                title: Text(data.header),
                subtitle: Text(data.body),
                trailing: Text("${data.isCompleted}"),
              ),
            );
          },
        );
      },
      error: (err, stk) => Text('$err: $stk'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class Home3 extends StatelessWidget {
  const Home3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("hello"),
      ],
    );
  }
}
