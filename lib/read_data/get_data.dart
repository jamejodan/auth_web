import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatelessWidget {
  final String documentId;

  const GetUserData({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['first name']}' + ' ' + '${data['last name']}');
        } else {
          return const Center(
            child: Text('Loading...'),
          );
        }
      }),
    );
  }
}
