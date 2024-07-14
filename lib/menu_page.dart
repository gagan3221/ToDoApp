import 'package:flutter/material.dart';
import 'package:todoapp/to_do_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDoApp",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Container(
          height: 90,
          width: 120,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.purple)),
            child: Text(
              "Start App",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ToDoPage(),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
