import 'package:flutter/material.dart';

void main() => runApp(const TaskManagerApp());

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

// Model Class: Ye batayega ki task ka naam kya hai aur wo khatam hua ya nahi
class Task {
  String title;
  bool isDone;
  Task({required this.title, this.isDone = false});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. PEHLE SE LIKHE TASKS HATA DIYE (Ab ye khali shuru hoga)
  List<Task> myTasks = []; 

  void _addNewTask(String title) {
    setState(() {
      myTasks.add(Task(title: title)); // Naya task hamesha 'isDone = false' ke saath aayega
    });
  }

  // 2. DELETE FUNCTION: List se task hatane ke liye
  void _deleteTask(int index) {
    setState(() {
      myTasks.removeAt(index);
    });
  }

  // 3. TOGGLE FUNCTION: Tick mark lagane ya hatane ke liye
  void _toggleTask(int index) {
    setState(() {
      myTasks[index].isDone = !myTasks[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Smart Tasks')),
      body: myTasks.isEmpty 
        ? const Center(child: Text('Koi task nahi hai. + dabayein!'))
        : ListView.builder(
            itemCount: myTasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                // Leading: Yahan tick karne ka logic hai
                leading: IconButton(
                  icon: Icon(
                    myTasks[index].isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: myTasks[index].isDone ? Colors.green : Colors.grey,
                  ),
                  onPressed: () => _toggleTask(index),
                ),
                title: Text(
                  myTasks[index].title,
                  style: TextStyle(
                    decoration: myTasks[index].isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                // Trailing: DELETE BUTTON yahan lagaya hai
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteTask(index),
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          if (result != null) _addNewTask(result);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// --- ADD TASK SCREEN (Wahi purani wali) ---
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(labelText: 'Kya kaam hai?', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, _taskController.text),
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
