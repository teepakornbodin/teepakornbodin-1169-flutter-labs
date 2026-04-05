// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-03-18

// แอปจัดการรายชื่อผู้ติดต่อโดยใช้การจัดเก็บไฟล์ในเครื่อง
// ใช้ path_provider หาโฟลเดอร์เอกสารของแอป และ dart:io อ่าน/เขียน JSON
// โหลดรายชื่อที่บันทึกไว้เมื่อเริ่มแอป และบันทึกทุกครั้งที่เพิ่มรายชื่อใหม่

// Logic:
// - _loadContacts() เรียกใน initState() อ่านไฟล์ contacts.json ถ้ามีอยู่
//   แปลง JSON list เป็น List<Contact> พร้อม try/catch ถ้าไฟล์ไม่มีก็เริ่มด้วย list ว่าง
// - _saveContacts() เขียน contacts list ทั้งหมดเป็น JSON array ทุกครั้งที่เพิ่มรายชื่อ
//   ใช้ try/catch และแสดง SnackBar เมื่อเกิดข้อผิดพลาด
// - ปุ่ม Save Contact ตรวจสอบว่าทุก field ไม่ว่างก่อนบันทึก
//   แสดง SnackBar เมื่อบันทึกสำเร็จ และล้าง field หลังบันทึก

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'models/contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const ContactManagerScreen(),
    );
  }
}

class ContactManagerScreen extends StatefulWidget {
  const ContactManagerScreen({super.key});

  @override
  State<ContactManagerScreen> createState() => _ContactManagerScreenState();
}

class _ContactManagerScreenState extends State<ContactManagerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/contacts.json');
  }

  Future<void> _loadContacts() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(contents);
        setState(() {
          _contacts = jsonList
              .map((json) => Contact.fromJson(json as Map<String, dynamic>))
              .toList();
        });
      }
    } catch (e) {
      // ถ้าไฟล์ไม่มีหรืออ่านไม่ได้ เริ่มด้วย list ว่างโดยไม่ crash
    }
  }

  Future<void> _saveContacts() async {
    try {
      final file = await _localFile;
      final jsonList = _contacts.map((c) => c.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving contacts: $e')),
        );
      }
    }
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final contact = Contact(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
      );

      setState(() {
        _contacts.add(contact);
      });

      _saveContacts();

      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Manager'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveContact,
                    child: const Text('Save Contact'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text('${contact.phone}\n${contact.email}'),
                    isThreeLine: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
