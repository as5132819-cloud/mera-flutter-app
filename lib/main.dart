import 'package:flutter/material.dart';

void main() => runApp(const WelcomeApp());

class WelcomeApp extends StatelessWidget {
  const WelcomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // Controller: Ye user ke likhe hue text ko pakad kar rakhta hai
  final TextEditingController _nameController = TextEditingController();
  String _greetingMessage = "";

  void _sayHello() {
    setState(() {
      if (_nameController.text.isEmpty) {
        _greetingMessage = "Pehle apna naam toh likhiye!";
      } else {
        _greetingMessage = "Namaste, ${_nameController.text}! \nKaise hain aap?";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome App')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Apna Naam Yahan Likhein:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 15),
            
            // Input Box
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Jaise: Rahul',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Button
            ElevatedButton(
              onPressed: _sayHello,
              style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
              child: const Text('Magic Dekhein'),
            ),
            
            const SizedBox(height: 40),
            
            // Output Message
            Text(
              _greetingMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
