import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String? userName;
  String? imageUrl;
  String? email;
  String? password;

  Stream<UserData?> get userDataStream async* {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDocument =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      yield* userDocument.snapshots().map((userSnapshot) {
        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;
          userName = userData['userName'];
          imageUrl = userData['imageUrl'];
          email = userData['email'];
          password = userData['password'];
          return this;
        } else {
          return null;
        }
      });
    } else {
      yield null;
    }
  }
}
