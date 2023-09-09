import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/widgets/flutter_toast.dart';

class GetAllUsers extends StatelessWidget {
  const GetAllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final streamDate =
        FirebaseFirestore.instance.collection('Users').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: StreamBuilder(
        stream: streamDate,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            toastInfo(msg: 'Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userDocs = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: userDocs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  trailing: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            userDocs[index]['imageUrl'],
                          ),
                        ),
                      ),
                    ),
                    // child: Image.network(userDocs[index]['imageUrl']),
                  ),
                  title: Text(
                    userDocs[index]['userName'],
                    textAlign: TextAlign.right,
                  ),
                  subtitle: Text(
                    userDocs[index]['email'],
                    textAlign: TextAlign.right,
                  ),
                  leading: const Text('2:00'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
