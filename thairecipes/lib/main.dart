import 'package:flutter/material.dart';
import 'Admin/admin_menu.dart'; // นำเข้าไฟล์ admin_menu.dart จากโฟลเดอร์ Admin
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Menu',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: AdminMenu(), // เรียกหน้า AdminMenu
    );
  }
}