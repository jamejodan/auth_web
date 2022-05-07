import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_test/read_data/get_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docID = [];

  Future getDocs() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          // ignore: avoid_function_literals_in_foreach_calls
          (snapshot) => snapshot.docs.forEach(
            (element) {
              //print(element.reference);
              docID.add(element.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    getDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Auth'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDocs(),
              builder: (context, snapshot) => ListView.builder(
                itemCount: docID.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    title: GetUserData(
                      documentId: docID[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
