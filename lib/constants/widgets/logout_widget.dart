import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/routs_name.dart';
import '../../global.dart';

Future<void> logOut(
    {required BuildContext context, required bool isonline}) async {
  if (isonline) {
    Future.delayed(
      Duration.zero,
      () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: const Text('Are you sure to Exit?'),
            actions: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      await Global.storageServices.setLoggedIn(false);
                      Future.delayed(
                        Duration.zero,
                        () => Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRouts.loginRout,
                          (route) => false,
                        ),
                      );
                    },
                    child: const Text('  Yes  '),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text('You can only logout when online.'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
