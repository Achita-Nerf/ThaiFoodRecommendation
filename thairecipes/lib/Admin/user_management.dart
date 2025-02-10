import 'package:flutter/material.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จัดการผู้ใช้'),
      ),
      body: Center(
        child: Text('หน้าจัดการผู้ใช้'),
      ),
    );
  }
}