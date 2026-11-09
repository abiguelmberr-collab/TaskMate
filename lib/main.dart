
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/task_provider.dart';

import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/task_list_screen.dart';

const Color primaryGreen = Color(0xFF234B3D);
const Color backgroundCream = Color(0xFFF7F6F0);
const Color accentGold = Color(0xFFE5AD54);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wvculzuztrzmnqvpxnps.supabase.co',
    publishableKey: 'YOUR_EXISTING_PUBLISHABLE_KEY',
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const TaskMateApp(),
    ),
  );
}

class TaskMateApp extends StatelessWidget {
  const TaskMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskMate',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundCream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    TaskListScreen(),
    StatisticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDCE9E1),
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
