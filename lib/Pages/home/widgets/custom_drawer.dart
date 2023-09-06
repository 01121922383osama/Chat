// ignore_for_file: unnecessary_cast

import 'package:chat/constants/widgets/app_colors.dart';
import 'package:chat/constants/widgets/media_query.dart';
import 'package:chat/core/routs_name.dart';
import 'package:flutter/material.dart';

import '../../../constants/widgets/logout_widget.dart';
import '../../../constants/widgets/users_data.dart';
import '../../../constants/widgets/widget_build_listtile.dart';

class CusttomDrawer extends StatelessWidget {
  final bool isOnlline;
  const CusttomDrawer({
    Key? key,
    required this.isOnlline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = UserData();
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.background.withOpacity(1),
        elevation: 0,
        child: StreamBuilder<UserData?>(
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

            final updatedUserData = snapshot.data;

            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: CustomMediaQuery(context).screenHeight / 15,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 30,
                        child: Container(
                          /*
                         updatedUserData?.imageUrl != null
                          ? Image.network(updatedUserData!.imageUrl!)
                          : Container(),
                        */
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: updatedUserData?.imageUrl != null
                                  ? NetworkImage(updatedUserData!.imageUrl!)
                                      as ImageProvider<Object>
                                  : const AssetImage(
                                          'assets/images/defultchat.png')
                                      as ImageProvider<Object>,
                              fit: BoxFit
                                  .cover, // You can adjust the fit as needed
                            ),
                          ),
                        )),
                    title: Text(updatedUserData?.userName ?? 'User'),
                    subtitle: Text(isOnlline ? 'Online' : 'OffLine'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  buildListile(
                    text: 'Profile',
                    iconData: Icons.person,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouts.profilePage);
                    },
                  ),
                  buildListile(
                    text: 'Service center',
                    iconData: Icons.announcement_rounded,
                    onTap: () {},
                  ),
                  buildListile(
                    text: 'All Users',
                    iconData: Icons.supervised_user_circle_sharp,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouts.getAllUsers);
                    },
                  ),
                  buildListile(
                    text: 'Setting',
                    iconData: Icons.settings,
                    onTap: () {},
                  ),
                  buildListile(
                    text: 'Logout',
                    iconData: Icons.logout,
                    onTap: () => logOut(context: context, isonline: isOnlline),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
