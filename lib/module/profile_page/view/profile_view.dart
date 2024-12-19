import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getX;
import 'package:glowshoess.id/core.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Default index for Profile
  final EditProfileController controller =
      getX.Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    // Load profile data when the page initializes
    controller.loadProfile(
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the respective pages based on index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageView()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HistoryPage()),
        );
        break;
      case 3:
        // Already on Profile page, no action needed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF29D6C8),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePageView()),
            );
          },
        ),
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFF29D6C8),
            padding:
                EdgeInsets.only(top: 30, bottom: 40, right: 135, left: 139),
            child: getX.Obx(() {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          controller.profile['photoPath']?.value.isNotEmpty ??
                                  false
                              ? FileImage(
                                  File(controller.profile['photoPath']!.value))
                              : AssetImage('assets/profile-placeholder.png')
                                  as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    controller.profile['name']?.value ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    controller.profile['email']?.value ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        leading: Icon(Icons.person_outline, color: Colors.teal),
                        title: Text('Edit User Profile'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          getX.Get.to(() => EditProfilePage());
                        },
                      ),
                      Divider(height: 1, thickness: 1),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        leading:
                            Icon(Icons.settings_outlined, color: Colors.teal),
                        title: Text('Settings'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          getX.Get.to(() => SettingsPage());
                        },
                      ),
                      Divider(height: 1, thickness: 1),
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        leading: Icon(Icons.phone_outlined, color: Colors.teal),
                        title: Text('Call Center'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          getX.Get.to(WebViewPage(
                              url:
                                  'https://www.instagram.com/glowshoess.id/'));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('asset/home.png', width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/cart-icon.png', width: 24, height: 24),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/history-icon.png', width: 24, height: 24),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/user-icon.png', width: 24, height: 24),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
