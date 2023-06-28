import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Screen1(),
    const Screen2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SegmentedButton Navigation Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SegmentedButton<int>(
              selected: {_selectedIndex},
              segments: const [
                ButtonSegment(
                  value: 1,
                  label: Text('Screen1'),
                  enabled: true,
                ),
                ButtonSegment(
                  value: 2,
                  label: Text('Screen2'),
                  enabled: true,
                ),
              ],
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedIndex = newSelection.first;
                });
              },
            ),
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Screen1'),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Screen2'),
    );
  }
}
