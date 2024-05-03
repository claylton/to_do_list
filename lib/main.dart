import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  List<Item> items = <Item>[];

  HomePage({super.key}) {
    items.add(Item(title: 'Item 1', done: false));
    items.add(Item(title: 'Item 2', done: true));
    items.add(Item(title: 'Item 3', done: false));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newTaskController = TextEditingController();

  void addTask() {
    if (newTaskController.text.isNotEmpty) {
      setState(() {
        widget.items.add(Item(title: newTaskController.text, done: false));
        newTaskController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: newTaskController,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            decoration: const InputDecoration(
              labelText: 'Nova Tarefa',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.items[index];

            return CheckboxListTile(
              title: Text(item.title),
              key: Key(item.title),
              value: item.done,
              onChanged: (value) => setState(() => item.done = value ?? false),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addTask,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ));
  }
}
