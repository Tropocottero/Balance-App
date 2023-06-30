import 'package:flutter/material.dart';
import 'package:balance/HomeButtonMenu.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balance',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const MyHomePage(title: 'Balance'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),


      // TODO Drawer con la navigazione verso le varie pagine


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO Inserire la generazione delle card Trasanzioni
            Container()
          ]
        ),
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: (){
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => PopupMenuHome()
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
