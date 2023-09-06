import 'package:chat/constants/widgets/media_query.dart';
import 'package:flutter/material.dart';

import '../../constants/widgets/users_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = UserData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: StreamBuilder<UserData?>(
        stream: userData.userDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: CustomMediaQuery(context).screenHeight / 40,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(userData.imageUrl!),
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: CustomMediaQuery(context).screenHeight / 60,
                ),
                Center(
                  child: Text(userData.userName!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
