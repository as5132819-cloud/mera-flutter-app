import 'package:flutter/material.dart';

void main() => runApp(const MySmartApp());

class MySmartApp extends StatelessWidget {
  const MySmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo), // Naya Indigo theme
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _update(int val) {
    setState(() {
      if (val == 0) _counter = 0; // Reset
      else _counter += val;       // Add ya Subtract
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Counter Pro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Current Value:', style: TextStyle(fontSize: 20)),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 30), // Beech mein gap ke liye
            
            // Buttons ki Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minus Button
                ElevatedButton(
                  onPressed: () => _update(-1),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
                const SizedBox(width: 20),
                
                // Reset Button
                ElevatedButton(
                  onPressed: () => _update(0),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('RESET', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 20),
                
                // Plus Button
                ElevatedButton(
                  onPressed: () => _update(1),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
