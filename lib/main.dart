import 'package:flutter/material.dart';

void main() => runApp(const TaskManagerApp());

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(), // App yahan se shuru hogi
    );
  }
}

// ==========================================
// SCREEN 1: HOME SCREEN (Saari list yahan dikhegi)
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Ye hai hamari list jisme saare kaam save honge
  List<String> tasks = ["Flutter Seekhna", "GitHub Action Setup", "Naya APK Banana"];

  // FUNCTION: Naya task list mein jodne ke liye
  void _addNewTask(String taskTitle) {
    setState(() {
      tasks.add(taskTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      
      // Agar list khali hai toh message dikhao, nahi toh list dikhao
      body: tasks.isEmpty 
        ? const Center(child: Text('Abhi koi kaam nahi hai!'))
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(tasks[index]),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                
                // FUNCTION: Task par click karne se SCREEN 3 par jana
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(taskName: tasks[index]),
                    ),
                  );
                },
              );
            },
          ),

      // BUTTON: Plus button dabane par SCREEN 2 par jana
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // SCREEN 2 se wapas aane par result ka wait karna
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          // Agar user ne naya task likha hai, toh use list mein add karo
          if (result != null) _addNewTask(result);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ==========================================
// SCREEN 2: ADD TASK SCREEN (Naya kaam likhne ke liye)
// ==========================================
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Controller: Likhne wale box ke text ko control karne ke liye
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
              decoration: const InputDecoration(
                labelText: 'Task ka naam likhein',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            
            // FUNCTION: Save button dabane par wapas SCREEN 1 par jana data lekar
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  Navigator.pop(context, _taskController.text);
                }
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 3: DETAIL SCREEN (Task ki detail dekhne ke liye)
// ==========================================
class DetailScreen extends StatelessWidget {
  final String taskName; // Pehli screen se aya hua data

  const DetailScreen({super.key, required this.taskName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.assignment, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Aapka Task:',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Text(
              taskName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            
            // FUNCTION: Piche jane ke liye button
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.backspace),
              label: const Text('Wapas Jayein'),
            )
          ],
        ),
      ),
    );
  }
}
