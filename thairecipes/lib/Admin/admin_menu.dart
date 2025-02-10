import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับการตั้งค่า status bar
import 'user_management.dart'; // นำเข้าหน้าจัดการผู้ใช้
import 'recipe_management.dart';

class AdminMenu extends StatelessWidget {
  const AdminMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // ตั้งค่า status bar ให้เป็นสีขาวและ icon เป็นสีดำ
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFFB848FC), // สีเดียวกับพื้นหลัง
        statusBarIconBrightness: Brightness.light, // ไอคอน status bar สีขาว
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFB848FC), // ตั้งค่าพื้นหลังเป็นสี B848FC
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Admin ด้านบน
            Icon(
              Icons.admin_panel_settings,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            // ข้อความ "ผู้ดูแลระบบ"
            Text(
              'ผู้ดูแลระบบ',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            // ปุ่ม "จัดการผู้ใช้"
            ElevatedButton(
              onPressed: () {
                // เพิ่มการนำทางไปยังหน้าจัดการผู้ใช้
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserManagement()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.white,
              ),
              child: Text(
                'จัดการผู้ใช้',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFB848FC),
                ),
              ),
            ),
            SizedBox(height: 20),
            // ปุ่ม "จัดการสูตรอาหาร"
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecipeManagementPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.white,
              ),
              child: Text(
                'จัดการสูตรอาหาร',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFB848FC),
                ),
              ),
            ),
            SizedBox(height: 40),
            // ปุ่ม "ออกจากระบบ"
            ElevatedButton(
              onPressed: () {
                // เพิ่มฟังก์ชันการออกจากระบบ
                // เช่น การลบข้อมูลผู้ใช้หรือการนำทางกลับไปที่หน้าล็อกอิน
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.red,
              ),
              child: Text(
                'ออกจากระบบ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}