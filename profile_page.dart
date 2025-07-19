import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController languagesController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();

  bool showProfilePic = false; // Toggle for profile picture

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (showProfilePic)
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.png'), // Optional default image
              ),
            TextButton(
              onPressed: () {
                setState(() {
                  showProfilePic = !showProfilePic;
                });
              },
              child: Text(
                showProfilePic ? "Remove Profile Picture" : "Add Profile Picture",
              ),
            ),
            const SizedBox(height: 20),
            buildTextField("Name", nameController),
            const SizedBox(height: 10),
            buildTextField("Languages Known", languagesController),
            const SizedBox(height: 10),
            buildTextField("Date of Birth", dobController),
            const SizedBox(height: 10),
            buildTextField("Education Qualification", qualificationController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save logic here (Firebase or local state)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile details saved")),
                );
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }
}
