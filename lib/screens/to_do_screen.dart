import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<Map<String, dynamic>> _tasks = [];

  final TextEditingController _taskController = TextEditingController();

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 20,
              child: SizedBox(
                height: 320,
                child: Image.asset(
                  'assets/yellow_icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Dialog box
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Хийх зүйл',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B506D),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _taskController,
                      decoration: const InputDecoration(
                        hintText: 'Бичих...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_taskController.text.isNotEmpty) {
                            setState(() {
                              _tasks.add({
                                'title': _taskController.text,
                                'completed': false,
                              });
                            });
                            _taskController.clear();
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3E7C78),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Болсон',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg_pattern_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.2),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To-Do List',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3B506D),
                          ),
                        ),
                        Text(
                          'Хийсэн ажлуудаа check-лээрэй ❤️',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF3B506D),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.settings, color: Colors.black54),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        value: true,
                        groupValue: _tasks[index]['completed'],
                        onChanged: (value) {
                          setState(() {
                            if (_tasks[index]['completed'] == true) {
                              _tasks[index]['completed'] = false;
                            } else {
                              _tasks[index]['completed'] = true;
                            }
                          });
                        },
                        title: Text(
                          _tasks[index]['title'],
                          style: TextStyle(
                            decoration: _tasks[index]['completed']
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: _tasks[index]['completed']
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        activeColor: const Color(0xFF3E7C78),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // dialog нэмэх button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3E7C78),
        onPressed: _showAddTaskDialog,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
