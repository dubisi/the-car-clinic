import 'package:carclinicapp/controller/profile/profile_body.dart';
import 'package:carclinicapp/controller/profile/profile_cars.dart';
import 'package:carclinicapp/model/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    String email = context.watch<Auth>().getEmail();
    return DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 69.5, 0, 0),
                    child: FlexibleSpaceBar(
                        background: Column(
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ProfileBody(),
                            const SizedBox(width: 15),
                            Column(
                              children: [
                                const Text("hlayi small"),
                                const SizedBox(height: 5),
                                Text(email),
                                const SizedBox(height: 5),
                                const Text("+27 72 265 1415")
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                  pinned: true,
                  backgroundColor: Colors.green,
                  expandedHeight: 200,
                  title: const Text("Profile"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit_profile');
                        },
                        icon: const Icon(Icons.edit)),
                    const SizedBox(
                      width: 2,
                    )
                  ],
                  // flexibleSpace: AppBar(title: const Text("shit")),
                  bottom: const TabBar(
                    indicatorColor: Colors.green,
                    tabs: [
                      Text("My cars"),
                      Text("My Address"),
                      Text("My Offers")
                    ],
                  ),
                )
              ];
            },
            body: const TabBarView(
              children: [
                Center(child: ProfileCars()),
                Center(child: Text("address")),
                Center(child: Text("No available offers"))
              ],
            )));
  }
}
