import 'package:flutter/material.dart';
import 'package:ecoti_app_mobile/mvc/controller/controller.dart';
import 'package:ecoti_app_mobile/mvc/model/model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Controller controller = Controller(
    model: Model(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 125, 34, 1),
        centerTitle: false, // Centra el título en la AppBar
        title: const Text(
          'EcoTI Mobile',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text('Click the buttons to change the counter.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    setState(
                      controller.decrement,
                    );
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                Text(
                  controller.counter.toString(),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(
                      controller.increment,
                    );
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}