import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/models/contact_model.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final List<Contact> _contacts = [
    const Contact(name: "John Doe", phoneNumber: "123-456-7890"),
    const Contact(name: "Jane Smith", phoneNumber: "987-654-3210"),
    const Contact(name: "Alice Johnson", phoneNumber: "555-555-5555"),
  ];

  int _counter = 1;

  void _addContact() {
    setState(() {
      _contacts.add(
        Contact(
          name: "New Contact $_counter",
          phoneNumber: "000-000-000$_counter",
        ),
      );
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Contacts',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),

        centerTitle: false,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade400, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  contact.name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  contact.phoneNumber,
                  style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) =>
            Container(margin: const EdgeInsets.symmetric(vertical: 5.0)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        tooltip: "Add Contact",
        child: const Icon(Icons.add),
      ),
    );
  }
}
