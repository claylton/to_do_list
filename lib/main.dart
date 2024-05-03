import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void removeTask(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  Future<void> loadTask() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> listItems = decoded.map((item) => Item.fromJson(item)).toList();

      setState(() {
        widget.items = listItems;
      });
    }
  }

  _HomePageState() {
    loadTask();
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

            return Dismissible(
              key: Key(item.title),
              background: Container(
                color: Colors.red.withOpacity(0.2),
              ),
              child: CheckboxListTile(
                title: Text(item.title),
                value: item.done,
                onChanged: (value) => setState(() => item.done = value ?? false),
              ),
              onDismissed: (direction) => removeTask(index),
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
