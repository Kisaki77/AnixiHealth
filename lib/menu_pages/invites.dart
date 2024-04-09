import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import '../pages/newfeed.dart';

class Myinvites extends StatelessWidget {
  const Myinvites({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4D6159),
        title: const Text(
          'INVITES',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsFeedPage()),
            );
          },
          child: Image.asset(
            'assets/images/back.png',
            width: 20,
            height: 20,
          ),
        ),
      ),
      body: MyInvitesBody(),
    );
  }
}

class MyInvitesBody extends StatefulWidget {
  @override
  _MyInvitesBodyState createState() => _MyInvitesBodyState();
}

class _MyInvitesBodyState extends State<MyInvitesBody> {
  late Iterable<Contact> _contacts; // Initialize with an empty iterable
  late List<Contact> _filteredContacts;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _contacts = [];
    _filteredContacts = [];
    _searchController = TextEditingController();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    // Request permissions to access contacts if not granted already
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      // Permission granted, retrieve contacts
      final contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
        _filteredContacts = List.from(contacts);
      });
    } else {
      // Permission denied, handle accordingly
    }
  }

  void _filterContacts(String query) {
    List<Contact> filtered = [];
    if (query.isNotEmpty) {
      filtered = _contacts.where((contact) =>
          contact.displayName!.toLowerCase().startsWith(query.toLowerCase())).toList();
    } else {
      filtered = List.from(_contacts);
    }
    setState(() {
      _filteredContacts = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _searchController,
            onChanged: _filterContacts,
            decoration: const InputDecoration(
              hintText: 'SEARCH',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              suffixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          if (_filteredContacts.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = _filteredContacts[index];
                  String? phone = contact.phones!.isNotEmpty ? contact.phones?.first.value : null;
                  return ListTile(
                    title: Text(contact.displayName ?? ''),
                    subtitle: Text(phone ?? ''),
                  );
                },
              ),
            ),
          if (_filteredContacts.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No contacts found',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }
}