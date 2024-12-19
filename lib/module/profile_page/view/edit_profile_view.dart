import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowshoess.id/module/profile_page/controller/edit_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Load profile dan set nilai awal TextEditingController
    controller.loadProfile(
        emailController, nameController, phoneController, addressController);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Profile'),
        actions: [
          TextButton(
            onPressed: () {
              controller.saveProfile(
                emailController.text,
                nameController.text,
                phoneController.text,
                addressController.text,
              );
            },
            child: Text('Save', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Obx(() {
            // Jika profileImage kosong, tampilkan placeholder
            return CircleAvatar(
              radius: 50,
              backgroundImage: controller.profileImage.value != null
                  ? FileImage(controller.profileImage.value!)
                  : AssetImage('assets/profile_placeholder.png')
                      as ImageProvider,
            );
          }),
          TextButton.icon(
            onPressed: () {
              controller.selectProfileImage();
            },
            icon: Icon(Icons.camera_alt),
            label: Text('Change Photo'),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your new email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter your new phone number',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              hintText: 'Enter your new address',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
