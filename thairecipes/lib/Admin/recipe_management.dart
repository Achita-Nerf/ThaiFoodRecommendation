import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeManagementPage extends StatefulWidget {
  const RecipeManagementPage({Key? key}) : super(key: key);

  @override
  State<RecipeManagementPage> createState() => _RecipeManagementPageState();
}

class _RecipeManagementPageState extends State<RecipeManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get _recipesStream =>
      _firestore.collection('recipes').snapshots();

  Future<void> _addRecipe() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ingredientsController = TextEditingController();
    final TextEditingController instructionsController = TextEditingController();
    final TextEditingController cookingTimeController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('เพิ่มสูตรอาหาร', style: TextStyle(fontFamily: 'Sarabun')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'ชื่อเมนู'),
              ),
              TextField(
                controller: ingredientsController,
                decoration: const InputDecoration(labelText: 'วัตถุดิบ'),
                maxLines: 3,
              ),
              TextField(
                controller: instructionsController,
                decoration: const InputDecoration(labelText: 'วิธีทำ'),
                maxLines: 5,
              ),
              TextField(
                controller: cookingTimeController,
                decoration: const InputDecoration(labelText: 'เวลาในการทำ (นาที)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _firestore.collection('recipes').add({
                  'name': nameController.text,
                  'ingredients': ingredientsController.text,
                  'instructions': instructionsController.text,
                  'cookingTime': int.tryParse(cookingTimeController.text) ?? 0,
                  'createdAt': FieldValue.serverTimestamp(),
                });
                if (mounted) Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
                );
              }
            },
            child: const Text('เพิ่ม'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดการสูตรอาหาร', style: TextStyle(fontFamily: 'Sarabun')),
        backgroundColor: const Color(0xFFB848FC),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _recipesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name'] ?? 'ไม่มีชื่อ', style: const TextStyle(fontFamily: 'Sarabun')),
                subtitle: Text('เวลาทำ: ${data['cookingTime'] ?? 0} นาที', style: const TextStyle(fontFamily: 'Sarabun')),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteRecipe(doc),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecipe,
        backgroundColor: const Color(0xFFB848FC),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _deleteRecipe(DocumentSnapshot doc) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: Text('คุณต้องการลบสูตรอาหาร ${doc['name']} ใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await doc.reference.delete();
                if (mounted) Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
                );
              }
            },
            child: const Text('ลบ'),
          ),
        ],
      ),
    );
  }
}
